#!/usr/bin/env bash

# Paths
root_dir=$(dirname "${BASH_SOURCE}")
dotfiles=$(find "${root_dir}" -type f -not -path '*/\.*' \
  -not -name "$(basename "${BASH_SOURCE}")" -not -name README.md -maxdepth 1)

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

# Execute scripts that can be run before copying the dotfiles
source "$root_dir/hooks/before"

# Copy dotfiles
for file in $dotfiles
do
  cp "${file}" ~/.$(basename "${file}")
done

# Add hushlogin
touch ~/.hushlogin

# Substitute variables in files
sed -i.bak "s|\[GIT_USER_NAME\]|$git_name|g" ~/.gitconfig
sed -i.bak "s|\[GIT_USER_EMAIL\]|$git_email|g" ~/.gitconfig
rm -f ~/.gitconfig.bak
sed -i.bak "s|\[GOPATH\]|$GOPATH|g" ~/.zshenv
rm -f ~/.zshenv.bak

# Reload configurations
source ~/.zshenv

# Execute scripts that MUST be run after the dotfiles have been copied
source "$root_dir/hooks/after"
