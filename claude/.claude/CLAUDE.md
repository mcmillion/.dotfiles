Be extremely concise. Sacrifice grammar for the sake of concision.

# Personal Global Claude Setup

## General Behavior

- Do NOT attempt fixes or implementation unless explicitly asked
- When investigating issues, report findings and wait for instructions
- Investigation ≠ permission to change code

## Git

- Keep commit messages short and terse
- NEVER include yourself as a co-author in a commit
- Don't include things in a commit message that are enforced by CI (typechecking, linting, test coverage, etc)
- Run `git status` before committing to ensure all modified/untracked files are included
- Do not report a commit as complete if there are uncommitted changes
- After a rebase, ALWAYS push to remote unless explicitly told not to
- Verify the push succeeded and confirm the correct branch before reporting completion

## Code Quality

- After generating or editing code, run lint, prettier, and typecheck before committing
- Fix any issues before presenting work as done

## Debugging

- When debugging CI failures, read the ACTUAL error output before proposing fixes
- Do not guess at causes — identify the specific failing test/check and trace the real error
- If a fix doesn't work after 2 attempts, step back and reconsider the root cause

## TypeScript and React

- ALWAYS strict mode
- Format with 2 space indent
- Try to keep lines to 80 if possible, no more than 100
- Prefer functional style over OOP whenever possible
- Prefer immutability whenever possible
- Use interfaces rather than types unless types are needed
- Do not inline complex argument types or return types, always use an interface
- For functions with multiple arguments, prefer passing an object rather than individual arguments
- Avoid inline ternaries in JSX — assign to variables before rendering

## MCP Servers

- User-scoped MCP servers go in `~/.claude.json` (via `claude mcp add -s user`)
- Project-scoped MCP servers go in `.mcp.json` at the project root
- NEVER hardcode secrets/tokens in MCP configs — reference env vars from zshenv instead
- When adding or troubleshooting MCP servers, use `claude mcp get <name>` and `claude mcp list` to inspect config
- When setting up MCP servers that use `uvx` or `npx`, use `--default-index https://pypi.org/simple/` (uvx) or equivalent to bypass the project's CodeArtifact configuration, which will block public package resolution

## Obsidian

- No MCP server — interact with vaults directly via markdown files
- Personal vault: `~/.obsidian/main` (all machines)
- Black Omen vault: `~/.obsidian/black-omen` (personal machines only)
- Vault structure: each note is a `.md` file, folders are directories
- Links between notes use `[[wikilink]]` syntax
- Frontmatter (YAML between `---`) is used for metadata/properties
- Tags use `#tag` syntax inline or `tags:` in frontmatter
- Daily notes typically live in a `daily/` or `Daily Notes/` folder
- When creating/editing notes, preserve existing frontmatter and wikilinks
- Do not reorganize vault structure without being asked

## File Handling

- ALWAYS use unix line endings
- ALWAYS end files with a newline
