import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { readFile } from "node:fs/promises";
import { homedir } from "node:os";
import { join } from "node:path";

const STATUS_KEY = "mlm-codex-usage";
const REFRESH_INTERVAL_MS = 60_000;
const USAGE_URL = "https://chatgpt.com/backend-api/wham/usage";

type WindowUsage = {
  used_percent?: number;
  limit_window_seconds?: number;
  reset_after_seconds?: number;
};

type UsageResponse = {
  rate_limit?: {
    primary_window?: WindowUsage | null;
    secondary_window?: WindowUsage | null;
  };
};

type CodexAuth = {
  access?: string;
  accountId?: string;
};

function formatDuration(seconds: number): string {
  const totalMinutes = Math.max(0, Math.ceil(seconds / 60));
  const hours = Math.floor(totalMinutes / 60);
  const minutes = totalMinutes % 60;

  if (hours > 0) return `${hours}h${minutes}m`;
  return `${minutes}m`;
}

function formatResetDate(seconds: number): string {
  return new Intl.DateTimeFormat(undefined, {
    month: "short",
    day: "numeric",
  }).format(new Date(Date.now() + Math.max(0, seconds) * 1_000));
}

function formatWindowLabel(seconds: number | undefined, fallback: string): string {
  if (!seconds) return fallback;
  if (seconds % 86_400 === 0) return `${seconds / 86_400}d`;
  if (seconds % 3_600 === 0) return `${seconds / 3_600}h`;
  return `${Math.round(seconds / 60)}m`;
}

function formatWindow(
  window: WindowUsage | null | undefined,
  fallbackLabel: string,
  ctx: ExtensionContext,
): string | undefined {
  if (!window || typeof window.used_percent !== "number") return undefined;

  const percent = Math.round(window.used_percent);
  const color = percent >= 80 ? "error" : percent >= 50 ? "warning" : "success";
  const label = formatWindowLabel(window.limit_window_seconds, fallbackLabel);
  const reset = typeof window.reset_after_seconds === "number"
    ? ctx.ui.theme.fg(
      "dim",
      ` (${window.limit_window_seconds && window.limit_window_seconds >= 86_400
        ? formatResetDate(window.reset_after_seconds)
        : formatDuration(window.reset_after_seconds)})`,
    )
    : "";

  return ctx.ui.theme.fg("dim", `${label} `) + ctx.ui.theme.fg(color, `${percent}%`) + reset;
}

async function getAuth(): Promise<CodexAuth | undefined> {
  const agentDir = process.env.PI_CODING_AGENT_DIR ?? join(homedir(), ".pi", "agent");
  const credentials = JSON.parse(await readFile(join(agentDir, "auth.json"), "utf8")) as Record<string, CodexAuth>;
  return credentials["openai-codex"];
}

async function fetchUsage(signal: AbortSignal): Promise<UsageResponse | undefined> {
  const auth = await getAuth();
  if (!auth?.access) return undefined;

  const headers: Record<string, string> = { Authorization: `Bearer ${auth.access}` };
  if (auth.accountId) headers["ChatGPT-Account-Id"] = auth.accountId;

  const response = await fetch(USAGE_URL, { headers, signal });
  if (!response.ok) return undefined;
  return await response.json() as UsageResponse;
}

export function registerCodexUsage(pi: ExtensionAPI) {
  let controller: AbortController | undefined;
  let refreshTimer: ReturnType<typeof setInterval> | undefined;
  let refreshCurrent: (() => void) | undefined;

  pi.on("session_start", (_event, ctx) => {
    const sessionController = new AbortController();
    let refreshing = false;
    controller = sessionController;

    const refresh = async () => {
      if (refreshing || sessionController.signal.aborted) return;
      refreshing = true;

      try {
        const usage = await fetchUsage(sessionController.signal);
        if (controller !== sessionController) return;

        const rateLimit = usage?.rate_limit;
        const windows = [
          formatWindow(rateLimit?.primary_window, "5h", ctx),
          formatWindow(rateLimit?.secondary_window, "7d", ctx),
        ].filter((value): value is string => Boolean(value));

        ctx.ui.setStatus(STATUS_KEY, windows.length > 0 ? windows.join(" · ") : undefined);
      } catch {
        // The endpoint is unavailable when the OAuth session expires or ChatGPT changes it.
        // Keep the footer quiet rather than surfacing a non-actionable network error.
      } finally {
        refreshing = false;
      }
    };

    refreshCurrent = () => void refresh();
    refreshCurrent();
    refreshTimer = setInterval(refreshCurrent, REFRESH_INTERVAL_MS);
  });

  // Fetch immediately after Codex responses, then poll while idle so reset countdowns stay fresh.
  pi.on("after_provider_response", (_event, ctx) => {
    if (ctx.model?.provider === "openai-codex") refreshCurrent?.();
  });

  pi.on("session_shutdown", () => {
    controller?.abort();
    controller = undefined;
    if (refreshTimer) clearInterval(refreshTimer);
    refreshTimer = undefined;
    refreshCurrent = undefined;
  });
}
