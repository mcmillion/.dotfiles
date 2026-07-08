---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable GitHub issues using tracer-bullet vertical slices. Use when the user wants to convert a plan into issues, create implementation tickets, or break work down into issues.
disable-model-invocation: true
argument-hint: "[issue # / URL / path to plan]"
allowed-tools:
  - Bash
  - Read
  - Grep
  - Agent
---

# Break a plan into GitHub issues

Convert a plan into independently-grabbable issues using vertical slices (tracer bullets), then publish them to GitHub via `gh`.

## Process

### 1. Gather context

Work from what's already in the conversation. If the user passes an issue number, URL, or file path, fetch and read its full body (and comments, for an existing issue) first.

### 2. Explore the codebase (optional)

If you haven't already, explore the code to understand current state. Use the `codebase-researcher` subagent for this. Issue titles/descriptions should use the project's domain vocabulary and respect any ADRs in the area you're touching.

### 3. Draft vertical slices

Break the plan into **tracer bullet** issues. Each issue is a thin vertical slice cutting through ALL layers end-to-end (schema, API, UI, tests) — NOT a horizontal slice of one layer.

- Each slice delivers a narrow but COMPLETE path through every layer
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones

Tag each slice **HITL** (needs a human — architectural decision, design review) or **AFK** (agent can implement and merge unattended). Prefer AFK where possible.

### 4. Quiz the user

Present the breakdown as a numbered list. For each slice show:

- **Title** — short descriptive name
- **Type** — HITL / AFK
- **Blocked by** — which slices must complete first
- **User stories covered** — if the source has them

Ask:
- Is the granularity right? (too coarse / too fine)
- Are the dependencies correct?
- Should any slices merge or split?
- Are the HITL/AFK tags right?

Iterate until the user approves.

### 5. Publish to GitHub

For each approved slice, `gh issue create` using the body template below. Publish in dependency order (blockers first) so you can reference real issue numbers in "Blocked by".

```
## Parent
<reference to parent issue, if the source was an existing issue — else omit>

## What to build
<concise description of the end-to-end behavior, not layer-by-layer implementation>
<avoid file paths / code snippets — they go stale. Exception: a decision-encoding
snippet from a prototype (state machine, reducer, schema, type shape) — trimmed to
the decision-rich parts, noted as from a prototype>

## Acceptance criteria
- [ ] ...
- [ ] ...

## Blocked by
<reference to blocking issue, or "None — can start immediately">
```

- Use the repo's issue template if one exists (`.github/ISSUE_TEMPLATE/`)
- Do NOT close or modify any parent issue
