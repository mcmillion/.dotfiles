# Investigation document template

Filename: `YYYY-MM-DD-summary-of-issue.md` (today's date + short kebab-case slug from the
issue description, e.g. `2026-04-27-users-cant-login.md`), in `~/.obsidian/galileo/on-call/`.

```markdown
---
tags: [on-call, investigation]
status: investigating
slack: <slack-link>
date: <YYYY-MM-DD>
---

# <Issue Title>

## Initial Report
<paste the user's issue description here>

**Slack thread**: <slack-link>
**Reported**: <date and time if available>
**Environment**: production

## Extracted Context
<populated from provided links — entity IDs, service names, time ranges, error messages>

## Timeline
- **<timestamp>** — Issue reported via Slack

## Investigation

### Hypotheses
<ranked, falsifiable hypotheses with status — 🔍 investigating / ✅ confirmed / ❌ ruled out.
Each states the prediction that would confirm or refute it.>

### Evidence
<hard evidence with sources — log queries, commit hashes, trace IDs>

### Datadog Findings
<summarized datadog-investigator output>

### Code Analysis
<relevant code paths, file:line locations, behavior analysis>

### Git History
<relevant commits — who, when, what changed, why it matters>

## Root Cause
<filled in when root cause is identified, backed by cited evidence — not before>

## Potential Fixes
<concrete, actionable fixes ranked by confidence>

## Prevention / Follow-up
<what would have prevented this — regression test seam, monitor/alert, follow-up ticket.
Filled in at the post-mortem step.>

## Open Questions
<things that still need answers>
```
