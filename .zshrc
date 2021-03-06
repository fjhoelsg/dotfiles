#!/usr/bin/env zsh

## Start tmux session
if [[ -z "${TMUX}" ]] &&
  (($+commands[tmux])) &&
  [[ "${TERMINAL_EMULATOR}" != "JetBrains-JediTerm" ]]; then
  exec tmux
fi

# General
setopt AUTOCD
unsetopt BEEP
setopt BG_NICE
setopt CHECK_JOBS
setopt CHECK_RUNNING_JOBS
setopt COMBINING_CHARS
unsetopt CORRECT_ALL
setopt CORRECT
setopt HUP
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt NOTIFY
setopt NUMERIC_GLOB_SORT
setopt RC_EXPAND_PARAM
zmodload zsh/terminfo

# History
export HISTFILE="${HOME}/.zhistory"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
# Up and down arrow search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]" up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Completions
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
unsetopt CASE_GLOB
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
unsetopt FLOW_CONTROL
setopt PATH_DIRS
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*(^1)' insert-sections true
zstyle ':completion:approximate*:*' prefix-needed false
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' menu select=2
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
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
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

PROMPT=''
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
