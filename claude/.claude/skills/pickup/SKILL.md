---
name: pickup
description: Pick up a GitHub issue and prepare to work it — read the issue thoroughly, research the codebase, grill the user on every open question until the plan is nailed down, then begin implementing. Use when the user wants to start work on an issue, invokes /pickup, or hands one over from /up-next.
disable-model-invocation: true
argument-hint: "[issue # / URL]"
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Agent
---

# Pick up an issue and start work

Turn an issue into a shared, executable plan — then start building it. Don't write code until the plan is locked.

## Phase 1 — Understand the issue

- Fetch the full issue: body **and** all comments (`gh issue view <num> --comments`).
- Follow links it references — related issues, PRs, design docs — enough to understand intent, not just the literal ask.
- Note the acceptance criteria. If there are none, that's an open question for Phase 3.

## Phase 2 — Research the codebase

Delegate to the `issue-researcher` agent so the parent context stays lean. Hand it the issue number/URL. It returns a briefing: relevant files, symbols, constraints, related prior work, and open questions.

Use its briefing to ground yourself in existing patterns and conventions before asking the user anything. If a question can be answered by exploring the code, explore — don't ask.

## Phase 3 — Grill the user

Interview the user to resolve every open decision before writing the plan. Use the `/grill-me` discipline (keep in sync with that skill):

- **Ask exactly one question per turn.** Never batch. Never dump a numbered list.
- For each question: state the question, the options, your recommendation, and brief reasoning — then wait.
- If an answer opens a new branch, drill into it before returning to the parent tree.
- If a question can be answered from the code, explore instead of asking.
- No preamble. Keep each question tight.
- Stop when every branch that affects the plan is resolved.

## Phase 4 — Lock the plan

Present a concise plan:

- Critical files to modify
- The seams where the work will be tested (prefer existing seams, test at the highest one)
- Vertical slices (tracer bullets) — each cuts end-to-end and is independently verifiable
- Edge cases and risks
- How to verify (name the seam each test exercises)

Get explicit approval before touching code.

## Phase 5 — Claim it and implement

Once approved, claim the issue before writing code:

```bash
gh issue edit <num> --add-assignee @me
```

Then move it to **in-progress**. Match the repo's convention — check what already exists rather than assuming:

- If the repo uses status labels, swap the ready label for the working one: `gh issue edit <num> --remove-label ready-for-work --add-label in-progress` (use the actual label names present in the repo).
- If the issue lives on a GitHub Project board, set its Status field to In Progress via `gh project item-edit` instead.

If neither convention is detectable, just assign and tell the user there's no in-progress state to move it to. Report what was assigned and moved.

Then start implementing. Work the slices in order. Verify as you go.
