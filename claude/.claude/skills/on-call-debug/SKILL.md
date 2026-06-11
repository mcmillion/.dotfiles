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

You are running an on-call debugging workflow. Your goal is to systematically investigate
a production issue, find hard evidence for the root cause, and produce a thorough
investigation document in Obsidian.

## Assumptions

- **Environment is ALWAYS production.** Never ask which environment. Every on-call issue
  is production by definition.

## Input

The user has provided:

$ARGUMENTS

The input may contain any combination of:
- **Slack links** — URLs to incident reports or discussion threads
- **Datadog links** — URLs to dashboards, charts, monitors, traces, logs, or APM views
- **Issue description** — freeform text describing the problem
- **IDs or identifiers** — patient IDs, case IDs, user IDs, request IDs, etc.

Parse ALL of these from the input. Do not ask the user to re-state information that is
embedded in a link — fetch it yourself.

## Phase 1 — Initialize the investigation document

Create a new markdown file in `~/.obsidian/galileo/on-call/`. Create the directory
if it doesn't exist.

**Filename**: `YYYY-MM-DD-summary-of-issue.md` where the date is today and the summary
is a short kebab-case slug derived from the issue description (e.g.
`2026-04-27-users-cant-login.md`).

Initialize the document with this template:

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
<will be populated during investigation>

### Evidence
<will be populated during investigation>

### Datadog Findings
<will be populated during investigation>

### Code Analysis
<will be populated during investigation>

### Git History
<will be populated during investigation>

## Root Cause
<will be populated when root cause is identified>

## Potential Fixes
<will be populated when root cause is identified>

