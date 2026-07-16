# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow. Each directory represents a tool configuration that can be independently linked to the user's home directory using Stow.

## Common Commands

### Package Management
```bash
# Install all packages from Brewfile
brew bundle --file=homebrew/Brewfile

# Update packages
brew update && brew upgrade
```

### Stow Operations
```bash
# Link all configurations (most packages)
stow */

# Link specific tool configuration
stow nvim
stow herdr

# Git requires --dotfiles flag to link dot-gitignore as .gitignore
stow --dotfiles git

# Claude requires --no-folding: if ~/.claude is missing, plain stow links the
# whole directory and Claude Code then writes all its runtime state (sessions,
# history, credentials) inside the repo. --no-folding links the files instead.
stow --no-folding claude

# Remove/unlink configuration
stow -D tool-name

# Re-link after changes
stow -R tool-name
```

## Architecture

### Stow-based Configuration Management
Each tool has its own directory containing the configuration files in the same structure they should appear in `$HOME`. Stow creates symbolic links from the home directory to the dotfiles repository, allowing version control of configurations while keeping them in their expected locations.

### Tool Configurations

**Editor & Development**
- `nvim/` - Neovim with Lua-based config, LSP, Treesitter, and plugins
- `editorconfig/` - Consistent coding styles across editors

**Terminal & Shell**
- `zsh/` - Zsh shell configuration (.zshrc, .zprofile)
- `ghostty/` - Ghostty terminal emulator configuration
- `herdr/` - Agent-aware terminal multiplexer (Ctrl+A prefix) for AI coding agents
- `starship/` - Cross-shell prompt with Git integration

**Session & File Management**
- `yazi/` - Terminal file manager configuration

**Version Control**
- `git/` - Git configuration (.gitconfig, global gitignore via dot-gitignore)
- `lazygit/` - Git TUI configuration
- `hunk/` - Review-first terminal diff viewer; `review` (in bin/) opens the
  working tree diffed against the merge base with the default branch, and the
  `hunk-comments` Claude skill addresses review comments left in a live session
- `gh-dash/` - GitHub PR/issue dashboard (`gh dash` extension); One Dark
  theme, opened from herdr via `prefix+g`

**Search & Navigation**
- `ripgrep/` - Fast text search (.ripgreprc, .ignore)

**Runtime & Language Tools**
- `asdf/` - Version manager with default packages for Ruby, Node.js, Python
- `ruby/` - Ruby development configs (.rubocop.yml, .rspec, .irbrc, .pryrc, .guard.rb)
- `homebrew/` - Brewfile for reproducible package installs

**Presentation**
- `presenterm/` - Terminal markdown slide decks (config + sample deck under `.config/presenterm/`)

**System Utilities**
- `karabiner/` - Keyboard remapping for macOS
- `bin/` - Custom scripts in .local/bin (critique)

**AI Tools**
- `claude/` - Claude Code configuration (settings, custom agents, hooks, commands)
- `codex/` - Codex CLI configuration (`config.toml`, global `AGENTS.md`, notifier)

## Working with Configurations

When modifying tool configurations:
1. Edit files in the appropriate tool directory
2. Use `stow -R tool-name` to re-link if file structure changes
3. Restart the relevant application or source configuration files

For herdr specifically, use `herdr server reload-config` or `prefix+shift+r` to apply config changes without restarting.
