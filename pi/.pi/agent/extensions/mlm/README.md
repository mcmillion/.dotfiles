# Personal Pi extensions

This directory is the source of personal Pi extensions, managed by the `pi/` GNU Stow package in this repository.  Pi auto-discovers `extensions/*/index.ts` from `~/.pi/agent/extensions/`; after changing these files, run `/reload` in Pi.

## Codex usage

`codex-usage.ts` adds the current ChatGPT Codex primary and secondary usage windows to the installed Powerline footer. It reads the existing `openai-codex` OAuth credential from Pi's `auth.json`, calls ChatGPT's current usage endpoint at session start, after a Codex response, and once a minute, and shows reset countdowns.

The ChatGPT usage endpoint is not a documented stable API. Failure is intentionally silent, so an expired login or endpoint change leaves the footer unchanged rather than interrupting Pi.
