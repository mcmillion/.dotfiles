---
name: handoff
description: Compact the current conversation into a handoff document for a fresh agent to pick up. Use when the user asks to hand off, wrap up a session, or invokes /handoff.
disable-model-invocation: true
argument-hint: "[what the next session will focus on]"
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
---

# Write a handoff document for the next agent

- Write to the OS temp dir (`$TMPDIR` on macOS), NOT the workspace
- Name the file `handoff-<repo-or-topic>-<YYYY-MM-DD>.md`
- After writing, print the absolute path so the user can hand it off
- The doc is for a FRESH agent with no prior context — write for a cold start

## Contents

- **Goal** — what the work is trying to accomplish
- **State** — what's done, what's in progress, what's left
- **Key decisions** — choices made and the *why*, so they aren't relitigated
- **Next steps** — concrete, ordered actions for the next session
- **Suggested skills** — which skills the next agent should invoke (e.g. `/pickup`, `/commit`, `/grill-me`)
- **Gotchas** — anything non-obvious that will trip up a cold start

## Rules

- Do NOT duplicate content already in other artifacts (PRDs, plans, ADRs, issues, commits, diffs) — reference them by path or URL
- Redact secrets, tokens, and PII
- If arguments are passed, treat them as the next session's focus and tailor the doc to it
- Keep it terse — bullets over prose
