# Create a new commit with outstanding changes

- ALWAYS run `git status` first to get a fresh view of the current repo state before doing anything else
- ALWAYS use the git-expert subagent
- ALWAYS analyze changes to create atomic commits grouping related changes together
- If changes are unrelated, create multiple commits (one per logical change)
- ALWAYS summarize actual changes made in files, not from context or history
- Use subject + body format: short subject line (50 chars max) with bullet points below when needed
- Keep messages terse and direct - no emojis, no decorations, no filler words
- Use imperative mood ("Fix bug" not "Fixed bug")
- NEVER add Claude attribution, author, or co-author information
- NEVER push to remote - only commit locally
- DO NOT mention CI-enforced items (tests, linting, types) unless they required manual fixes
