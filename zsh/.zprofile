#==============================================================================
# ENVIRONMENT (login shells)
# Base PATH now lives in .zshenv (read by ALL shells, incl. non-interactive
# `ssh host cmd`). Prepends here are guarded so they no-op when .zshenv already
# ran, avoiding duplicate PATH entries.
#==============================================================================

export LANG='en_US.UTF-8'
export EDITOR='nvim'  # also in .zshenv (for non-login shells); kept here too
export LESS='-RFX'

export XDG_CONFIG_HOME="$HOME/.config"

_pp() { case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH" ;; esac }
_pp "$HOME/.local/bin"
_pp "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"

# OS-specific login environment (brew prefix, GUI app paths)
case "$(uname -s)" in
  Darwin) [ -f ~/.zprofile.darwin ] && source ~/.zprofile.darwin ;;
  Linux)  [ -f ~/.zprofile.linux ] && source ~/.zprofile.linux ;;
esac

export PATH
unset -f _pp
