#!/bin/bash

# Read JSON input
input=$(cat)

# Extract data from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
git_branch=$(cd "$current_dir" 2>/dev/null && git branch --show-current 2>/dev/null)


# Get ccusage output using statusline command with no emoji burn rate
ccusage_output=$(echo "$input" | ccusage statusline --visual-burn-rate=text 2>/dev/null | tr -d '\n' 2>/dev/null || echo '')

# Build and print the status line using printf for proper ANSI handling
printf "\033[34m%s\033[0m" "$(basename "$current_dir")"

if [ -n "$git_branch" ]; then
    printf " \033[33m%s\033[0m" "$git_branch"
fi

if [ -n "$ccusage_output" ]; then
    printf " \033[37m| %s\033[0m" "$ccusage_output"
fi