#! /usr/bin/env bash

_BIN_DIR="$HOME/github/my/bin"
_BIN_DIR2="$HOME/github/my/projects/bin"

set -o pipefail

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export BASH_SILENCE_DEPRECATION_WARNING=1

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# histignore
export HISTIGNORE=' *'


##
## PREPREND
##
export PATH="${_BIN_DIR}:${_BIN_DIR}/bioinformatics:${_BIN_DIR}/dictionaries:${_BIN_DIR}/git:${_BIN_DIR}/grep:$HOME/bin2:$PATH"
export PATH="$HOME/miniconda/bin:$HOME/.linuxbrew/bin:$PATH:${_BIN_DIR2}"

if [ -f "${_BIN_DIR}/.aliases" ]; then
	. "${_BIN_DIR}/.aliases"
	. "${_BIN_DIR}/git/.aliases"
	. "${_BIN_DIR}/bioinformatics/.aliases"
fi

if [ -f "${_BIN_DIR2}/.aliases" ]; then
	. "${_BIN_DIR2}/.aliases"
fi

if [[ `uname` == 'Linux' ]]; then
	. "${_BIN_DIR}/.bashrc.linux"
else
	. "${_BIN_DIR}/.bashrc.osx"
fi;


##
## APPEND
##
for d in \
	"$HOME/go/bin" \
	; do
	if [ -d "$d" ]; then
		export PATH="$PATH:$d"
	fi
done

if [ -f $HOME/.cargo/env ]; then
	source $HOME/.cargo/env
fi
