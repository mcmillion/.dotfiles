#==============================================================================
# ENVIRONMENT
#==============================================================================

export LANG='en_US.UTF-8'
export EDITOR='nvim'
export LESS='-RFX'

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$HOME/.local/bin:$PATH"

# OS-specific login environment (brew prefix, GUI app paths)
case "$(uname -s)" in
  Darwin) [ -f ~/.zprofile.darwin ] && source ~/.zprofile.darwin ;;
  Linux)  [ -f ~/.zprofile.linux ] && source ~/.zprofile.linux ;;
esac
