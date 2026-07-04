---
name: distill
description: Distill quick captures from the personal knowledge vault's inbox (~/obsidian/personal/agents/inbox/) into their correct topical home. Proposes a routing plan, applies it after approval, and deletes each inbox note once its content lives in the vault. Use when the user invokes /distill or asks to process/clean up the vault inbox.
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - Bash
---

# Distill the vault inbox

Promote quick captures in `~/obsidian/personal/agents/inbox/` into their correct
topical home. Read `~/obsidian/personal/agents/README.md` first for the folder map
and house style.

## Procedure

1. **Gather.** List `agents/inbox/YYYY-MM-DD-*.md`, oldest first. Ignore
   `README.md` and anything not matching the date-prefixed capture pattern. If the
   inbox is empty, say so and stop.

2. **Route each capture.** Decide its home:
   - Use the capture's `Distill to:` hint if present, but verify it still fits.
   - Otherwise use the folder map in `agents/README.md` to pick the folder, then
     grep within it to find the exact target note.
   - If no existing note fits but a folder does: plan a NEW note in that folder.
   - If no existing folder fits: plan a NEW topical folder + note, AND plan to add
     a line for it to the folder map in `agents/README.md`.

3. **Propose (gate).** Print the full plan before writing anything:
   - one line per capture: `inbox/<file>  ->  merge into <target>#<section>` or
     `->  new note <path>` or `->  new folder+note <path> (+ map update)`
   - flag anything ambiguous or that you'd drop/split
   Wait for the user's approval. Do not edit any file until they confirm.

4. **Apply** (after approval):
   - Merge/integrate the capture's content into the target, matching house style
     (`# Title`, purpose line, `Related:` wikilinks, sections). Integrate, don't
     blindly append - fold facts into the right section, dedupe.
   - Add `tags:` frontmatter to the distilled note if it helps retrieval (optional;
     no controlled taxonomy yet - use sensible tags).
   - For new homes, create the note/folder and update the folder map in
     `agents/README.md`.
   - Delete the inbox capture once its content is safely in place.

5. **Report.** Summarize what moved where and what (if anything) you skipped.

## Notes

- Recovery exists (git mirror + Obsidian Sync history), but the propose gate is
  the real safety - get routing right before touching curated notes.
- Do not reorganize existing topical notes beyond what's needed to land the
  capture. Keep edits minimal and on-topic.
- Leave the inbox empty-when-done for every capture you distilled.
