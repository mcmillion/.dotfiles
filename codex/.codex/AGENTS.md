Be extremely concise. Sacrifice grammar for the sake of concision.

# Personal Global Codex Setup

## General Behavior

- Default to implementing requested changes instead of only analyzing
- When the request is investigation or review, report findings first and wait unless asked to patch
- Prefer practical changes over speculative refactors

## Git

- Keep commit messages short and terse
- NEVER include yourself as a co-author in a commit
- Do not mention checks in commit messages unless they materially explain the change
- Run `git status` before committing
- Do not report a commit as complete if there are uncommitted changes
- After a rebase, push unless explicitly told not to
- Verify the push succeeded and confirm the branch before reporting completion

## Code Quality

- After generating or editing code, run relevant lint, format, and typecheck/test commands when they exist
- Fix issues you introduced before presenting work as done
- If verification cannot be run, say so explicitly

## Debugging

- Read the actual failing output before proposing fixes
- Do not guess at causes when logs or failing tests can answer it
- If 2 fix attempts fail, reconsider the root cause

## TypeScript and React

- ALWAYS strict mode
- Format with 2 space indent
- Try to keep lines to 80 if possible, no more than 100
- Prefer functional style over OOP when practical
- Prefer immutability when practical
- Use interfaces rather than types unless types are needed
- Do not inline complex argument or return types
- For functions with multiple arguments, prefer an object parameter

## MCP Servers

- User-scoped MCP servers go in `~/.codex/config.toml`
- Project-scoped MCP servers should stay in repo-local config where possible
- NEVER hardcode secrets or tokens in MCP configs; reference env vars from shell config

## File Handling

- ALWAYS use unix line endings
- ALWAYS end files with a newline
