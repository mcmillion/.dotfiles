#==============================================================================
# OS-SPECIFIC SETUP
#==============================================================================
# Brew, PATH, SSH agent, and platform-only aliases live in per-OS fragments.

case "$(uname -s)" in
  Darwin) [ -f ~/.zshrc.darwin ] && source ~/.zshrc.darwin ;;
  Linux)  [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux ;;
esac

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"



#==============================================================================
# BASIC ZSH CONFIGURATION
#==============================================================================

# Fix backspace in zsh vi mode
bindkey "^?" backward-delete-char

# Case-Insensitive completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:(mosh|ssh|scp|sftp|rsync):*' known-hosts-files ''
zstyle ':completion:*:(mosh|ssh|scp|sftp|rsync):*' ignored-patterns '*.*'

# Auto-ls when cd-ing into directories
cd () {
  builtin cd "$@";
  ls -Ah --color=auto;
}



#==============================================================================
# ZOXIDE
#==============================================================================

eval "$(zoxide init zsh --hook pwd)"
function z() {
    __zoxide_z "$@" && ls -Ah --color=auto
}




#==============================================================================
# HISTORY
#==============================================================================

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase               # Erase duplicates in the history file
setopt appendhistory        # Append history to the history file (no overwriting)
setopt sharehistory         # Share history across terminals
setopt incappendhistory     # Immediately append to the history file, not just when a term is killed

# Silence the terminal bell (no dock bubble / screen flash)
unsetopt beep               # no bell from the line editor
unsetopt hist_beep          # no bell on history edge
setopt nolistbeep           # no bell on ambiguous completion



#==============================================================================
# COMMON ALIASES
#==============================================================================

alias reload='source ~/.zshrc'
alias c='claude'
alias cx='brew upgrade --cask codex --quiet 2>/dev/null; codex'
alias l='ls -Ah --color=auto'
alias ls='ls -Ah --color=auto'
alias ll='ls -Alh --color=auto'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias mkdir='mkdir -pv'
alias x='exit'
alias q='exit'
alias grep='grep --color=always'

alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'



#==================================================================================================
# TMUX / VIM / FILES
#==================================================================================================

alias kill_all_tmux_sessions='tmux ls | awk '\''{print $1}'\'' | sed '\''s/://g'\'' | xargs -I{} tmux kill-session -t {}'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

alias clear_nvim_sessions='rm ~/.local/share/nvim/sessions/*'

alias y='yazi'

export TODO_FILE="$HOME/todo.txt"  # global fallback when no local todo.txt
t() {
  local root
  if root=$(git rev-parse --show-toplevel 2>/dev/null) && [ -f "$root/todo.txt" ]; then
    tuxedo "$root/todo.txt" "$@"
  elif [ -f todo.txt ]; then
    tuxedo todo.txt "$@"
  else
    tuxedo "$@"
  fi
}



alias home='tmux new-session -A -s home'



#==================================================================================================
# GIT
#==================================================================================================

alias lg='lazygit'
alias ld='lazydocker'
alias gr='gh dash'
alias gs='git status'
alias gd='git diff'
alias ga='git add . && git status'
alias gc='git commit --verbose && git --no-pager log -n 1'
alias gca='git commit --amend --verbose && git --no-pager log -n 1'
alias gl='git l'
alias gb='git branch'
alias gpub='git publish'
alias gunpub='git unpublish'
alias gpu='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gri='git rebase -i `fcs`~1'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gwt='git worktree'

gsync() {
  local main current
  main=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  current=$(git rev-parse --abbrev-ref HEAD)

  [ -z "$main" ] && return 1

  if [ "$current" = "$main" ]
  then
    git pull
  else
    git fetch origin $main:$main
  fi

  git fetch --all
  git checkout $main
  git branch --merged $main | grep -v "\* $main" | xargs -n 1 git branch -d
}



#==================================================================================================
# LS COLORS
#==================================================================================================

# GNU ls colors. dircolors ships with GNU coreutils (on PATH on both OSes).
command -v dircolors >/dev/null 2>&1 && eval "$(dircolors -b)"



#==================================================================================================
# FZF
#==================================================================================================

export FZF_TMUX=0
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!*.uid" 3> /dev/null'
export FZF_DEFAULT_OPTS='--height 50% --color=fg:7,hl:8,fg+:15,hl+:4,info:9,prompt:4,pointer:4,marker:4,spinner:4,border:3,header:3'
source <(fzf --zsh)

gco() {
  if [ "$1" = '-a' ] || [ "$1" = '' ]
  then
    # Fuzzy checkout branch
    local branches branch

    if [ "$1" = '-a' ]
    then
      # Fetch remote branches and show remote and local branches
      git fetch origin --prune
      branches=$(git branch --all | grep -v HEAD) &&
    else
      # Just show local branches
      branches=$(git branch | grep -v HEAD) &&
    fi

    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")

  elif [ "$1" = '-b' ]
  then
    if [ -n "$2" ]
    then
      # Create and check out a new branch
      git checkout -b $(echo "$2")

    else
      # Invalid argument
      echo "Error: Branch name is required (gco -b [new_branch_name])"
    fi

  else
    # Checkout local branch
    git checkout $1

  fi
}

# FZF commit SHA (used in gri)
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# FZF kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}



#==================================================================================================
# ASDF
#==================================================================================================

export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed



#==================================================================================================
# RUBY / RAILS
#==================================================================================================

alias be='noglob bundle exec'
alias migrate='bundle && bin/rails db:migrate && bin/rails db:migrate RAILS_ENV=test'
alias kill_rails_server='kill -9 $(lsof -i tcp:3000 -t)'



#==================================================================================================
# PYTHON
#==================================================================================================

# Work Bootstrap (no-ops unless pyenv is installed)
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH="$PATH:$HOME/.local/bin"
  eval "$(pyenv init -)"

  # git -C ~/Developer/Galileo/dotfiles reset --hard origin/master > /dev/null 2>&1
  # git -C ~/Developer/Galileo/dotfiles pull > /dev/null 2>&1
  source ~/Developer/galileo-inc/dotfiles/bootstrap.sh
fi



#==================================================================================================
# DOCKER
#==================================================================================================

alias d='docker'
alias dc='docker-compose'



#==================================================================================================
# RUST
#==================================================================================================

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"



#==================================================================================================
# STARSHIP PROMPT (must be after fzf to avoid zle-keymap-select conflicts)
#==================================================================================================

eval "$(starship init zsh)"



#==================================================================================================
# HERDR (terminal session manager)
#==================================================================================================

# Auto-launch / attach to the persistent herdr session for interactive shells.
# Skips when already inside herdr, in VS Code's terminal, or when herdr is absent.
if [[ -o interactive ]] && [[ -z "$HERDR_ENV" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && command -v herdr >/dev/null 2>&1; then
  herdr
fi
