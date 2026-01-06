# Dotfiles

Personal dotfiles repository managed with GNU Stow.

## Tools Configured

This repository contains configuration for the following tools:

### Development Environment
- **Neovim** - Modern text editor with extensive Lua-based configuration
  - LSP support, autocompletion, syntax highlighting
  - Plugins: Copilot, Fugitive, fzf-lua, Treesitter, and more
- **Tmux** - Terminal multiplexer with vim-style keybindings
  - Custom prefix (Ctrl+A), pane navigation, session management
  - **Smug** - Tmux session manager with project configurations
- **Starship** - Fast shell prompt with Git integration
- **asdf** - Version manager for multiple runtime versions
  - Configured with default packages for Ruby, Node.js, and Python

### Package Management
- **Homebrew** - Package manager with Brewfile for reproducible installs

### Utilities
- **EditorConfig** - Consistent coding styles across editors
- **Claude** - AI assistant configuration
- **fzf** - Command-line fuzzy finder
- **ripgrep** - Fast text search tool
- **zoxide** - Smart directory jumper
- **Git** - Version control with LFS support

### Applications (via Homebrew Cask)
- **Ghostty** - GPU-accelerated terminal emulator
- **Raycast** - Productivity launcher
- **Mouseless** - Mouse-free navigation tool

## Setup Instructions

### Prerequisites

Install Homebrew if you haven't already:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installation

1. Install GNU Stow:

```bash
brew install stow
```

2. Clone this repository:

```bash
git clone https://github.com/your-username/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

3. Install packages from Brewfile:

```bash
brew bundle --file=homebrew/Brewfile
```

4. Stow individual configurations:

```bash
# Stow all configurations
stow */

# Or stow individual tools
stow nvim
stow tmux
stow starship
stow asdf
stow homebrew
stow editorconfig
stow claude
stow smug
```

5. Reload your shell or start a new terminal session to apply changes.

### Managing Configurations

To add a new configuration:
```bash
# Create new directory and add config files
mkdir new-tool
# Add your config files to new-tool/
stow new-tool
```

To remove a configuration:
```bash
stow -D tool-name
```

To restow (useful after making changes):
```bash
stow -R tool-name
```