#!/bin/bash

# Claude Code hook to send notifications to tmux status bar
# Receives JSON input from Claude's hook system via stdin

# Check if tmux is running
if ! command -v tmux >/dev/null 2>&1; then
  exit 0
fi

# Check if we're in a tmux session
if [ -z "$TMUX" ]; then
  exit 0
fi

# Read JSON input from stdin
input=$(cat)

# Extract the message from the JSON input (basic extraction)
# This handles the common case where there's a message field
message=$(echo "$input" | grep -o '"message"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"message"[[:space:]]*:[[:space:]]*"\(.*\)"/\1/')

# If no message field, try to extract a notification or use a generic message
if [ -z "$message" ]; then
  message="Claude needs attention"
fi

# Get the current tmux session name
session_name=$(tmux display-message -p "#{session_name}")

# Format the notification message
notification_text=" [$session_name] $message"

# Display the message in tmux (shows for 5 seconds) and play system sound
tmux display-message -d 5000 "$notification_text"
# Play macOS system sound (works regardless of terminal bell support)
/usr/bin/afplay /System/Library/Sounds/Blow.aiff 2>/dev/null &