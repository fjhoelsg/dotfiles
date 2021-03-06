#!/bin/sh

set -e

cp_dots() {
  target_path="${2}/$(basename "${1}")"
  rm -rf "${target_path}"
  cp -R -f "${1}" "${target_path}"
  chown -R "${USER}:$(id -ng)" "${target_path}"
}

clone_github_repo() {
  if [ ! -d "${HOME}/Development/github.com/$1" ]; then
    mkdir -p "${HOME}/Development/github.com/$(dirname $1)"
    git clone "https://github.com/${1}.git" "${HOME}/Development/github.com/${1}"
    pushd "${HOME}/Development/github.com/${1}" > /dev/null
    git remote set-url origin "git@github.com:${1}.git"
    popd > /dev/null
  fi
}

# Check not running as root
if [ "${UID}" = "0" ]; then
  echo "Do not run this script as root" >&2
  exit 1
fi

# Copy dotfiles
cp_dots .bash_profile "${HOME}"
cp_dots .config "${HOME}"
cp_dots .gitattributes "${HOME}"
cp_dots .gitconfig "${HOME}"
cp_dots .gitignore "${HOME}"
cp_dots .hushlogin "${HOME}"
cp_dots .ideavimrc "${HOME}"
cp_dots .profile "${HOME}"
cp_dots .ssh "${HOME}"
cp_dots .tmux.conf "${HOME}"
cp_dots .vimrc "${HOME}"
cp_dots .zshenv "${HOME}"
cp_dots .zshrc "${HOME}"

# Run OS-specific scripts
readonly os="$(uname)"
if [ "${os}" = "Linux" ] && [ -f /etc/debian_version ]; then
  sh "scripts/linux.sh"
elif [ "${os}" = "Darwin" ]; then
  sh "scripts/macos.sh"
else
  echo "No script for ${os}"
fi

# Update path
if command -v brew > /dev/null 2>&1; then
  export PATH="$(brew --prefix)/bin:${PATH}"
fi

# SSH
if [ ! -f "${HOME}/.ssh/id_ed25519" ]; then
  ssh-keygen -t ed25519 -f "${HOME}/.ssh/id_ed25519" -C ""
fi

# Python
pip3 install virtualenv

# Change shell to zsh
chsh -s "$(which zsh)"

# Install nvim plugins
nvim +VimEnter +PlugInstall +qall

# Clone public repositories
clone_github_repo fjhoelsg/dotfiles
