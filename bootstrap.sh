#!/usr/bin/env bash

# Paths
FILENAME=$(basename "${BASH_SOURCE}")
ROOT_DIR=$(dirname "${BASH_SOURCE}")
HOOKS_PATH=$ROOT_DIR/hooks
FILES=$(find "${ROOT_DIR}" -type f -not -path '*/\.*' -not -name "${FILENAME}" \
  -not -name README.md -maxdepth 1)

# Pre scripts
source "${HOOKS_PATH}/before"

# Copy dotfiles
for file in $FILES
do
  cp "${file}" ~/.$(basename "${file}")
done

# Post scripts
source "${HOOKS_PATH}/after"
