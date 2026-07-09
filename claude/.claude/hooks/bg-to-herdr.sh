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

# Capture output to a logfile Claude can read, while still streaming live to the
# pane. The command goes into a wrapper script (avoids quoting hell with $cmd):
# it tees stdout+stderr to the log, records the exit code as a sentinel line, and
# closes the pane on success (log persists on disk either way).
logdir="${TMPDIR:-/tmp}/claude-herdr-bg"
mkdir -p "$logdir"
stamp=$(date +%Y%m%d-%H%M%S)-$$-${RANDOM}
wrapper="$logdir/bg-$stamp.sh"
log="$logdir/bg-$stamp.log"

{
  printf '#!/usr/bin/env bash\n'
  printf 'set -o pipefail\n'
  printf '{\n'
  printf '%s\n' "$cmd"
  printf '} 2>&1 | tee %q\n' "$log"
  printf 'ec=${PIPESTATUS[0]}\n'
  printf 'printf "__BG_EXIT=%%s__\\n" "$ec" >> %q\n' "$log"
  printf '[ "$ec" -eq 0 ] && herdr pane close %q >/dev/null 2>&1\n' "$pane"
  printf 'exit "$ec"\n'
} > "$wrapper"

# herdr pane run returns immediately; the wrapper runs inside the pane.
herdr pane run "$pane" "bash $(printf '%q' "$wrapper")" >/dev/null 2>&1 || exit 0

# Handled in a real pane -> block Claude's hidden background shell, but hand Claude
# the captured-output path so it can read the result instead of re-running.
reason="Ran in a visible herdr pane (live output shows there). A captured copy of stdout+stderr is at: $log -- read that file to see output. When the command finishes the log ends with a line '__BG_EXIT=<code>__' (present = done, absent = still running). Do NOT re-run this in the background; read the log instead."
jq -n --arg r "$reason" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'
