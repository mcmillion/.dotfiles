---
name: on-call-debug
description: On-call debugging workflow. Creates an Obsidian investigation document, researches root cause using Datadog, codebase exploration, and git history, and iteratively refines findings. Use when user invokes /on-call-debug with a Slack link and issue description.
argument-hint: <slack-link> <description of the issue>
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Agent
  - ToolSearch
  - WebFetch
  - WebSearch
---

# On-Call Debug Investigation

Systematically investigate a production issue, find hard evidence for the root cause, and
produce a thorough investigation document in Obsidian.

## Assumptions

- **Environment is ALWAYS production.** Never ask which environment — every on-call issue is production by definition.

## Input

The user has provided:

$ARGUMENTS

May contain any combination of: **Slack links**, **Datadog links**, a freeform **issue
description**, and **IDs** (patient, case, user, request, etc.). Parse ALL of these. Never
ask the user to re-state information embedded in a link — fetch it yourself.

## Phase 1 — Initialize the investigation document

Create the doc per [TEMPLATE.md](TEMPLATE.md) (creating the directory if needed). Tell the
user the path.

## Phase 2 — Extract context from provided links

Before asking the user anything, extract everything you can from the links. Launch agents
in parallel (see [AGENTS.md](AGENTS.md)):
- **Slack** → `web-researcher`: who reported, when, description, IDs/URLs/errors/attachments in the thread.
- **Datadog** → `web-researcher` for the page + `datadog-investigator` to query the same data programmatically.

Record into **Extracted Context**: entity IDs, application URLs, service names, time range,
error messages, who reported. Update the doc before proceeding.

## Phase 2b — Ask ONLY what you couldn't extract

Check what's still genuinely missing and necessary. Never ask about: environment (always
production), anything visible in the links, anything Datadog/git can answer. If you have
enough to start, skip to Phase 3.

## Phase 3 — Form ranked hypotheses, then investigate

**Before chasing evidence, generate 3–5 ranked, falsifiable hypotheses.** Each must state
the prediction that would confirm or refute it (e.g. "if a recent deploy is the cause, the
error onset correlates with deploy time"). Single-hypothesis thinking anchors on the first
plausible idea — generate the spread.

**Show the ranked list to the user before deep investigation.** They often re-rank it
instantly ("we just deployed #3") or have already ruled some out. Cheap checkpoint, big time
saver — but don't block: proceed with your ranking if they're AFK. Record the list under
**Hypotheses**.

Then launch agents in parallel (single message) to test the top hypotheses — see
[AGENTS.md](AGENTS.md) for the catalog and how to brief each:
1. **First wave**: `datadog-investigator` (errors in affected service(s) in production for the time window, with entity IDs) · `codebase-researcher` (code for the affected feature) · `git-investigator` (recent commits to the area).
2. **Second wave** (driven by first-wave findings): error messages → `error-investigator`; suspicious commits → `codebase-researcher`; deploy-related → `ci-investigator`; external deps → `web-researcher`.
3. **Iterate**: each result confirms/refutes a hypothesis or opens a new line. Keep going until you have hard evidence.

**Intermittent issues**: the goal is a *higher reproduction rate*, not a clean repro. Find
the handles (entity, timing, load) that raise the signal until it's debuggable.

### What counts as hard evidence
Specific error messages with timestamps/frequency · a commit that introduced the regression
(hash, author, date, diff) · a code path that demonstrably fails under the conditions ·
metric data showing onset correlated with a change · a trace showing where a request fails.
Never present speculation as a finding — label uncertain ideas as hypotheses with the
evidence that would settle them.

## Phase 4 — Update the document after each wave

Edit the doc after EACH wave. Hypotheses carry status — 🔍 investigating / ✅ confirmed /
❌ ruled out. Fill Timeline, Evidence (with sources), Datadog Findings, Code Analysis, Git
History as you go. Fill **Root Cause** only when evidence supports it.

## Phase 5 — Root cause, fixes, prevention

Once you've found the root cause (or exhausted leads):
1. Set `status` to `root-cause-found` or `needs-escalation`.
2. Fill **Root Cause** with a clear, evidence-cited explanation.
3. Fill **Potential Fixes**, ranked by confidence.
4. **Post-mortem — "what would have prevented this?"** Record in **Prevention / Follow-up**:
   the regression-test seam (if one exists; if not, that's itself a finding), a monitor/alert
   that would have caught it earlier, or a follow-up ticket. Do this *after* the root cause is
   known — you have the most information then.
5. Present a concise summary in the conversation and show the doc path.

## Ongoing — accept new information

When the user supplies new context, errors, links, or feedback: update the doc immediately,
add to the Timeline, re-evaluate hypotheses, launch new agents if leads open, and tell the
user how it changes the picture.

## Environment URLs (build full clickable links)

Always give the user **full clickable URLs**, never bare admin paths.

- **Production Django admin (core-api):** `https://core-api.prod.int.galileo.io`
  - Admin root: `https://core-api.prod.int.galileo.io/internal/admin/`
  - Support admin (limited model set): `https://core-api.prod.int.galileo.io/internal/support/`
  - Changelist URL pattern: `https://core-api.prod.int.galileo.io/internal/admin/<app_label>/<model_name_lowercased_no_underscores>/`
    e.g. model `CarePlanDraft` in app `care_plan_drafts` → `…/internal/admin/care_plan_drafts/careplandraft/`
  - Object detail: append `<pk>/change/` to the changelist URL.
  - Search a changelist: append `?q=<value>` (e.g. `…/flaskapireferralorderentry/?q=32114`).
  - Flask-mirrored MySQL tables live in the `flask_api` app (model names prefixed `FlaskApi…`).

- **Chart / patient app (zodiac):** `https://zodiac.galileo.io` — pattern `…/auth/patients/<patient_id>/cases/<case_id>`.

## Using the user as a resource (no direct DB access)

When you need application data, **ask the user to check Django admin**. Be specific: give the
**full clickable URL** (see Environment URLs above) to the exact changelist/object, name the
model + lookup key, explain which hypothesis it settles, one lookup at a time unless
independent, and record what they report under **Evidence**.

## Rules

- NEVER guess at root causes — find evidence or say you don't know yet.
- ALWAYS keep the Obsidian doc current; it is the living record.
- One question at a time when you must ask.
- Give agents ALL context — they have no memory of this conversation.
- Cite specific evidence: log lines, commit hashes, file:line, trace IDs.
- If no root cause, document what you investigated, what you ruled out, and next steps for escalation.
- Keep the user informed — brief update after each wave.
