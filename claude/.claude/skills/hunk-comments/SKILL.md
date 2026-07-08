---
name: hunk-comments
description: Address review comments left in a live hunk diff session, then commit the fixes locally. Use when the user says to check/address/handle their hunk comments (e.g. /hunk-comments, "address my hunk comments", "I left comments in hunk").
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - Grep
  - Glob
  - Skill
---

# Address hunk review comments

The user reviews a diff in a live hunk TUI session (usually launched via
`review`, which pins the diff to the merge base with the default branch
and watches for file changes). They leave inline comments; your job is to
address each one in code, clean up the comments, and commit.

The TUI belongs to the user - NEVER run `hunk diff`/`hunk show` yourself.
Interact only through `hunk session *` commands. For the full session command
reference, read the bundled skill at the path printed by `hunk skill path`.

## Workflow

1. **Find the session**: `hunk session list --json`. If none, ask the user to
   run `review` in the repo first, then stop. If multiple match, select
   by `--repo <repo-root>` or explicit session id.
2. **Collect comments**: `hunk session comment list --repo . --type user --json`.
   If empty, also try without `--type` (older comment views). If still empty,
   report that and stop.
3. **Understand each comment**: comments carry a file path, a line
   (old/new side), and a summary. Read the surrounding code with the normal
   file tools; use `hunk session review --repo . --json` (and
   `--include-patch` only for files you truly need raw diff text for) to see
   the hunk structure the comment anchors to.
4. **Address each comment** with a code change. If a comment is unclear or
   you disagree, do NOT guess - navigate the user's view to it
   (`hunk session navigate --repo . --next-comment` or `--file/--new-line`),
   leave an agent note explaining the question
   (`hunk session comment add --repo . --file <f> --new-line <n> --summary "..." --author "claude"`),
   and ask the user before changing anything there.
5. **Resolve handled comments**: remove each addressed comment with
   `hunk session comment rm --repo . <comment-id>`. If removal of a
   user-authored note is refused, leave it and add an adjacent agent note
   prefixed "addressed:" describing the fix.
6. **Commit**: invoke the `commit` skill to commit the fixes locally. Never
   push unless the user asks. If fixes are unrelated to each other, let the
   commit skill split them into atomic commits as usual.
7. **Report**: one terse line per comment - what it asked, what changed,
   which commit. Note any comments left open (questions/disagreements). The
   watched hunk session reloads on its own; no need to touch it.

## Notes

- Comments live in memory in the session daemon only - collect them before
  suggesting the user close hunk.
- The daemon listens on 127.0.0.1:47657. If `hunk session list` shows nothing
  while hunk is visibly running, sandbox loopback blocking is the likely
  cause; retry with escalated permissions.
- Line numbers from comments refer to the diff side (`newLine` = current
  file, `oldLine` = base side). Verify against the actual file before
  editing - the file may have shifted since the comment was left.
