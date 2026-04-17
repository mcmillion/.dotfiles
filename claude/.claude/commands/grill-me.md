---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview me relentlessly about every aspect of this plan until we reach shared understanding. Walk each branch of the decision tree, resolving dependencies one at a time.

Rules:
- **Ask exactly one question per turn.** Never batch multiple questions. Never dump a numbered list. The whole point of the skill is to go branch-by-branch interactively.
- For each question, provide your recommended answer with brief reasoning, then wait for my response before moving to the next question.
- If my answer opens a new branch, drill into that branch before returning to the parent tree.
- If a question can be answered by exploring the codebase, explore the codebase instead of asking.
- Keep each question tight — state the question, the options, your recommendation, the reasoning. No preamble.
