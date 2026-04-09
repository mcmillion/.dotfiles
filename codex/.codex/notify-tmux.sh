#!/bin/bash

if ! command -v tmux >/dev/null 2>&1; then
  exit 0
fi

if [ -z "$TMUX" ]; then
  exit 0
fi

input=$(cat)

message=$(echo "$input" | grep -o '"message"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/"message"[[:space:]]*:[[:space:]]*"\(.*\)"/\1/')

if [ -z "$message" ]; then
  message="Codex needs attention"
fi

session_name=$(tmux display-message -p "#{session_name}")
window_name=$(tmux display-message -p "#{window_name}")
notification_text=" [$session_name/$window_name] $message"

tmux display-message -d 5000 "$notification_text"
/usr/bin/afplay /System/Library/Sounds/Blow.aiff 2>/dev/null &
