# Functions
dsremove () {
  find "${1:-.}" -name '*.DS_Store' -type f -delete
}

# Exports
export EDITOR=vim
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export PATH=/usr/local/bin:$PATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
