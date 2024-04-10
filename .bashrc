#! /usr/bin/env bash

set -uo pipefail


##
## STOP IF ALREADY LOADED
##
if [ -n "${LOADED_BASHRC_BIN+x}" ]; then
	exit 0
else
	export LOADED_BASHRC_BIN=$(date)
fi

##
## ENVIRONMENT SETUP
##

# colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# bash behavior
export BASH_SILENCE_DEPRECATION_WARNING=1
export HISTIGNORE=' *'
export HISTTIMEFORMAT='%d/%m/%y %T '


##
## ALIASES
##
readonly BINDIR="$HOME/bin"
. "${BINDIR}/.aliases"
. "${BINDIR}/git/.aliases"


##
## PREPREND TO PATH
##
export PATH="${BINDIR}:${BINDIR}/bioinformatics:${BINDIR}/git:${BINDIR}/grep:$PATH"

if [ -d "$HOME/.linuxbrew/bin" ]; then
	export PATH="$HOME/.linuxbrew/bin:$PATH"
fi

if [ -d "$HOME/miniconda/bin" ]; then
	export PATH="$HOME/miniconda/bin:$PATH"
fi

