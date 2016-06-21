# Path
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export GOPATH=[GOPATH]
if [ -d "${GOPATH}" ]; then
  export PATH=$PATH:$GOPATH/bin
fi

# General Exports
export EDITOR=vim
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
