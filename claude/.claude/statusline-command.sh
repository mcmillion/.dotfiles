#!/bin/bash

input=$(cat)

# Single jq call to extract all fields
eval "$(echo "$input" | jq -r '
  @sh "cwd=\(.cwd // empty)",
  @sh "model=\(.model.display_name // .model // empty)",
  @sh "ctx_pct=\(.context_window.used_percentage // 0)",
  @sh "five_pct=\(.rate_limits.five_hour.used_percentage // empty)",
  @sh "five_reset=\(.rate_limits.five_hour.resets_at // empty)",
  @sh "seven_pct=\(.rate_limits.seven_day.used_percentage // empty)",
  @sh "seven_reset=\(.rate_limits.seven_day.resets_at // empty)"
')"

# ANSI colors
blue='\033[0;34m'
yellow='\033[0;33m'
gray='\033[0;37m'
dim='\033[0;90m'
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'
sep="${gray} · ${reset}"

# Whole days until a reset timestamp, rounded up, e.g. 3d
fmt_days_remaining() {
  local val="$1" epoch diff
  case "$val" in
    ''|*[!0-9]*)
      epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$val" "+%s" 2>/dev/null) || return
      ;;
    *) epoch="$val" ;;
  esac
  diff=$(( epoch - $(date +%s) ))
  [ "$diff" -lt 0 ] && diff=0
  printf '%dd' $(( (diff + 86399) / 86400 ))
}

# Time remaining until a reset timestamp, e.g. 4h31m
fmt_remaining() {
  local val="$1" epoch diff
  case "$val" in
    ''|*[!0-9]*)
      epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$val" "+%s" 2>/dev/null) || return
      ;;
    *) epoch="$val" ;;
  esac
  diff=$(( epoch - $(date +%s) ))
  [ "$diff" -lt 0 ] && diff=0
  local h=$(( diff / 3600 )) m=$(( (diff % 3600) / 60 ))
  if [ "$h" -gt 0 ]; then
    printf '%dh%dm' "$h" "$m"
  else
    printf '%dm' "$m"
  fi
}

# Build a labeled bar: label ▰▰▰▱▱▱ NN%
bar() {
  local label="$1" pct="$2" width=10
  local filled=$(( (pct * width + 50) / 100 ))
  local empty=$(( width - filled ))
  local color="$green"
  [ "$pct" -ge 50 ] && color="$yellow"
  [ "$pct" -ge 80 ] && color="$red"
  local b=""
  for ((i=0; i<filled; i++)); do b+="━"; done
  for ((i=0; i<empty; i++)); do b+="${dim}┄"; done
  printf '%b%s %b%s%b %b%d%%%b' \
    "$gray" "$label" "$color" "$b" "$reset" \
    "$gray" "$pct" "$reset"
}

# Rolling ccusage spend (today / last 7 days) for API-billed sessions
# (no subscription rate limits in the input), cached + background-refreshed
# so the status line never blocks on ccusage (~0.5s/call).
cc_cache_dir="$HOME/.cache/claude-statusline"
cc_cache="$cc_cache_dir/ccusage"
cc_lock="$cc_cache_dir/ccusage.lock"
cc_ttl=600

cc_refresh() {
  # reclaim an orphaned lock left by a refresh that was killed mid-run
  if [ -d "$cc_lock" ]; then
    lock_mtime=$(stat -c %Y "$cc_lock" 2>/dev/null || stat -f %m "$cc_lock" 2>/dev/null)
    [ -n "$lock_mtime" ] && [ $(( $(date +%s) - lock_mtime )) -ge "$cc_ttl" ] && \
      rmdir "$cc_lock" 2>/dev/null
  fi
  mkdir "$cc_lock" 2>/dev/null || return  # another refresh in flight
  local d1 d7 day wk
  d1=$(date +%Y%m%d)
  d7=$(date -v-6d +%Y%m%d 2>/dev/null || date -d '6 days ago' +%Y%m%d)
  day=$(ccusage daily --since "$d1" --json 2>/dev/null | jq -r '.totals.totalCost // 0')
  wk=$(ccusage daily --since "$d7" --json 2>/dev/null | jq -r '.totals.totalCost // 0')
  [ -n "$day" ] && [ -n "$wk" ] && \
    printf '%s %s\n' "$day" "$wk" > "$cc_cache.tmp" && mv "$cc_cache.tmp" "$cc_cache"
  rmdir "$cc_lock" 2>/dev/null
}

