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
  @sh "seven_reset=\(.rate_limits.seven_day.resets_at // empty)",
  @sh "cost_usd=\(.cost.total_cost_usd // empty)"
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

fmt_reset() {
  local val="$1" fmt="$2" epoch
  case "$val" in
    ''|*[!0-9]*)
      epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$val" "+%s" 2>/dev/null) || return
      ;;
    *) epoch="$val" ;;
  esac
  date -r "$epoch" "+$fmt"
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

# Abbreviate home directory with ~
if [ -n "$cwd" ]; then
  display_dir="${cwd/#$HOME/~}"
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
      t=$(fmt_reset "$five_reset" "%-I:%M%p")
      [ -n "$t" ] && output="${output} (${t})"
    fi
  fi
  if [ -n "$seven_pct" ]; then
    pct=$(printf "%.0f" "$seven_pct")
    output="${output}${sep}$(bar 7d "$pct")"
    if [ -n "$seven_reset" ]; then
      d=$(fmt_reset "$seven_reset" "%b %-d")
      [ -n "$d" ] && output="${output} (${d})"
    fi
  fi
elif [ -n "$cost_usd" ] && [ "$cost_usd" != "0" ]; then
  output="${output}${sep}${gray}\$$(printf '%.2f' "$cost_usd")${reset}"
fi

echo -e "$output"
