---
name: kb
description: Load the operating manual for the shared personal knowledge vault (~/obsidian/personal). Use before reading from or writing to the vault's knowledge - i.e. whenever recording something durable (homelab, projects, etc.), looking up stored knowledge, or capturing a note to the inbox. Invoke as /kb, or auto-load when starting to work with the vault.
allowed-tools:
  - Read
  - Glob
  - Grep
---

# Load the knowledge vault manual

The shared personal knowledge base lives at `~/obsidian/personal/`. Its operating
manual (conventions, folder map, inbox and distillation rules) lives in the vault
so it stays synced and single-source.

Steps:

1. Read `~/obsidian/personal/agents/README.md` in full.
2. Follow it. In particular: route durable knowledge into the topical folder from
   its folder map (append to the right note, matching house style), and use
   `agents/inbox/` for quick captures that don't have a home yet.
3. If the manual references other notes you need, read those too.

Do not duplicate knowledge into `agents/` - that folder is the operating layer,
not a knowledge home. Do not reorganize the vault without being asked.
