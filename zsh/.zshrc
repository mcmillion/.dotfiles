eval "$(/opt/homebrew/bin/brew shellenv)"



#==============================================================================
# BASIC ZSH CONFIGURATION
#==============================================================================

# Fix backspace in zsh vi mode
bindkey "^?" backward-delete-char

# Case-Insensitive completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Auto-ls when cd-ing into directories
cd () {
  builtin cd "$@";
  ls -aG;
}



#==============================================================================
# PROMPT
#==============================================================================

eval "$(starship init zsh)"



#==============================================================================
# ZOXIDE
#==============================================================================

eval "$(zoxide init zsh)"



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



#==============================================================================
# COMMON ALIASES
#==============================================================================

alias dot='cd ~/.dotfiles'
alias reload='source ~/.zshrc'
alias c='clear'
alias l='ls'
alias ls='ls -aG'
alias ll='ls -lh'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias mkdir='mkdir -pv'
alias ..='cd ..'
alias x='exit'
alias q='exit'
alias grep='grep --color=always'



#==================================================================================================
# SSH
#==================================================================================================

export SSH_AUTH_SOCK='~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock'



#==================================================================================================
# TMUX / VIM
#==================================================================================================

alias home='tmux new-session -A -s home'
alias kill_all_tmux_sessions='tmux ls | awk '\''{print $1}'\'' | sed '\''s/://g'\'' | xargs -I{} tmux kill-session -t {}'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

alias clear_nvim_sessions='rm ~/.local/share/nvim/sessions/*'



#==================================================================================================
# GIT
#==================================================================================================

alias g='gh dash'
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
alias grm='gco master && gpl && gco - && git rebase master'
alias grt='gco trunk && gpl && gco - && git rebase trunk'
alias gri='git rebase -i `fcs`~1'
alias grc='git rebase --continue'
alias gra='git rebase --abort'

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
# LS
#==================================================================================================

export LSCOLORS='ExfxbxdxCxegedabagacad'



#==================================================================================================
# FZF
#==================================================================================================

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "" 3> /dev/null'
export FZF_DEFAULT_OPTS='--height 50% --color=bg:0,fg:7,hl:8,bg+:0,fg+:15,hl+:4,info:9,prompt:4,pointer:4,marker:4,spinner:4,border:3,header:3'
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

    branch=$(echo "$branches" | fzf-tmux +m) &&
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

# FZF tmuxinator
mux() {
  local selected=$(smug list | fzf --prompt="Project: " -m -1 -q "$1")

  if [ -n "$selected" ]; then
    smug start "$selected" -a
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

# Work Bootstrap
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PATH="$PATH:/Users/mmcmillion/.local/bin"
  eval "$(pyenv init -)"

  # git -C ~/Developer/Galileo/dotfiles reset --hard origin/master > /dev/null 2>&1
  # git -C ~/Developer/Galileo/dotfiles pull > /dev/null 2>&1
  source ~/Developer/Galileo/dotfiles/bootstrap.sh
fi



#==================================================================================================
# POSTGRES / REDIS / ETC
#==================================================================================================

alias fix_stuck_postgres='rm /opt/homebrew/var/postgres/postmaster.pid; brew services restart postgresql'



#==================================================================================================
# DOCKER
#==================================================================================================

alias d='docker'
alias dc='docker-compose'



#==================================================================================================
# IOS / ANDROID
#==================================================================================================

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias fl='bundle exec fastlane'



#==================================================================================================
# RUST
#==================================================================================================

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"



#==================================================================================================
# OSX
#==================================================================================================

alias finder='open -a Finder ./'
alias cleanup_ds="find . -type f -name '*.DS_Store' -ls -delete"
alias cleanup_open_with='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
alias add_blank_space_to_dock="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}' && killall Dock"
alias add_small_blank_space_to_dock="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"small-spacer-tile\";}'; killall Dock"
alias flush_dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias disable_hidden_files_in_finder='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias enable_hidden_files_in_finder='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias disable_local_timemachine='sudo tmutil disablelocal'
alias enable_local_timemachine='sudo tmutil enablelocal'
alias disable_key_press_and_hold='defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'
alias enable_key_press_and_hold='defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true'



# Start tmux home session automatically
if [[ ("$OSTYPE" == "darwin"*) && "$TERM_PROGRAM" != "vscode" && (-z "$TMUX") ]]; then
  tmux new-session -A -s home
fi
