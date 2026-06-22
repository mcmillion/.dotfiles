# Investigation agents

Spawn via the Agent tool with `subagent_type` set to the name below. Send all independent
calls in a SINGLE message so they run concurrently. Agents have no memory of this
conversation — give each one ALL the context it needs (service names, time ranges, file
paths, error messages, entity IDs).

## `datadog-investigator`
Searches Datadog logs, traces, metrics, monitors.
- **Give it**: service name(s), environment (always `production`), time range, error description, entity IDs
- **Returns**: diagnosis with error messages, service impact, timeline, root-cause assessment
- **Best for**: error patterns, tracing requests across services, metric anomalies

## `codebase-researcher`
Explores codebases to find relevant files, symbols, patterns.
- **Give it**: what you're looking for (function, endpoint, feature area, error message)
- **Returns**: file paths, line numbers, structure, entry points
- **IMPORTANT**: multiple repos are available under `~/Developer/galileo-inc/` — frontend (`frontend-monorepo/master`), both backends (`api/master`, `core-api/main`), and the two user-facing mobile apps (`health-ios/master`, Swift; `health-android/master`, Kotlin). Explore ALL repos relevant to the issue; for patient-reported problems the mobile apps are often where the user-facing behavior lives. Ask the user for a repo path only if it's not under that directory.
- **Best for**: mapping code paths, finding where logic lives

## `git-investigator`
Researches git history to find when changes were introduced.
- **Give it**: a file path or feature area, the repo path, a question about what changed
- **Returns**: key commits, blame info, narrative of changes
- **Best for**: finding when a bug was introduced, recent regressions

## `error-investigator`
Traces stack traces and exceptions through the codebase.
- **Give it**: a stack trace or error message + the codebase path
- **Returns**: root-cause location (file:line), call path, contributing factors
- **Best for**: diagnosing specific errors once you have a trace

## `web-researcher`
Fetches and distills web content.
- **Give it**: a URL or research topic
- **Returns**: compact summary
- **Best for**: docs, known issues, fetching content from links (Slack/Datadog)

## `log-analyzer`
Parses application logs.
- **Give it**: a file path or command that produces log output
- **Returns**: distilled summary of errors, patterns, anomalies
- **Best for**: local log files or command output

## `ci-investigator`
Investigates GitHub Actions CI failures.
- **Give it**: PR number, branch, run ID, or "latest"
- **Returns**: which job/step failed, the actual error, whether it's a flake
- **Best for**: determining if the issue ties to a failed deploy or broken build

## `general-purpose`
Catch-all for tasks that don't fit a specialized agent.
