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
# Link all configurations
stow */

# Link specific tool configuration
stow nvim
stow tmux

# Remove/unlink configuration
stow -D tool-name

# Re-link after changes
stow -R tool-name
```

### Tmux Session Management
```bash
# Start predefined development sessions using Smug
smug start sentinel      # Neovim development session
smug start black-omen-web
smug start health-web

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

### Key Tool Configurations

**Neovim** (`nvim/`)
- Lua-based configuration with extensive plugin ecosystem
- LSP integration, autocompletion, and syntax highlighting
- Custom keybindings and file type specific settings
- Organized into `lua/config/` and `lua/plugins/` directories

**Tmux** (`tmux/`)
- Custom prefix key (Ctrl+A instead of Ctrl+B)
- Vim-style pane navigation
- Extended history and reduced escape time
- Status bar with system monitoring

**Smug** (`smug/.config/smug/`)
- Project-specific tmux session templates
- Predefined window layouts and commands
- Sessions for different development projects (sentinel, black-omen-web, health-web, etc.)

**Development Tools**
- `asdf/` - Runtime version manager with default packages
- `starship/` - Shell prompt configuration
- `lazygit/` - Git TUI configuration
- `yazi/` - File manager configuration

### Homebrew Integration
The `homebrew/Brewfile` contains all CLI tools and GUI applications managed by Homebrew, ensuring reproducible development environment setup.

## Working with Configurations

When modifying tool configurations:
1. Edit files in the appropriate tool directory
2. Use `stow -R tool-name` to re-link if file structure changes
3. Restart the relevant application or source configuration files

For tmux specifically, use `tmux source-file ~/.tmux.conf` or restart tmux sessions to apply changes.