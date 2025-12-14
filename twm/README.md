# TWM - Tmux Workspace Manager

Git worktree workflow integration with tmux using [twm](https://github.com/vinnymeller/twm).

## Installation

```bash
# Install twm via cargo (not homebrew - that's a different tool)
cargo install twm

# Stow the configuration
cd ~/.dotfiles && stow twm
```

## Directory Structure

Projects are organized as:
```
~/Developer/
  └── Org/
      └── Project/
          ├── .bare/          # Bare git repository
          ├── .git            # File pointing to .bare
          ├── main/           # Main branch worktree
          ├── feature-foo/    # Feature branch worktree
          └── fix-bar/        # Another worktree
```

## Commands

### `twm-clone <git-url>`

Clone a repository as a bare repo with worktree setup.

```bash
twm-clone git@github.com:Org/project.git
twm-clone https://github.com/Org/project.git
```

**What it does:**
1. Parses org/project from URL
2. Creates `~/Developer/Org/Project/`
3. Clones as bare repo into `.bare/`
4. Creates `.git` file pointing to bare repo
5. Adds default branch (main/master) as first worktree
6. Runs `twm-worktree-setup` for initial setup

### `twm-branch <branch> [base]`

Create a new worktree for a branch.

```bash
# Checkout existing remote branch
twm-branch feature-auth

# Create new branch from base
twm-branch feature-new main
```

**What it does:**
1. Fetches from origin
2. Creates worktree tracking remote (or new branch from base)
3. Opens the worktree with twm

### `twm-remove [branch]`

Remove a worktree and its tmux session.

```bash
# Remove specific worktree (must be merged)
twm-remove feature-auth

# Remove current worktree
cd feature-auth && twm-remove

# Force remove unmerged worktree
twm-remove --force feature-auth
```

**What it does:**
1. Checks if branch is merged (unless `--force`)
2. Kills the tmux session
3. Removes the git worktree
4. Deletes the branch

**Safety:** Refuses to remove `main` or `master` branches.

### `twm-worktree-setup`

Automatically run when opening a worktree. Sets up the development environment.

**What it does:**
1. Fetches `.env.local` (or `.env`) from 1Password if missing
2. Sets `PORT` environment variable based on project type and worktree index
3. Installs dependencies (npm/yarn/pnpm/bundle/poetry/uv)

## 1Password Integration

Environment files are stored in 1Password with the naming convention:

```
Item name: env-{org}-{project}
Vault: Development
Field: notesPlain
```

Example: For `~/Developer/Acme/webapp`, the item would be `env-acme-webapp`.

## Port Configuration

Ports are assigned based on project type and worktree index:

| Project Type | Base Port |
|--------------|-----------|
| Next.js      | 3000      |
| Vite         | 5173      |
| Rails        | 3000      |
| Django       | 8000      |

Worktrees get sequential ports: `main` = base, `feature-a` = base+1, etc.

Override in project root with `.twm.yaml`:
```yaml
base_port: 4000
```

## Tmux Keybindings

| Binding | Action |
|---------|--------|
| `Ctrl-a t` | Open twm workspace selector |

## Shell Aliases

```bash
t        # Alias for twm
home     # Create/attach to home session
```

## Layouts

Layouts are defined per project type and create consistent window setups:

### Next.js / Vite
1. **nvim** - Neovim
2. **claude** - Claude Code
3. **servers** - Dev server + Storybook (if available)

### Rails
1. **nvim** - Neovim
2. **claude** - Claude Code
3. **server** - bin/dev

### Django
1. **nvim** - Neovim
2. **claude** - Claude Code
3. **server** - manage.py runserver

### Default
1. **nvim** - Neovim
2. **claude** - Claude Code
3. **shell** - Empty shell

## Files

| File | Purpose |
|------|---------|
| `.config/twm/twm.yaml` | Main twm configuration |
| `.local/bin/twm-clone` | Clone repos as bare + worktrees |
| `.local/bin/twm-branch` | Create worktrees for branches |
| `.local/bin/twm-remove` | Remove worktrees and sessions |
| `.local/bin/twm-worktree-setup` | Environment setup (1Password, PORT, deps) |

## Workflow Example

```bash
# Clone a new project
twm-clone git@github.com:Acme/webapp.git
# Opens tmux session: Acme/main

# Start a new feature
twm-branch feature-auth main
# Opens tmux session: Acme/feature-auth

# Work on the feature...
# Push, create PR, merge...

# Clean up
twm-remove feature-auth
# Kills session, removes worktree, deletes branch
```
