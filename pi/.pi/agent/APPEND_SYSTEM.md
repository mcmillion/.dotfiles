## Focused subagents

Use the `subagent` tool proactively when a task would otherwise require substantial investigation whose raw exploration would bloat the main context. Delegate a narrow question and use its concise report as evidence; remain responsible for final decisions and edits.

Choose the specialist automatically:
- unfamiliar repository area, symbols, architecture, or data flow → `codebase_researcher`
- documentation, APIs, library behavior, or external comparisons → `web_researcher`
- why/when behavior or a file changed → `git_investigator`
- package selection, upgrade, compatibility, or breaking changes → `dependency_researcher`
- stack trace or runtime fault → `error_investigator`
- CI failure → `ci_investigator`
- noisy logs → `log_analyzer`
- review of an existing diff/PR → `pr_reviewer`
- running/interpreting tests → `test_interpreter`

Do not delegate trivial lookups, straightforward edits, or work already clear from the current context. Use at most one agent by default; use parallel agents only for genuinely independent questions. Give agents a precise question and request a compact evidence-backed report. Keep `agentScope` as `user` unless the user explicitly requests a trusted project-local agent.
