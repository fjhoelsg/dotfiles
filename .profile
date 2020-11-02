#!/bin/sh

# Environement
export TERM="${TERM:-screen-256color}"
export EDITOR='nvim'
export VISUAL='nvim'
export GIT_EDITOR='nvim'
export PAGER='less'
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
export PATH="${HOME}/.local/bin:${PATH}"

# Less
export LESSHISTFILE='-'
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# Aliases
unalias df &> /dev/null
alias df='df -h'
unalias free &> /dev/null
alias free='free -m'
unalias egrep &> /dev/null
alias egrep='egrep --color=auto'
unalias fgrep &> /dev/null
alias fgrep='fgrep --color=auto'
unalias grep &> /dev/null
alias grep='grep --color=auto'
unalias ic &> /dev/null
alias ic='ibmcloud'
unalias ln &> /dev/null
alias ln='ln -v'
unalias ls &> /dev/null
alias ls='ls -F --group-directories-first --color=always --human-readable'
unalias ll &> /dev/null
alias ll='ls -al'
unalias pip &> /dev/null
alias pip=pip3
unalias python &> /dev/null
alias python=python3
unalias top &> /dev/null
alias top=htop
unalias vim &> /dev/null
alias vim=nvim
unalias vi &> /dev/null
alias vi=nvim

# Homebrew
if command -v brew > /dev/null 2>&1; then
  export PATH="$(brew --prefix)/bin:${PATH}"
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
  export PATH="/usr/local/opt/grep/libexec/gnubin:${PATH}"
fi

# Go
if command -v go > /dev/null 2>&1; then
  export GOPATH="${HOME}/.local/share/go"
  if [ ! -d "${GOPATH}" ]; then
    mkdir -p "${GOPATH}"
  fi
  export PATH="${GOPATH}/bin:${PATH}"
fi

# NPM
if command -v npm > /dev/null 2>&1; then
  export NPM_CONFIG_PREFIX="${HOME}/.local/share/npm"
  if [ ! -d "${NPM_CONFIG_PREFIX}" ]; then
    mkdir -p "${NPM_CONFIG_PREFIX}"
  fi
  export PATH="${NPM_CONFIG_PREFIX}/bin:${PATH}"
fi

# Dotnet
if command -v dotnet > /dev/null 2>&1; then
  export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true
  export DOTNET_CLI_TELEMETRY_OPTOUT=true
fi

# CUDA
if command -v nvcc > /dev/null 2>&1; then
  export CUDA_PATH=$(which nvcc | sed -e 's#/bin/nvcc$##')
elif [ -d "/opt/cuda" ]; then
  export CUDA_PATH='/opt/cuda'
  export PATH="${CUDA_PATH}/bin:${PATH}"
fi
