#!/bin/bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // .model // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# ANSI colors
blue='\033[0;34m'
yellow='\033[0;33m'
gray='\033[0;37m'
red='\033[0;31m'
reset='\033[0m'
sep="${gray} · ${reset}"

# Abbreviate home directory with ~
home="$HOME"
if [ -n "$cwd" ]; then
  display_dir="${cwd/#$home/~}"
else
  display_dir="~"
fi

# Get git branch and status if in a repo
branch=""
git_status=""
if [ -n "$cwd" ]; then
  branch=$(git --no-optional-locks -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    porcelain=$(git --no-optional-locks -C "$cwd" status --porcelain 2>/dev/null)
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
  if [ -n "$git_status" ]; then
    output="${output} ${red}${git_status}${reset}"
  fi
fi

if [ -n "$model" ]; then
  output="${output}${sep}${gray}${model}${reset}"
fi

if [ -n "$used_pct" ]; then
  pct=$(printf "%.0f" "$used_pct")
  output="${output}${sep}${gray}${pct}%${reset}"
fi

echo -e "$output"
