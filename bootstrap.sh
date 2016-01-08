#!/usr/bin/env bash

# Paths
FILENAME=$(basename "${BASH_SOURCE}")
ROOT_DIR=$(dirname "${BASH_SOURCE}")
HOOKS_PATH=$ROOT_DIR/hooks
FILES=$(find "${ROOT_DIR}" -type f -not -path '*/\.*' -not -name "${FILENAME}" \
  -not -name README.md -maxdepth 1)

# Get git user name
GIT_USER_NAME=$(git config --global --get user.name)
if [ -z "${GIT_USER_NAME}" ]; then
  read -p 'Git name: ' GIT_USER_NAME
fi

# Get git user email
GIT_USER_EMAIL=$(git config --global --get user.email)
if [ -z "${GIT_USER_EMAIL}" ]; then
  read -p 'Git email: ' GIT_USER_EMAIL
fi

# Get GOPATH
if [ -z "${GOPATH}" ]; then
  read -p 'GOPATH: ' GOPATH 
fi
GOPATH=$(echo "${GOPATH}" | sed -e "s@${HOME}@~@g")
GOPATH=$(echo "${GOPATH}" | sed -e "s/ /\\\ /g")
sh -c "mkdir -p ${GOPATH}"

# Pre scripts
source "${HOOKS_PATH}/before"

# Copy dotfiles
for file in $FILES
do
  cp "${file}" ~/.$(basename "${file}")
done

# Substitute variables in files
sed -i.bak "s|\[GIT_USER_NAME\]|$GIT_USER_NAME|g" ~/.gitconfig
sed -i.bak "s|\[GIT_USER_EMAIL\]|$GIT_USER_EMAIL|g" ~/.gitconfig
sed -i.bak "s|\[GOPATH\]|$GOPATH|g" ~/.zshenv

# Reload configurations
source ~/.zshenv

# Post scripts
source "${HOOKS_PATH}/after"
