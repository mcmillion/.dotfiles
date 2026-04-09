# AGENTS.md

Instructions for Codex when working in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow. Each top-level
directory is a stow package that mirrors the target structure under `$HOME`.

## Common Commands

### Package Management

```bash
brew bundle --file=homebrew/Brewfile
brew update && brew upgrade
```

### Stow Operations

```bash
stow */
stow codex
stow claude
stow nvim
stow tmux
stow -D tool-name
stow -R tool-name
stow --dotfiles git
```

## Working Conventions

- Edit files inside the appropriate package directory, not in `$HOME`
- Re-stow a package if you change its file layout
- Preserve existing structure and naming conventions across packages
- For Git global ignore, use `stow --dotfiles git`

## Tool Areas

- `codex/` contains global Codex CLI config under `~/.codex/`
- `claude/` contains Claude Code config under `~/.claude/`
- `homebrew/` contains the Brewfile
- Most other directories are application-specific dotfiles packages
