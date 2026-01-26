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
stow tmux

# Git requires --dotfiles flag to link dot-gitignore as .gitignore
stow --dotfiles git

# Remove/unlink configuration
stow -D tool-name

# Re-link after changes
stow -R tool-name
```

### Tmux Session Management
```bash
# Start predefined development sessions using Smug
smug start sentinel
smug start black-omen-web
smug start health-web
smug start varia
smug start zodiac

# List available sessions
smug list

# Create new session template
smug new project-name
```

### macOS System Preferences
```bash
# Apply macOS defaults
source .macos
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
- `tmux/` - Terminal multiplexer (Ctrl+A prefix, vim-style navigation)
- `starship/` - Cross-shell prompt with Git integration

**Session & File Management**
- `smug/` - Tmux session templates (sentinel, black-omen-web, health-web, varia, zodiac, etc.)
- `yazi/` - Terminal file manager configuration
- `lsd/` - Modern ls replacement configuration

**Version Control**
- `git/` - Git configuration (.gitconfig, global gitignore via dot-gitignore)
- `lazygit/` - Git TUI configuration

**Search & Navigation**
- `ripgrep/` - Fast text search (.ripgreprc, .ignore)

**Runtime & Language Tools**
- `asdf/` - Version manager with default packages for Ruby, Node.js, Python
- `ruby/` - Ruby development configs (.rubocop.yml, .rspec, .irbrc, .pryrc, .guard.rb)
- `homebrew/` - Brewfile for reproducible package installs

**System Utilities**
- `karabiner/` - Keyboard remapping for macOS
- `bin/` - Custom scripts in .local/bin (critique)

**AI Tools**
- `claude/` - Claude Code configuration (settings, custom agents, hooks, commands)

## Working with Configurations

When modifying tool configurations:
1. Edit files in the appropriate tool directory
2. Use `stow -R tool-name` to re-link if file structure changes
3. Restart the relevant application or source configuration files

For tmux specifically, use `tmux source-file ~/.tmux.conf` or restart tmux sessions to apply changes.