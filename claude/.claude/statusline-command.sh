#!/bin/bash

# Read JSON input
input=$(cat)

# Extract data from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
git_branch=$(cd "$current_dir" 2>/dev/null && git branch --show-current 2>/dev/null)

# Get git status if we're in a git repo
git_status=""
if [ -n "$git_branch" ]; then
    cd "$current_dir" 2>/dev/null || exit 1
    
    # Check for unpushed commits
    unpushed_count=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
    
    # Use git status --porcelain for reliable parsing
    git_output=$(git status --porcelain 2>/dev/null)
    status_parts=""
    
    if [ -n "$git_output" ]; then
        staged=$(echo "$git_output" | grep -c "^[MADRC]")
        modified=$(echo "$git_output" | grep -c "^.[MD]")
        untracked=$(echo "$git_output" | grep -c "^??")
        
        [ "$modified" -gt 0 ] && status_parts="${status_parts}!"
        [ "$staged" -gt 0 ] && status_parts="${status_parts}+"
        [ "$untracked" -gt 0 ] && status_parts="${status_parts}?"
    fi
    
    # Add unpushed commits indicator at the end
    [ "$unpushed_count" -gt 0 ] && status_parts="${status_parts}⇡"
    
    if [ -n "$status_parts" ]; then
        git_status=$(printf " \033[31m[%s]\033[0m" "$status_parts")
    fi
fi

# Get ccusage output using statusline command with no emoji burn rate
ccusage_output=$(echo "$input" | ccusage statusline --visual-burn-rate=text 2>/dev/null | tr -d '\n' 2>/dev/null || echo '')

# Build and print the status line using printf for proper ANSI handling
printf "\033[34m%s\033[0m" "$(basename "$current_dir")"

if [ -n "$git_branch" ]; then
    printf " \033[33m%s\033[0m%s" "$git_branch" "$git_status"
fi

if [ -n "$ccusage_output" ]; then
    printf " \033[37m| %s\033[0m" "$ccusage_output"
fi