# Focused Pi subagents

This is Pi's upstream `subagent` extension, vendored from the installed Pi distribution and configured with focused, read-mostly global agents in `~/.pi/agent/agents/`.

## Purpose

Use agents to investigate a narrow question in an isolated Pi process, then return a bounded report to the parent session. They are context reducers, not an automatic implementation pipeline.

## Available agents

- `codebase_researcher`
- `web_researcher`
- `git_investigator`
- `dependency_researcher`
- `error_investigator`
- `ci_investigator`
- `log_analyzer`
- `pr_reviewer`
- `test_interpreter`

All reports are instructed to stay under 1,000 words and avoid raw tool output. Agent model selection is omitted deliberately: child agents inherit the active Pi/GPT model and thinking level.

## Use

Ask Pi to delegate explicitly, for example:

- `Use codebase_researcher to map the authentication path before proposing edits.`
- `Use git_investigator to explain why this setting exists.`
- `Use web_researcher to compare the current API guidance from official docs.`
- `Use test_interpreter to run the focused test suite and report failures only.`

The extension provides a `subagent` tool supporting one agent, parallel tasks, and sequential chains. Keep chains short and pass compact outputs only when one investigation genuinely depends on another.

## Maintenance

The extension source was copied from Pi's bundled example. Refresh it deliberately when upgrading Pi; retain the local agent definitions and report-size constraints.