## Open Questions
<will be populated during investigation>
```

Tell the user the document has been created and show the path.

## Phase 2 — Extract context from provided links

Before asking the user anything, extract as much context as possible from the links
they provided. Launch agents in parallel to fetch all links:

- **Slack links** → use `web-researcher` to fetch the thread content. Extract: who
  reported, when, what they described, any IDs/URLs/error messages mentioned in the
  thread, any screenshots or attachments referenced.
- **Datadog links** → use `web-researcher` to fetch the page. Extract: service name(s),
  time range shown, metric/log query, error messages, trace IDs, any entity IDs visible
  in the chart (patient IDs, case IDs, request IDs, URLs, etc.). Also use
  `datadog-investigator` to query the same data programmatically if the link points to
  logs, traces, or monitors.

From ALL fetched content, extract and record:
- **Entity IDs**: patient IDs, case IDs, user IDs, organization IDs, request IDs
- **URLs**: any application URLs (patient pages, case pages, API endpoints)
- **Service names**: which services are involved
- **Time range**: when the issue occurred or was first observed
- **Error messages**: any errors, exceptions, or status codes mentioned
- **Who reported**: name/handle of the person who raised the issue

Update the investigation document with ALL extracted information before proceeding.

## Phase 2b — Ask ONLY what you couldn't extract

After extracting context from links, check what you still don't know. Only ask about
information that is genuinely missing and necessary to investigate. Likely you already
have everything you need from the links and messages.

Never ask about:
- Environment (always production)
- Information already visible in the links you fetched
- Information that Datadog or git can answer for you

If you have enough to start investigating, skip this phase entirely and go straight
to Phase 3.

## Phase 3 — Parallel investigation

Launch multiple agents in parallel to investigate. Send all independent agent calls in
a SINGLE message so they run concurrently.

### Available agents and how to use them

When spawning agents via the Agent tool, use the `subagent_type` parameter to select
the right agent type. These correspond to the agent definitions in `.claude/agents/`:

#### `datadog-investigator`
Searches Datadog logs, traces, metrics, and monitors.
- **Give it**: service name(s), environment, time range, error description
- **Returns**: diagnosis with error messages, service impact, timeline, root cause assessment
- **Has access to**: all Datadog MCP tools (logs, traces, metrics, monitors, services, spans, RUM events)
- **Best for**: finding error patterns, tracing requests across services, identifying metric anomalies

#### `codebase-researcher`
Explores codebases to find relevant files, symbols, and patterns.
- **Give it**: what you're looking for (function name, endpoint, feature area, error message)
- **Returns**: file paths, line numbers, directory structure, entry points
- **IMPORTANT**: The user will have multiple repos available in the session — frontend
  app and both backend apps. Ask the user for the repo paths if you don't know them,
  then explore ALL relevant ones.
- **Best for**: mapping code paths, finding where logic lives, understanding module structure

#### `git-investigator`
Researches git history to find when changes were introduced.
- **Give it**: a file path or feature area, the repo path, and a question about what changed
- **Returns**: key commits, blame info, narrative of changes
- **Best for**: finding when a bug was introduced, identifying recent regressions,
  understanding why code exists in its current form

#### `error-investigator`
Traces stack traces and exceptions through the codebase.
- **Give it**: a stack trace or error message and the codebase path to search
- **Returns**: root cause location (file:line), call path, contributing factors
- **Best for**: diagnosing specific errors once you have a stack trace or error message

#### `web-researcher`
Fetches and distills web content.
- **Give it**: a URL or a research topic
- **Returns**: compact summary of the page content or search results
- **Best for**: looking up documentation, known issues, or fetching content from links

#### `log-analyzer`
Parses application logs.
- **Give it**: a file path or command that produces log output
- **Returns**: distilled summary of errors, patterns, and anomalies
- **Best for**: analyzing local log files or command output

#### `ci-investigator`
Investigates GitHub Actions CI failures.
- **Give it**: PR number, branch name, run ID, or "latest"
- **Returns**: which job/step failed, the actual error, whether it's a flake
- **Best for**: determining if the issue is related to a failed deployment or broken build

#### `general-purpose`
General-purpose agent for tasks that don't fit a specialized agent.
- **Give it**: a clear description of what to research or do
- **Returns**: varies based on task
- **Best for**: ad-hoc research, multi-step tasks, anything the specialized agents don't cover

### Investigation strategy

Use `production` as the environment for ALL Datadog queries. Never query staging or
other environments unless the user explicitly redirects you.

When you have entity IDs (patient, case, user, request, etc.) from Phase 2, include
them in your Datadog queries. These are your best handles for finding the exact logs
and traces related to the issue.

1. **First wave** (launch ALL in parallel in a single message):
   - `datadog-investigator`: Search for errors in the affected service(s) in
     **production** during the reported time window. Include any entity IDs, URLs, or
     error messages extracted from the links. Look for error logs, failed traces, metric
     anomalies.
   - `codebase-researcher`: Find the code related to the affected feature/endpoint.
     Explore all available repositories.
   - `git-investigator`: Check recent commits to the affected area for potential
     regressions.

2. **Second wave** (based on first wave findings, again in parallel where possible):
   - If Datadog reveals specific error messages → `error-investigator` to trace them
   - If git history reveals suspicious commits → `codebase-researcher` to understand
     what those changes actually do
   - If deployment-related → `ci-investigator` to check recent builds
   - If external dependencies involved → `web-researcher` for known issues
   - Continue spawning targeted agents as leads develop

3. **Iterate**: Each agent result should confirm/refute a hypothesis or open a new
   line of investigation. Keep going until you have hard evidence.

### What counts as hard evidence

- Specific error messages from Datadog logs with timestamps and frequency
- A specific commit that introduced the regression (hash, author, date, diff summary)
- A code path that demonstrably fails under the reported conditions
- Metric data showing the onset of the problem correlating with a deployment or change
- A trace showing where a request fails across services

Do NOT present speculation as findings. If something is uncertain, label it as a
hypothesis and describe what evidence would confirm or refute it.

## Phase 4 — Update the investigation document

After EACH wave of investigation, update the Obsidian document with findings using the
Edit tool. Add content to the appropriate sections:

- **Timeline**: Timestamps of events discovered in logs/Datadog
- **Hypotheses**: Theories with status — `🔍 investigating` / `✅ confirmed` / `❌ ruled out`
- **Evidence**: Hard evidence with sources (log queries, commit hashes, trace IDs)
- **Datadog Findings**: Summarized Datadog investigator output
- **Code Analysis**: Relevant code paths, file locations, behavior analysis
- **Git History**: Relevant commits — who, when, what changed, and why it matters
- **Root Cause**: Fill in when you have enough evidence (not before)
- **Potential Fixes**: Concrete, actionable fix suggestions based on root cause
- **Open Questions**: Things that still need answers

## Phase 5 — Summarize and present

Once you've identified the root cause (or exhausted available leads):

1. Update the document `status` in frontmatter to `root-cause-found` or `needs-escalation`
2. Fill in the Root Cause section with a clear explanation backed by cited evidence
3. Fill in Potential Fixes with actionable recommendations ranked by confidence
4. Present a concise summary to the user in the conversation
5. Show the path to the investigation document

## Ongoing — Accept new information

Throughout the investigation, the user may provide:
- Additional context or clarification
- New error messages or stack traces
- Links to related Slack threads or tickets
- Feedback on your hypotheses

When new information arrives:
1. Update the investigation document immediately
2. Add it to the Timeline with a timestamp
3. Re-evaluate existing hypotheses in light of new evidence
4. Launch new investigation agents if the new info opens new leads
5. Tell the user how the new info changes the picture

## Using the user as a resource

You do not have direct database access. When you need to look up application data to
support or advance the investigation, **ask the user to check Django admin**. They can
look things up for you and report back.

Examples of what to ask for:
- Provider details — name, status, configuration, associated organizations
- Case or record state — current status, assigned provider, timestamps, audit trail
- Relational data — which objects are linked to which (e.g. case → provider → org)
- User account info — permissions, roles, last login, feature flags
- Any model data that would help confirm or refute a hypothesis

When asking:
- Be specific about what you need. Name the model/table and the lookup key (ID, email,
  slug, etc.) so the user can find it quickly.
- Explain briefly WHY you need it — what hypothesis it will confirm or rule out.
- One lookup at a time unless multiple are clearly independent.
- Add whatever the user reports back to the investigation document under Evidence.

## Rules

- NEVER guess at root causes — find evidence or say you don't know yet.
- ALWAYS update the Obsidian document as you go. It is the living record of this investigation.
- Ask questions when you need clarification. One question at a time.
- When launching agents, give them ALL the context they need — they have no memory
  of this conversation. Include service names, time ranges, file paths, error messages.
- Cite specific evidence: log lines, commit hashes, file:line references, trace IDs.
- If you can't find the root cause, document what you investigated, what you ruled out,
  and what the next steps should be for escalation.
- Keep the user informed of progress. Brief updates after each investigation wave.
