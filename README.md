# Dotfiles

Personal dotfiles repository managed with GNU Stow.

## Tools Configured

This repository contains configuration for the following tools:

### Development Environment
- **Neovim** - Modern text editor with extensive Lua-based configuration
  - LSP support, autocompletion, syntax highlighting
  - Plugins: Copilot, Fugitive, fzf-lua, Treesitter, and more
- **Herdr** - Agent-aware terminal multiplexer for managing AI coding agents
  - Custom prefix (Ctrl+A), pane navigation, workspace management
- **Starship** - Fast shell prompt with Git integration
- **asdf** - Version manager for multiple runtime versions
  - Configured with default packages for Ruby, Node.js, and Python

### Package Management
- **Homebrew** - Package manager with Brewfile for reproducible installs

### Utilities
- **EditorConfig** - Consistent coding styles across editors
- **Claude** - AI assistant configuration
- **Codex** - OpenAI Codex CLI configuration
- **fzf** - Command-line fuzzy finder
- **ripgrep** - Fast text search tool
- **zoxide** - Smart directory jumper
- **Git** - Version control with LFS support

### Applications (via Homebrew Cask)
- **Ghostty** - GPU-accelerated terminal emulator
- **Raycast** - Productivity launcher
- **Mouseless** - Mouse-free navigation tool

## Setup Instructions

These dotfiles run on both macOS and Linux. See [Platform Notes](#platform-notes)
for how the mac/Linux split works.

### Prerequisites

Install Homebrew if you haven't already (same command on macOS and Linux):

```bash
/bin/bash -c "$(curl -fsSL \
  https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

On Linux this installs to `/home/linuxbrew/.linuxbrew`; on macOS to
`/opt/homebrew`. The shell config detects this automatically per OS.

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

4. Stow configurations. Only stow what a given machine needs.

Shared (both macOS and Linux):

```bash
stow zsh nvim starship asdf homebrew editorconfig claude codex herdr \
  ripgrep yazi lazygit lazydocker ghostty tuxedo ruby presenterm bin

# Git requires --dotfiles flag to properly link .gitignore
stow --dotfiles git
```

macOS only:

```bash
stow karabiner   # keyboard remapping (macOS-only)
```

Linux: skip `karabiner` (macOS-only).

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

## Platform Notes

The config targets macOS and Linux from one shared base, splitting only where
the OS genuinely differs.

- **Shell split.** `~/.zshrc` and `~/.zprofile` are shared. Each sources a
  per-OS fragment (`.zshrc.darwin`/`.zshrc.linux`,
  `.zprofile.darwin`/`.zprofile.linux`) chosen by `uname`. Brew prefix, the
  1Password SSH agent socket, and macOS-only system aliases live in those
  fragments. Both fragments are stowed everywhere; the base picks one at
  runtime. Per-host (not per-OS) differences are handled with ad-hoc hostname
  conditions when needed.
- **GNU coreutils everywhere.** The macOS fragment puts
  `coreutils/libexec/gnubin` on `PATH` so `ls`, `dircolors`, etc. behave the
  same as Linux. Colors come from `dircolors`/`LS_COLORS`, not BSD `LSCOLORS`.
- **Brewfile.** One file. macOS-only formulae and all casks are wrapped in
  `if OS.mac?`, so `brew bundle` is safe to run on Linux (casks are unsupported
  by Linux brew).
- **Git signing.** Commit signing uses 1Password's `op-ssh-sign`, referenced by
  name. A small wrapper at `~/.local/bin/op-ssh-sign` (from the `bin` package)
  execs the right binary per OS (`/Applications/1Password.app/...` on macOS,
  `/opt/1Password/op-ssh-sign` on Linux), so `git/.gitconfig` stays shared.
  Requires the 1Password desktop app with the SSH agent enabled.
- **herdr.** Cross-platform; installed via the shared Brewfile. `~/.zshrc`
  auto-launches/attaches herdr for interactive shells, skipping when already
  inside herdr (`$HERDR_ENV`), in VS Code's terminal, or when herdr is
  absent.

### Codex Notes

Only Codex instructions/support files are stow-managed here. Keep
`~/.codex/config.toml` local and machine-specific.

The `codex` package currently manages:
- `~/.codex/AGENTS.md`
- `~/.codex/agents/*` custom subagents
- `~/.agents/skills/grill-me` for design interrogation before implementation