cc_costs=""
if [ -z "$five_pct" ] && [ -z "$seven_pct" ] && command -v ccusage >/dev/null 2>&1; then
  mkdir -p "$cc_cache_dir"
  age=$cc_ttl
  if [ -f "$cc_cache" ]; then
    mtime=$(stat -c %Y "$cc_cache" 2>/dev/null || stat -f %m "$cc_cache" 2>/dev/null)
    [ -n "$mtime" ] && age=$(( $(date +%s) - mtime ))
  fi
  if [ "$age" -ge "$cc_ttl" ]; then
    ( cc_refresh ) >/dev/null 2>&1 &
  fi
  [ -f "$cc_cache" ] && cc_costs=$(cat "$cc_cache")
fi

# Path display: root at the git repo when inside one, else abbreviate
# home with ~ (handles ostree /var/home vs /home symlink)
if [ -n "$cwd" ]; then
  toplevel=$(git --no-optional-locks -C "$cwd" \
    rev-parse --show-toplevel 2>/dev/null)
  if [ -n "$toplevel" ]; then
    display_dir=$(basename "$toplevel")
    # linked worktrees have .git as a file; include the parent folder so
    # worktrees read as repo/worktree-name
    [ -f "$toplevel/.git" ] && \
      display_dir="$(basename "$(dirname "$toplevel")")/$display_dir"
    rel=$(git --no-optional-locks -C "$cwd" \
      rev-parse --show-prefix 2>/dev/null)
    rel="${rel%/}"
    [ -n "$rel" ] && display_dir="${display_dir}/${rel}"
  else
    display_dir="$cwd"
    for home_prefix in "$HOME" /var/home/mlm /home/mlm /Users/mlm; do
      [ -n "$home_prefix" ] || continue
      if [ "$cwd" = "$home_prefix" ]; then
        display_dir="~"
        break
      fi
      if [ "${cwd#"$home_prefix"/}" != "$cwd" ]; then
        display_dir="~/${cwd#"$home_prefix"/}"
        break
      fi
    done
  fi
else
  display_dir="~"
fi

# Get git branch and status if in a repo
branch=""
git_status=""
if [ -n "$cwd" ]; then
  branch=$(git --no-optional-locks -C "$cwd" \
    rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    porcelain=$(git --no-optional-locks -C "$cwd" \
      status --porcelain 2>/dev/null)
    staged=$(echo "$porcelain" | grep -c '^[MADRC]')
    unstaged=$(echo "$porcelain" | grep -c '^.[MD]')
    untracked=$(echo "$porcelain" | grep -c '^??')
    parts=""
    [ "$staged" -gt 0 ]    && parts="${parts}+"
    [ "$unstaged" -gt 0 ]  && parts="${parts}!"
    [ "$untracked" -gt 0 ] && parts="${parts}?"
    [ -n "$parts" ] && git_status="[$parts]"
  fi
fi

# Build output
output="${blue}${display_dir}${reset}"

if [ -n "$branch" ]; then
  output="${output}${sep}${yellow}${branch}${reset}"
  [ -n "$git_status" ] && output="${output} ${red}${git_status}${reset}"
fi

if [ -n "$model" ]; then
  output="${output}${sep}${gray}${model}${reset}"
fi

pct=$(printf "%.0f" "$ctx_pct")
output="${output}${sep}$(bar ctx "$pct")"

if [ -n "$five_pct" ] || [ -n "$seven_pct" ]; then
  if [ -n "$five_pct" ]; then
    pct=$(printf "%.0f" "$five_pct")
    output="${output}${sep}$(bar 5h "$pct")"
    if [ -n "$five_reset" ]; then
      t=$(fmt_remaining "$five_reset")
      [ -n "$t" ] && output="${output} (${t})"
    fi
  fi
  if [ -n "$seven_pct" ]; then
    pct=$(printf "%.0f" "$seven_pct")
    output="${output}${sep}$(bar 7d "$pct")"
    if [ -n "$seven_reset" ]; then
      d=$(fmt_days_remaining "$seven_reset")
      [ -n "$d" ] && output="${output} (${d})"
    fi
  fi
elif [ -n "$cc_costs" ]; then
  cc_day="${cc_costs%% *}"
  cc_wk="${cc_costs##* }"
  output="${output}${sep}${gray}d \$$(printf '%.2f' "$cc_day") · w \$$(printf '%.2f' "$cc_wk")${reset}"
fi

echo -e "$output"
