---
name: pr
description: Open a GitHub pull request for the current branch with a concise, template-conformant, PM-readable description. Links the related GitHub issue so it closes on merge and moves it to in-review. Use when the user asks to open or create a PR (e.g. /pr, "open a PR", "create a pull request"). Pass --draft for a draft PR.
disable-model-invocation: true
argument-hint: "[--draft]"
allowed-tools:
  - Bash
  - Read
  - Grep
---

# Create a new PR for the current branch

- NEVER add Claude attribution
- If there are uncommitted changes, commit them following the commit skill
  (../commit/SKILL.md) — do not invent separate commit rules — then push
- Ensure the branch is pushed to the remote before creating the PR
- If the arguments include `--draft`, create the PR as a draft using
  `gh pr create --draft`

## Find and link the related issue

- Identify the issue this branch addresses. This skill is almost always
  invoked after working the issue in this same session, so conversation
  context is the primary source — you usually already know the issue.
  Fallbacks when you don't (branch names do NOT contain the issue number):
  check issue references in the branch's commit messages, then search open
  issues for ones matching this work
  (`gh issue list --search "<keywords from the diff/branch>"`). If the
  match came from a search, confirm the issue number with the user before
  linking it.
- If nothing is found, ask the user rather than guessing.
- Add a closing keyword line in the PR description (`Closes #123`) so
  merging the PR closes the issue automatically. Plain `#123` references
  do NOT close — use `Closes`/`Fixes`.

## Move the issue to in-review

After the PR is created, if the issue is on a GitHub Projects (v2) board,
move its Status field to the in-review column: `gh project item-list` to
find the item, `gh project field-list` for the Status field/option IDs,
then `gh project item-edit`. If the repo has no project board, skip this.

Report what was moved (or why it couldn't be) — don't fail the whole PR
over a board update.

## Description

- ALWAYS use the GitHub PR template in the repo if it exists
  (`.github/PULL_REQUEST_TEMPLATE.md` or `.github/pull_request_template.md`);
  fill in its sections rather than replacing them
- Write for a PM, not just engineers: lead with what changed from the
  user's/product's perspective and why, in plain language
- Keep it concise with bullet points; implementation details only where
  they matter for review, below the plain-language summary
- Spell out jargon and avoid internal shorthand
