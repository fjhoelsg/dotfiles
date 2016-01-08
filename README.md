# dotfiles

Compilation of my favorite dotfiles from various sources throughout GitHub.

## Installation

Clone the repo and run the bootstrap script `./bootstrap.sh` or pick and choose
the parts that you like.

## Components

- OS X settings
- zsh with [Prezto](https://github.com/sorin-ionescu/prezto)
- brew with core utilities
- vim with [vim-plug](https://github.com/junegunn/vim-plug) plugins
- tmux
- [Go](https://golang.org/)

All of the scripts are located inside `hooks/scripts` and they can be run
independent from one another. The dotfiles are located in the project root and
should work by simply copying the files to your home directory and prepending
them with a dot.

## Important Notes

- Running the bootstrap script will override your dotfiles
- The OS X settigns script might require a restart for changes to be applied
