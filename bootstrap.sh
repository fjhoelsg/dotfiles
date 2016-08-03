#!/usr/bin/env bash

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES=$(find "${DIR}" -type f -name "\.*" -not -name .DS_Store -maxdepth 1)
readonly SCRIPTS_DIR=$DIR/scripts

# Get git user name
git_name=$(git config --global --get user.name)
if [ -z "${git_name}" ]; then
  read -p 'Git name: ' git_name
fi

# Get git user email
git_email=$(git config --global --get user.email)
if [ -z "${git_email}" ]; then
  read -p 'Git email: ' git_email
fi

# Get GOPATH
if [ -z "${GOPATH}" ]; then
  read -p 'GOPATH: ' GOPATH
fi
mkdir -p "${GOPATH}"

# Copy dotfiles to home directory
for file in $DOTFILES; do
  filename=$(basename "${file}")
  cp -f "${file}" "${HOME}/${filename}"
done

# Add hushlogin
touch "${HOME}/.hushlogin"

# Substitute variables in files
sed -i.bak "s|\[GIT_USER_NAME\]|$git_name|g" "${HOME}/.gitconfig"
sed -i.bak "s|\[GIT_USER_EMAIL\]|$git_email|g" "${HOME}/.gitconfig"
rm -f "${HOME}/.gitconfig.bak"
sed -i.bak "s|\[GOPATH\]|$GOPATH|g" "${HOME}/.zshenv"
rm -f "${HOME}/.zshenv.bak"

# Run scripts
sudo "${SCRIPTS_DIR}/osx"
source "${SCRIPTS_DIR}/brew"
sudo chsh -s $(which zsh) $(whoami)
/usr/bin/env zsh "${SCRIPTS_DIR}/zprezto"
source "${SCRIPTS_DIR}/ssh"
source "${SCRIPTS_DIR}/fonts"

# Download base16 shell colors
rm -rf ~/.colors
git clone https://github.com/chriskempson/base16-shell.git ~/.colors/base16

# Reload configurations
source ~/.zshenv

# Run scripts that have dependencies
source "${SCRIPTS_DIR}/go-tools"
source "${SCRIPTS_DIR}/vim"

