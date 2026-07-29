# Personal Global Claude Setup

## General Behavior

- When reporting to me, be concise: cut preamble, hedging, and filler, not words that carry meaning. Concise does not mean compressed — never stack jargon or drop connective words to save space. Plain and readable beats short (see plain-writing rule below)
- When an explanation runs long, break it into meaningful bullets rather than one dense paragraph. Bullets don't need to be full sentences — each one a complete thought that stands on its own, plainly stated, not a chopped-up fragment. Keep short answers as plain prose
- Investigate and report findings; do not modify code unless explicitly asked
- **The bar for a comment existing at all:** it explains something non-obvious, or something a reader — person or model — would have a hard time discovering from the code itself. If someone could work it out by reading the code and following it where it goes, don't write it. Default to no comment; the comment is what needs justifying, not its absence
- What clears that bar is usually knowledge from outside the file: a constraint the code can't show, an approach already tried and rejected, a failure that happens silently somewhere else. What doesn't clear it: restating the *what*, narrating the next line, or explaining a decision that the code and its types already make plain
- **Hard cap: 2 lines per comment.** If the reasoning needs more room it goes in the spec, the docs, or the PR, and the comment becomes a one-line pointer. This is a limit, not a target — going over means the content belongs somewhere else, not that this one is special
- A comment is never a second copy of something already written down. If it's in a spec, point at the spec instead of restating it
- **Never argue a code review in a comment.** Findings get answered in the PR thread. A comment that defends a choice against an objection, or talks down an alternative nobody chose ("X looks tidier and is wrong because…"), is a review reply in disguise — cut it. Whoever reads the file next was never in that conversation
- Before committing, compare comment density in the files I touched against what was there before. A big jump is the signal to cut, not to justify
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
- asdf is the default runtime version manager
- `~/todo.txt` (home root) is my global todo list across all systems, in todo.txt format, managed with `tuxedo` (shell alias `t`). It is primarily MY tool — agents track their own work in Obsidian, not here. But know where it is: if I ask you to add or complete a task, edit `~/todo.txt` directly, and check off (`x `-prefix, todo.txt convention) items you actually finish.

## Git & Pull Requests

- Keep commit messages terse, imperative mood
- NEVER include yourself as a co-author or add Claude attribution — commits or PRs
- Don't mention CI-enforced items (typechecking, linting, test coverage, etc) in commit messages or PR descriptions unless they required manual fixes
- Do not report a commit as complete if there are uncommitted changes
- Verify the push succeeded and confirm the correct branch before reporting completion
- For PRs: use the repo's GitHub PR template if it has one, otherwise a terse description of what's changing and why

## Debugging

- Read the actual error output before proposing a fix; never guess at causes — trace the specific failing test, check, or stack trace to its source (CI failures included)
- If a fix doesn't work after 2 attempts, step back and reconsider the root cause

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
- CodeArtifact is a **work-only** concern: only on the work laptop (Galileo, `XG7GT4XJLW`) or in a work project does a private registry block public package resolution. There, when setting up MCP servers that use `uvx` or `npx`, use `--default-index https://pypi.org/simple/` (uvx) or equivalent to bypass it. On aurora and any personal repo, `uvx`/`npx`/`pnpm dlx` resolve against the public registries directly — no workaround, don't assume one

## Obsidian

- No MCP server — interact with vaults directly via markdown files
- Vaults (each is a separate Obsidian vault, not a folder):
  - Personal: `~/obsidian/personal` (all machines)
  - Galileo (employer / work): `~/obsidian/galileo` (work machine)
  - BitPivot (my company, dev work): `~/obsidian/bitpivot` (personal machines only)
  - Black Omen (my company, game dev): `~/obsidian/black-omen` (Chozo only, since game dev happens there)
- Route notes to the vault matching their topic; never put work content in the personal vault
- Within a vault: topical `kebab-case` folders; never create notes at vault root
- Conventions: `_todo.md` / `_links.md` for per-folder task & link collections; on-call notes prefixed `YYYY-MM-DD-`
- Vault structure: each note is a `.md` file, folders are directories
- When creating/editing notes, preserve existing frontmatter and wikilinks
- Do not reorganize vault structure without being asked

### Shared agent knowledge base

- The personal vault (`~/obsidian/personal`) is a knowledge base shared by AI agents (Hermes on aurora + personal Claude sessions) and me. The whole vault syncs on aurora via `obsidian-headless`.
- Record durable knowledge (homelab, projects, etc.) into the matching topical folder; use `agents/inbox/` for quick captures without a home yet. Knowledge does NOT live in `agents/` - that folder is the operating layer.
- Invoke the `/kb` skill for the full operating manual (conventions, folder map, inbox + distillation rules); it loads `agents/README.md` from the vault. Use `/distill` to promote inbox captures into their topical home.
