---
name: up-next
description: List the work that's ready to pick up by scanning the project board for issues with Status "ready-for-work" and presenting a summarized, ranked shortlist. Use when the user asks "what's next", "what's up next", or invokes /up-next. Can hand a chosen issue to /pickup.
disable-model-invocation: true
argument-hint: "[owner/repo — defaults to current repo]"
allowed-tools:
  - Bash
  - Agent
  - Read
---

# What's up next

Surface the issues that are ready to be worked on right now and present them as a tight shortlist the user can pick from.

## Process

### 1. Determine the repo

Default to the current repo (cwd). If the user passed an `owner/repo`, target that instead.

### 2. Fetch ready work

`ready-for-work` is a **Status field on the org's GitHub Project (v2)**, not an issue label — so `gh issue list --label` won't see it. Query the project board instead.

Requires the `read:project` scope. If a query fails with a missing-scope error, tell the user to run `gh auth refresh -s read:project,project` (interactive browser flow) and stop until they confirm.

Find the project, then list its items filtered to `Status == ready-for-work`:

```bash
# Resolve the org and project number (one project here: "Zodiac Rewrite Prototype" = #2 under galileo-inc)
OWNER=galileo-inc
PROJECT=$(gh project list --owner "$OWNER" --format json | jq -r '.projects[0].number')

# Items in ready-for-work — includes the board Size field when set
gh project item-list "$PROJECT" --owner "$OWNER" --format json --limit 100 \
  | jq -r '.items[] | select(.status=="ready-for-work")
      | {number: .content.number, title: .content.title, url: .content.url,
         assignees: .content.assignees, size: .size, repo: .content.repository}'
```

If the list is empty, say so plainly and stop — don't pad with unrelated issues.

### 3. Filter and rank

- Drop items that already have an assignee or an in-flight branch/PR (a quick `gh pr list --search "<issue#>"` check), unless the user asked to include them.
- Prefer the board's `Size` field when present; otherwise infer rough effort.
- For a richer ranking — what each item involves, what's blocked, what's quick — delegate to the `work-finder` agent rather than reading every thread inline. Tell it to restrict to the `ready-for-work` items found above (pass it the issue numbers). Use its output to order the list.

### 4. Present the shortlist

Numbered list, terse. Per item:

- **#num — Title**
- **Gist** — one line on what the work is
- **Size** — rough effort (S / M / L) if discernible
- **Blocked by** — only if something blocks it

Keep it scannable. No raw issue dumps.

### 5. Offer to start

End by offering to feed a chosen issue into `/pickup` (the ingestion + planning skill). If the user names a number, invoke `/pickup <issue#>`.
