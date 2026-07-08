---
name: commit
description: Create atomic git commits from outstanding changes with terse, imperative messages. Pass --push to also push to the remote. Use when the user asks to commit (e.g. /commit, "commit this") or commit and push (e.g. /commit --push, "push this", "commit and push").
argument-hint: "[--push]"
allowed-tools:
  - Bash
  - Read
  - Grep
---

# Create a new commit with outstanding changes

- ALWAYS run `git status` first to get a fresh view of the current repo state before doing anything else
- ALWAYS analyze changes to create atomic commits grouping related changes together
- If changes are unrelated, create multiple commits (one per logical change)
- ALWAYS summarize actual changes made in files, not from context or history
- Use subject + body format: short subject line (50 chars max) with bullet points below when needed
- Keep messages terse and direct - no emojis, no decorations, no filler words
- Use imperative mood ("Fix bug" not "Fixed bug")
- NEVER add Claude attribution, author, or co-author information
- DO NOT mention CI-enforced items (tests, linting, types) unless they required manual fixes
- Do not report a commit as complete if there are uncommitted changes

## --push modifier

- Without `--push`: NEVER push to remote - only commit locally
- With `--push`: after committing, push to the remote repository, then verify the push succeeded and confirm the correct branch before reporting completion
