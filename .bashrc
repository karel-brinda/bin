#! /usr/bin/env bash

readonly PROGDIR=~/bin

set -o pipefail
#set -o vi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

for ANACONDA_ROOT in ~/miniconda ; do
	export PATH="$PATH:$ANACONDA_ROOT/bin"
	#export MANPATH="$ANACONDA_ROOT/share/man:$MANPATH"
done;


for d in ${PROGDIR} ${PROGDIR}/tabulator/bin ${PROGDIR}/dictionaries ${PROGDIR}/git ; do
	if [ -d $d ]; then
		export PATH="$d:$PATH"
		if [ $d != $PROGDIR ] && [ -f $d/.bashrc ]; then
			source "$d/.bashrc"
		fi

		if [ -f $d/.aliases ]; then
			source "$d/.aliases"
		fi
	fi
done


export PATH="~/bin2:~/.rvm/bin/:~/.node_modules_global/bin:~/github/my/projects/bin:$PATH"

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source ${PROGDIR}/.aliases


if [[ `uname` == 'Linux' ]]; then
	source ${PROGDIR}/.bashrc.linux
else
	source ${PROGDIR}/.bashrc.osx
fi;

export HISTIGNORE=' *'

