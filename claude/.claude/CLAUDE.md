# Personal Global Claude Setup

## General Behavior

- When reporting to me, be concise: cut preamble, hedging, and filler, not words that carry meaning. Concise does not mean compressed — never stack jargon or drop connective words to save space. Plain and readable beats short (see plain-writing rule below)
- When an explanation runs long, break it into meaningful bullets rather than one dense paragraph. Bullets don't need to be full sentences — each one a complete thought that stands on its own, plainly stated, not a chopped-up fragment. Keep short answers as plain prose
- Investigate and report findings; do not modify code unless explicitly asked
- Comment sparingly — only the non-obvious *why*, never the *what*; no narration comments
- Leave existing comments alone unless they're now wrong (don't strip them as a side effect of an unrelated edit)
- Use only ASCII characters; no emojis or special Unicode unless I ask
- Write the way you'd explain it out loud to a competent teammate who's new to the code: plain words, concrete nouns, cause-and-effect. This is a hard rule, not a nicety, and it applies to everything — comments, prose, PRs, commit messages, and replies to me. Specifically:
  - No catchphrases or coined-sounding metaphors — e.g. "the seam", "churn", "sink", "threaded through" (examples, not an exhaustive list)
  - Don't stack jargon, product terms, or rule-slugs inside a sentence
  - Name the actual thing ("the login route uses this") instead of an abstract label ("shared server infrastructure")
  - Don't reach for obscure or academic terms (e.g. "oracle"), and never use a niche term that collides with a well-known one in tech
  - Define any word a newcomer would misread in a few words, or drop it
- NEVER use the built-in AskUserQuestion / multiple-choice Q&A interface — it loses fidelity. When you need to figure something out or make a decision with me, ALWAYS use the `grill-me` skill instead
- When giving me shell commands to copy/paste, format them to wrap at 80 characters whenever possible (use `\` line continuations, break on pipes/`&&`, etc). Long single-line commands that soft-wrap in the terminal cause copy/paste problems

## Environment / Machines

- This global file syncs to all my machines, so treat statements here as machine-neutral: always check `hostname` before assuming where you are. The machines:
  - **aurora** — NVIDIA DGX Spark (ARM64, Linux). My default dev box; all personal dev happens here except game dev. Sessions very often run directly ON aurora, not remote from it: when `hostname` is `aurora`, don't tell me to `ssh` in or treat it as remote — its paths and services are local to you
  - **Chozo** — my local Mac. Game development happens here (local, not on aurora)
  - **XG7GT4XJLW** — work laptop (Galileo, macOS)
- Repos live under `~/dev/` on aurora and `~/Developer/` on the Macs, organized as `owner/repo`. Most use the bare-repo worktree pattern: a `.bare/` directory holds the git data, a `.git` file points to it, and worktree folders sit alongside — with the default branch kept as a permanent worktree checkout
- `~/todo.txt` (home root) is my global todo list across all systems, in todo.txt format, managed with `tuxedo` (shell alias `t`). It is primarily MY tool — agents track their own work in Obsidian, not here. But know where it is: if I ask you to add or complete a task, edit `~/todo.txt` directly, and check off (`x `-prefix, todo.txt convention) items you actually finish.

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
  - Personal: `~/obsidian/personal` (all machines)
  - Galileo (employer / work): `~/obsidian/galileo` (work machine)
  - Black Omen (my own company): `~/obsidian/black-omen` (personal machines only)
- Route notes to the vault matching their topic; never put work content in the personal vault
- Within a vault: topical `kebab-case` folders; never create notes at vault root
- Conventions: `_todo.md` / `_links.md` for per-folder task & link collections; on-call notes prefixed `YYYY-MM-DD-`
- Vault structure: each note is a `.md` file, folders are directories
- When creating/editing notes, preserve existing frontmatter and wikilinks
- Do not reorganize vault structure without being asked

### Shared agent knowledge base

- The personal vault (`~/obsidian/personal`) is a knowledge base shared by AI agents (Hermes on ceres + personal Claude sessions) and me. The whole vault syncs to ceres via `obsidian-headless`.
- Record durable knowledge (homelab, projects, etc.) into the matching topical folder; use `agents/inbox/` for quick captures without a home yet. Knowledge does NOT live in `agents/` - that folder is the operating layer.
- Invoke the `/kb` skill for the full operating manual (conventions, folder map, inbox + distillation rules); it loads `agents/README.md` from the vault. Use `/distill` to promote inbox captures into their topical home.
