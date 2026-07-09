#!/usr/bin/env bash
# Redirect Claude's background Bash commands into a visible herdr split pane.
# Fires on every Bash call but only acts when run_in_background is true, so
# foreground commands pass through untouched. Splits the CALLING pane (pinned
# via HERDR_PANE_ID, inherited down the process tree) to the right.
set -uo pipefail

input=$(cat)

command -v jq    >/dev/null 2>&1 || exit 0
command -v herdr >/dev/null 2>&1 || exit 0
[ "${HERDR_ENV:-}" = "1" ]       || exit 0   # only inside herdr
[ -n "${HERDR_PANE_ID:-}" ]      || exit 0   # need our own pane id

bg=$(printf '%s' "$input" | jq -r '.tool_input.run_in_background // false')
[ "$bg" = "true" ] || exit 0                 # only backgrounded commands

cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
[ -n "$cmd" ] || exit 0

# Split the calling Claude's own pane downward; ratio 0.25 makes the top slot 25%.
split=(pane split --pane "$HERDR_PANE_ID" --direction down --ratio 0.25 --no-focus)
[ -n "$cwd" ] && split+=(--cwd "$cwd")

pane=$(herdr "${split[@]}" 2>/dev/null | jq -r '.result.pane.pane_id // empty')
[ -n "$pane" ] || exit 0                      # split failed -> let Claude run it normally

# Swap so the new pane takes the top 25% slot and Claude drops to the bottom 75%.
herdr pane swap --source-pane "$HERDR_PANE_ID" --target-pane "$pane" >/dev/null 2>&1

# Run it, then close the pane on success; on failure leave it up to read the error.
herdr pane run "$pane" "$cmd && herdr pane close $pane" >/dev/null 2>&1 || exit 0

# Handled in a real pane -> block Claude's hidden background shell.
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Launched in a visible herdr split pane for the user instead of a hidden background shell. Output is NOT captured here - do not re-run or retry this command in the background. If you need its output, ask the user to check the herdr pane."}}
JSON
