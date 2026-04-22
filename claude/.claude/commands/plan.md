# Guided feature development with codebase understanding and architecture focus

$ARGUMENTS

## Phase 1 — Ground yourself before asking anything

- ALWAYS enter plan mode using EnterPlanMode tool before doing any work
- ALWAYS explore the codebase thoroughly to understand existing patterns and conventions BEFORE asking any clarifying questions
- ALWAYS use WebSearch to research current best practices for the technologies involved (use current year in searches) BEFORE asking any clarifying questions
- ALWAYS validate API references and library capabilities through Context7 MCP when using external libraries
- Use the senior-architect-planner agent for complex architectural decisions when needed
- If a question can be answered by exploring the codebase, explore the codebase instead of asking

## Phase 2 — Interrogate the user branch-by-branch

Once you've grounded yourself, interview the user to resolve every open decision before writing the plan. Walk the decision tree one branch at a time.

Rules:
- **Ask exactly one question per turn.** Never batch questions. Never dump a numbered list.
- For each question, state the question, the options, your recommendation, and brief reasoning — then wait for the answer.
- If an answer opens a new branch, drill into that branch before returning to the parent tree.
- No preamble. Keep each question tight.
- Stop asking when every branch that affects the plan is resolved.

## Phase 3 — Write the plan

- Identify critical files that will need modification
- Consider edge cases and potential risks
- Include a verification section describing how to test the changes
- Keep the plan concise but detailed enough to execute effectively
