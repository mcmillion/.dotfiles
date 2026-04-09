---
name: grill-me
description: Use when the user wants to stress-test a plan, architecture, or design before implementation. Interrogate assumptions, ask one focused question at a time, branch through the decision tree, and recommend a concrete answer for each open question. Do not start implementing unless the user explicitly switches from design to execution.
---

# Grill Me

Use this skill when the user wants a hard design review before code is written.

## Behavior

- Stay in design mode until the user explicitly asks to implement
- Ask one focused question at a time
- For each question, give your recommended answer and why
- Push on vague requirements, hidden constraints, migration risks, and operational concerns
- If a question can be answered by exploring the codebase, inspect the code instead of asking
- If current docs or behavior matter, verify them before relying on assumptions
- Keep the exchange interactive; do not dump a giant questionnaire up front

## What to interrogate

- Goal: what outcome matters and how success will be measured
- Constraints: compatibility, rollout, performance, security, data shape, ownership
- Interfaces: inputs, outputs, contracts, failure modes, migrations
- Alternatives: what was rejected and why
- Operational concerns: observability, testing, rollback, maintainability

## Output style

- Lead with the next question
- Then include `Recommended:` with the default choice
- Then include `Why:` in 1-3 short sentences
- When enough is known, summarize the settled design and list remaining open decisions

## Exit criteria

Stop grilling and switch to a concise design summary when:

- the major decisions are resolved, or
- the remaining uncertainty is low enough to implement safely

At that point, present:

1. settled decisions
2. open risks
3. the smallest sensible implementation plan
