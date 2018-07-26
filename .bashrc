#! /usr/bin/env bash

_BIN_DIR="$HOME/github/my/bin"

set -o pipefail
#set -o vi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if [[ -s ~/miniconda/etc/profile.d/conda.sh ]]; then
	. ~/miniconda/etc/profile.d/conda.sh
fi

for ANACONDA_ROOT in ~/miniconda ; do
	export PATH="$PATH:$ANACONDA_ROOT/bin"
	#export MANPATH="$ANACONDA_ROOT/share/man:$MANPATH"
done;


# prepend
for d in \
	"${_BIN_DIR}" \
	"${_BIN_DIR}/bioinformatics" \
	"${_BIN_DIR}/tabulator/bin" \
	"${_BIN_DIR}/dictionaries" \
	"${_BIN_DIR}/git" \
	"${_BIN_DIR}/grep" \
	"${_BIN_DIR}/programs/lein" \
	"$HOME/bin2" \
	"$HOME/.rvm/bin/" \
	"$HOME/.node_modules_global/bin" \
	"$HOME/github/my/projects/bin" \
	; do
	if [ -d $d ]; then
		export PATH="$d:$PATH"
		if [ $d != $_BIN_DIR ] && [ -f $d/.bashrc ]; then
			. "$d/.bashrc"
		fi

		if [ -f $d/.aliases ]; then
			. "$d/.aliases"
		fi
	fi
done


# append
for d in \
	"$HOME/.linuxbrew/bin" \
	"$HOME/go/bin" \
	; do
	if [ -d "$d" ]; then
		export PATH="$PATH:$d"
	fi
done

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source "${_BIN_DIR}/.aliases"


if [[ `uname` == 'Linux' ]]; then
	. "${_BIN_DIR}/.bashrc.linux"
else
	. "${_BIN_DIR}/.bashrc.osx"
fi;

export HISTIGNORE=' *'

