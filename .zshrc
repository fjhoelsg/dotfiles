#!/usr/bin/env zsh

# Start tmux session
if [[ -z "${TMUX}" ]] && (($+commands[tmux])); then
  exec tmux -u
fi

# Create zsh cache directory
export ZSH_CACHE_DIR="${HOME}/.cache/zsh"
if [[ ! -d "${ZSH_CACHE_DIR}" ]]; then
  mkdir -p "${ZSH_CACHE_DIR}"
fi

# Fallback to using keychain as the ssh agent
if [[ -z "${SSH_AUTH_SOCK}" ]] && command -v keychain > /dev/null 2>&1; then
  keychain --nogui --quick --quiet "${HOME}/.ssh/id_ed25519"
  source "${HOME}/.keychain/$(hostname)-sh"
fi

# General
unsetopt correct_all
setopt correct
setopt combining_chars
setopt interactive_comments
setopt rc_quotes
setopt long_list_jobs
setopt auto_resume
setopt notify
setopt bg_nice
setopt hup
setopt check_jobs
setopt rcexpandparam
setopt nocheckjobs
setopt numericglobsort
setopt nobeep
setopt autocd
zmodload zsh/terminfo

# History
export HISTFILE="${ZSH_CACHE_DIR}/history"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
setopt append_history
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
# Up and down arrow search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Completions
setopt complete_in_word
setopt always_to_end
setopt path_dirs
setopt auto_menu
setopt auto_list
setopt auto_param_slash
setopt extended_glob
setopt no_case_glob
unsetopt menu_complete
unsetopt flow_control
zstyle ':completion:::::' completer _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*(^1)' insert-sections true
zstyle ':completion:approximate*:*' prefix-needed false
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
WORDCHARS=${WORDCHARS//\/[&.;]}

# Vim Keys
bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char # Fix backspace
bindkey -M vicmd "u" undo
bindkey -M vicmd "^r" redo
bindkey -M vicmd "/" history-incremental-pattern-search-backward
bindkey -M vicmd "?" history-incremental-pattern-search-forward
bindkey -M viins "^p" history-incremental-pattern-search-backward
bindkey -M viins "^n" history-incremental-pattern-search-forward

# External Editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^e" edit-command-line
bindkey -M viins "^e" edit-command-line

# Autoload
autoload -Uz compinit colors zcalc
compinit -d "${ZSH_CACHE_DIR}/zcompdump-${ZSH_VERSION}"
colors

# Prompt
autoload -Uz promptinit
promptinit
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " [%b]"

# Kubectl
# Lazy load kubectl completions
# See https://github.com/kubernetes/kubernetes/issues/59078
if command -v kubectl > /dev/null 2>&1; then
  function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
      source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
  }
fi

# Prompt
precmd() {
    vcs_info
}

zle_highlight=(default:fg=231)

function zle-line-init zle-keymap-select {
  PROMPT_SYMBOL="${${KEYMAP/vicmd/❮}/(main|viins)/❯}"
  GIT_COLOR=47
  git diff-index --quiet HEAD 2> /dev/null
  if [[ $? -eq 1 ]]; then
    GIT_COLOR=160
  fi
  PROMPT="%F{247}%2~%f%F{${GIT_COLOR:-47}}${vcs_info_msg_0_}%f %F{39}${PROMPT_SYMBOL:-❯}%f "
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
