#! /usr/bin/env bash

#set -u
set -o pipefail


HOSTNAME=$(hostname)
PROGDIR="$HOME/bin"
DIRID=$(echo "__${PROGDIR}__${HOSTNAME}__" | tr -cd '[:alnum:]_')
eval "DIRID_TEST=\${$DIRID+set}"
RELOAD_TEST="${RELOAD+set}" #is the RELOAD env variable set?

if [ "$RELOAD_TEST" = "set" ]; then
	>&2 echo "Force-reloading all configuration files"
fi

##
## ALIASES
##
if [ "$(type -t $DIRID)" = 'alias' ] && [ "$RELOAD_TEST" != "set" ]; then
	true
else

	## 1) SETUP ALIASES
	. "${PROGDIR}/.aliases"
	. "${PROGDIR}/git/.aliases"

	## 2) MARK AS COMPLETED
	alias $DIRID=true
fi


##
## VARIABLES
##
if [ "$DIRID_TEST" = "set" ] && [ "$RELOAD_TEST" != "set" ]; then
	true
else
	## 1) ENVIRONMENT SETUP

	# my vars
	export GITDIR="$HOME/git"
	export GITDIR2="$GITDIR/_OTHERS_"

	# colors
	export CLICOLOR=1
	export LSCOLORS=GxFxCxDxBxegedabagaced

	# vim as default editor for git
	export VISUAL=vim
	export EDITOR="$VISUAL"

	# default languages
	#export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8

	# bash behavior
	export BASH_SILENCE_DEPRECATION_WARNING=1
	export HISTIGNORE=' *'
	export HISTTIMEFORMAT='%d/%m/%y %T '


	## 2) PREPREND TO PATH
	export PATH="${PROGDIR}:${PROGDIR}/bioinformatics:${PROGDIR}/git:$PATH"

	if [ -d "$HOME/.linuxbrew/bin" ]; then
		export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH";

		export HOMEBREW_PREFIX="$HOME/.linuxbrew";
		export HOMEBREW_CELLAR="$HOME/.linuxbrew/Cellar";
		export HOMEBREW_REPOSITORY="$HOME/.linuxbrew";
		export MANPATH="$HOME/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
		export INFOPATH="$HOME/.linuxbrew/share/info:${INFOPATH:-}";

		#export C_INCLUDE_PATH="${HOMEBREW_PREFIX}/include${C_INCLUDE_PATH:+:"${C_INCLUDE_PATH}"}"
		#export CPLUS_INCLUDE_PATH="${HOMEBREW_PREFIX}/include${CPLUS_INCLUDE_PATH:+:"${CPLUS_INCLUDE_PATH}"}"
		#export LIBRARY_PATH="${HOMEBREW_PREFIX}/lib${LIBRARY_PATH:+:"${LIBRARY_PATH}"}"
		#export LD_LIBRARY_PATH="${HOMEBREW_PREFIX}/lib${LD_LIBRARY_PATH:+:"${LD_LIBRARY_PATH}"}"
	fi

	if [ -d "$HOME/miniconda/bin" ]; then
		export PATH="$HOME/miniconda/bin:$PATH"
	fi

	if [ -d "$HOME/.cargo/env" ]; then
		. "$HOME/.cargo/env"
	fi

	export PATH="${PROGDIR}/bin:$PATH"

	## 3) MARK AS COMPLETED
	dt=$(date)
	export "$DIRID"="$dt"
fi
