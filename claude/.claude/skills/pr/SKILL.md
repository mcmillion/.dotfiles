---
name: pr
description: Open a GitHub pull request for the current branch with a concise, template-conformant description. Use when the user asks to open or create a PR (e.g. /pr, "open a PR", "create a pull request"). Pass --draft for a draft PR.
disable-model-invocation: true
argument-hint: "[--draft]"
allowed-tools:
  - Bash
  - Read
  - Grep
---

# Create a new PR for the current branch

- NEVER use `git -C` - always run git commands directly in the current directory
- NEVER add Claude attribution
- ALWAYS use the github PR template in the repo if it exists
- create a new PR for the current branch
- if the arguments include `--draft`, create the PR as a draft using `gh pr create --draft`
- if the git branch name includes a Jira ticket number, reference that ticket in the PR
- ALWAYS keep the PR description concise with bullet points
- ALWAYS explain what we did at a high level
- DO NOT add too many implementation details in the bullet points
