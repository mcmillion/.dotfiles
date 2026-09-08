import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const displayValue: Record<string, string> = {
	off: "off",
	minimal: "min",
	low: "low",
	medium: "med",
	high: "high",
	xhigh: "xhi",
	max: "max",
};

function setThinkingStatus(level: string, ctx: { ui: { setStatus(key: string, value: string): void } }) {
	ctx.ui.setStatus("thinking-value", displayValue[level] ?? level);
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		setThinkingStatus(ctx.thinkingLevel ?? "off", ctx);
	});

	pi.on("thinking_level_select", (event, ctx) => {
		setThinkingStatus(event.level, ctx);
	});
}
