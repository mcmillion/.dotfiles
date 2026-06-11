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

Once you've grounded yourself, interview the user to resolve every open decision before writing the plan. Use the same grilling discipline as `/grill-me` (canonical source — keep them in sync):

- **Ask exactly one question per turn.** Never batch questions. Never dump a numbered list.
- For each question, state the question, the options, your recommendation, and brief reasoning — then wait for the answer.
- If an answer opens a new branch, drill into that branch before returning to the parent tree.
- If a question can be answered by exploring the codebase, explore instead of asking.
- No preamble. Keep each question tight.
- Stop asking when every branch that affects the plan is resolved.

## Phase 3 — Write the plan

- Identify critical files that will need modification
- **Think in seams.** Identify the seams (where an interface lives and behavior can be altered without editing in place) at which the feature will be tested. Prefer existing seams over new ones; test at the highest seam possible. If a new seam is needed, propose it at the highest point you can.
- **Evaluate designs for depth.** Prefer deep modules (a lot of behavior behind a small interface) over shallow ones (interface nearly as complex as the implementation). Apply the deletion test to anything that smells like a pass-through: would deleting it concentrate complexity or just move it around?
- **Break the work into vertical slices** (tracer bullets) — each slice cuts through all layers end-to-end and is independently shippable, not a horizontal slice of one layer.
- Consider edge cases and potential risks
- Include a verification section describing how to test the changes (name the seam each test exercises)
- Keep the plan concise but detailed enough to execute effectively
