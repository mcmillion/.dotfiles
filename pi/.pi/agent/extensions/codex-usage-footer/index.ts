import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { registerCodexUsage } from "./codex-usage.ts";

/** Adds Codex rate-limit usage to the Powerline footer. */
export default function (pi: ExtensionAPI) {
  // Herdr advertises TERM=xterm-256color, so Powerline otherwise selects its
  // ASCII `.` separator. Its Unicode middle-dot separator matches the one used
  // by the Codex-usage status itself.
  process.env.POWERLINE_NERD_FONTS = "1";

  registerCodexUsage(pi);
}
