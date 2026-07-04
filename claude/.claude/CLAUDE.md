# Personal Global Claude Setup

## General Behavior

- When reporting information to me, be extremely concise and sacrifice grammar for the sake of concision
- Investigate and report findings; do not modify code unless explicitly asked
- Comment sparingly — only the non-obvious *why*, never the *what*; no narration comments
- Leave existing comments alone unless they're now wrong (don't strip them as a side effect of an unrelated edit)
- Use only ASCII characters; no emojis or special Unicode unless I ask
- Write plainly; avoid jargon and insider terminology. Don't reach for obscure or academic terms (e.g. "oracle") when a plain phrase works, and never use a niche term that collides with a well-known one in tech. If unsure whether a word is common, assume it isn't and say it plainly.
- NEVER use the built-in AskUserQuestion / multiple-choice Q&A interface — it loses fidelity. When you need to figure something out or make a decision with me, ALWAYS use the `grill-me` skill instead
- When giving me shell commands to copy/paste, format them to wrap at 80 characters whenever possible (use `\` line continuations, break on pipes/`&&`, etc). Long single-line commands that soft-wrap in the terminal cause copy/paste problems

## Git

- Keep commit messages short and terse
- NEVER include yourself as a co-author in a commit
- Don't mention CI-enforced items (typechecking, linting, test coverage, etc) in a commit message unless they required manual fixes
- Do not report a commit as complete if there are uncommitted changes
- Verify the push succeeded and confirm the correct branch before reporting completion

## Pull Requests

- If the repo has a GitHub PR template, use it and keep content terse
- Otherwise, fall back to a terse description of what is changing and why

## Debugging

- When debugging CI failures, read the ACTUAL error output before proposing fixes
- Do not guess at causes — identify the specific failing test/check and trace the real error
- If a fix doesn't work after 2 attempts, step back and reconsider the root cause

## Runtime & Dependencies

- asdf is the default runtime version manager

## TypeScript and React

- ALWAYS strict mode
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
- Vaults (each is a separate Obsidian vault, not a folder):
  - Personal: `~/.obsidian/personal` (all machines)
  - Galileo (employer / work): `~/.obsidian/galileo` (work machine)
  - Black Omen (my own company): `~/.obsidian/black-omen` (personal machines only)
- Route notes to the vault matching their topic; never put work content in the personal vault
- Within a vault: topical `kebab-case` folders; never create notes at vault root
- Conventions: `_todo.md` / `_links.md` for per-folder task & link collections; on-call notes prefixed `YYYY-MM-DD-`
- Vault structure: each note is a `.md` file, folders are directories
- When creating/editing notes, preserve existing frontmatter and wikilinks
- Do not reorganize vault structure without being asked
