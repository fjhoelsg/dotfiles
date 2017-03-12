# Load colorscheme
source "$HOME/.colors/base16/scripts/base16-eighties.sh"

# Load Zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Load aliases
if [[ -f "${HOME}/.aliases" ]]; then
  source "${HOME}/.aliases"
fi

# Source env once more to override .zprofile
source "$HOME/.zshenv"

if [[ $- == *i* && -z "$TMUX" ]] && which tmux >/dev/null 2>&1; then
  exec tmux
fi
