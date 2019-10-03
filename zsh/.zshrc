#==============================================================================
# ENVIRONMENT
#==============================================================================

export LANG=en_US.UTF-8
export TERM=screen-256color
export EDITOR='nvim'
export LESS='-RFX'
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:./bin/
export HOMEBREW_NO_ANALYTICS=1



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

export SPACESHIP_DIR_TRUNC_PREFIX='../'
export SPACESHIP_GIT_SYMBOL=''
export SPACESHIP_PACKAGE_SHOW=false
export SPACESHIP_NODE_SYMBOL='node '
export SPACESHIP_RUBY_SYMBOL='ruby '
export SPACESHIP_DOCKER_SYMBOL='docker '
export SPACESHIP_VI_MODE_COLOR='14'

# Shim to get vim mode indicator working in Spaceship
function zle-keymap-select() {
   zle reset-prompt zle -R
}
zle -N zle-keymap-select

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship



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

alias reload='source ~/.zshrc'
alias ls='ls -aG'
alias ll='ls -lh'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ..='cd ..'



#==================================================================================================
# TMUX / VIM
#==================================================================================================

alias mux='tmuxinator'
alias kill_all_tmux_sessions='tmux ls | awk '\''{print $1}'\'' | sed '\''s/://g'\'' | xargs -I{} tmux kill-session -t {}'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'



#==================================================================================================
# GIT
#==================================================================================================

alias gs='git status'
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
alias gri='git rebase -i `fcs`~1'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias cleanup_merged_branches="git checkout master && git branch --merged master | grep -v '^\*' | xargs -n 1 git branch -d"
alias cleanup_merge="find . \( -name '*.orig' -o -name '*.BACKUP.*'' -o -name '*.BASE.*'' -o -name '*.LOCAL.*'' -o -name '*.REMOTE.*'' \) -ls -delete"
alias cleanup_branches='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'
alias gsync='git fetch origin master:master && git fetch --all && git checkout master && cleanup_branches'



#==================================================================================================
# FZF
#==================================================================================================

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow -g "" 2> /dev/null'
export FZF_DEFAULT_OPTS='--height 50% --color=bg:15,fg:14,hl:4,bg+:7,fg+:11,hl+:4,info:4,prompt:4,pointer:4,marker:4,spinner:4,border:4,header:4'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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



#==================================================================================================
# ASDF
#==================================================================================================

. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash



#==================================================================================================
# NODE / JAVASCRIPT
#==================================================================================================

# Set up NPM_TOKEN if .npmrc exists
if [ -f ~/.npmrc ]; then
  export NPM_TOKEN=`sed -n -e '/_authToken/ s/.*\= *//p' ~/.npmrc`
fi



#==================================================================================================
# RUBY / RAILS
#==================================================================================================

alias be='noglob bundle exec'
alias migrate='bundle && bin/rails db:migrate && bin/rails db:migrate RAILS_ENV=test'
alias kill_rails_server='kill -9 $(lsof -i tcp:3000 -t)'



#==================================================================================================
# POSTGRES / REDIS / ETC
#==================================================================================================

alias fix_stuck_postgres='rm /usr/local/var/postgres/postmaster.pid; brew services restart postgresql'



#==================================================================================================
# DOCKER
#==================================================================================================

alias d='docker'
alias dc='docker-compose'



#==================================================================================================
# OSX
#==================================================================================================

alias finder='open -a Finder ./'
alias cleanup_ds="find . -type f -name '*.DS_Store' -ls -delete"
alias cleanup_open_with='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
alias add_blank_space_to_dock="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}' && killall Dock"
alias flush_dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias disable_hidden_files_in_finder='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias enable_hidden_files_in_finder='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias disable_local_timemachine='sudo tmutil disablelocal'
alias enable_local_timemachine='sudo tmutil enablelocal'
alias disable_key_press_and_hold='defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'
alias enable_key_press_and_hold='defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true'



# Start tmux home session automatically
if [ -z "$TMUX" ]; then
  tmuxinator home
fi
