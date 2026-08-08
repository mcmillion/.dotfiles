# Personal Global Claude Setup

When grilling, ask me one question at a time.

## General Behavior

- Default to no comment. What earns one is knowledge from outside the file — a constraint the code can't show, an approach already tried and rejected. Not the *what*, and never a rebuttal to a code review
- Hard cap: 2 lines per comment. More than that belongs in the spec or the PR, with the comment as a one-line pointer
- Leave existing comments alone unless they're now wrong
- Use only ASCII characters; no emojis or special Unicode unless I ask
- When giving me shell commands to copy/paste, format them to wrap at 80 characters whenever possible (use `\` line continuations, break on pipes/`&&`, etc). Long single-line commands that soft-wrap in the terminal cause copy/paste problems

## Environment / Machines

- This global file syncs to all my machines, so treat statements here as machine-neutral: always check `hostname` before assuming where you are. The machines:
  - **aurora** — NVIDIA DGX Spark (ARM64, Linux). My default dev box; all personal dev happens here except game dev. Sessions very often run directly ON aurora, not remote from it: when `hostname` is `aurora`, don't tell me to `ssh` in or treat it as remote — its paths and services are local to you
  - **Chozo** — my local Mac. Game development happens here (local, not on aurora)
  - **XG7GT4XJLW** — work laptop (Galileo, macOS)
- Repos live under `~/dev/` on aurora and `~/Developer/` on the Macs, organized as `owner/repo`. Most use the bare-repo worktree pattern: a `.bare/` directory holds the git data, a `.git` file points to it, and worktree folders sit alongside — with the default branch kept as a permanent worktree checkout
- asdf is the default runtime version manager
- `~/todo.txt` (home root) is my global todo list across all systems, in todo.txt format, managed with `tuxedo` (shell alias `t`). It is primarily MY tool — agents track their own work in Obsidian, not here. But know where it is: if I ask you to add or complete a task, edit `~/todo.txt` directly, and check off (`x `-prefix, todo.txt convention) items you actually finish.

## Debugging

- Read the actual error output before proposing a fix; never guess at causes — trace the specific failing test, check, or stack trace to its source (CI failures included)
- If a fix doesn't work after 2 attempts, step back and reconsider the root cause

## Obsidian

- Vaults (each is a separate Obsidian vault, not a folder):
  - Personal: `~/obsidian/personal` (all machines)
  - Galileo (employer / work): `~/obsidian/galileo` (work machine)
  - BitPivot (my company, dev work): `~/obsidian/bitpivot` (personal machines only)
  - Black Omen (my company, game dev): `~/obsidian/black-omen` (Chozo only, since game dev happens there)
- Route notes to the vault matching their topic; never put work content in the personal vault
- The personal vault's folder map is `~/obsidian/personal/agents/README.md` — read it before writing there
- Within a vault: topical `kebab-case` folders; never create notes at vault root
- `_todo.md` / `_links.md` hold per-folder tasks and links — append rather than creating new notes
- When creating/editing notes, preserve existing frontmatter and wikilinks
- Do not reorganize vault structure without being asked
