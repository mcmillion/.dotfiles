#==============================================================================
# BASE ENV for ALL zsh shells, including non-interactive `ssh host cmd`, which
# reads ONLY .zshenv. Login PATH lives in .zprofile and is invisible there, so
# mirror the essentials here. Guarded prepend => no duplicates when a login
# shell sources both .zshenv and .zprofile.
#==============================================================================

_prepend_path() { case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH" ;; esac }

case "$(uname -s)" in
  Linux) _prepend_path /home/linuxbrew/.linuxbrew/bin ;;
esac
_prepend_path "$HOME/.local/bin"
_prepend_path "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
export PATH
unset -f _prepend_path

# Editor must live here (not .zprofile) so non-login shells — Claude Code's
# ctrl+g, `ssh host cmd`, git — spawn nvim, not the fallback vim.
export EDITOR='nvim'
export VISUAL='nvim'

# Machine-local secrets (tokens) live in the gitignored .zshenv.secrets so this
# file can be tracked. Stowed alongside as ~/.zshenv.secrets.
[ -r "${HOME}/.zshenv.secrets" ] && source "${HOME}/.zshenv.secrets"
