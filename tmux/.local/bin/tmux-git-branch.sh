#!/bin/bash

# Get the current pane's working directory
pane_pid=$(tmux display-message -p '#{pane_pid}')
pane_path=$(tmux display-message -p '#{pane_current_path}')

# Check if we're in a git repository
if git -C "$pane_path" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$pane_path" symbolic-ref --short HEAD 2>/dev/null || git -C "$pane_path" describe --tags --exact-match 2>/dev/null || git -C "$pane_path" rev-parse --short HEAD 2>/dev/null)
  echo "($branch)"
else
  echo ""
fi
