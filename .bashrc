#!/usr/bin/env bash
# Shared Bash setup for every machine: aliases, PATH, and environment.
#
# Wire it in once per machine (or run i.bashrc, which adds these lines if missing):
#   ~/.bashrc:        . ~/bin/.bashrc
#   ~/.bash_profile:  [[ -f ~/.bashrc ]] && . ~/.bashrc
#
# Machine-specific additions go after that line in ~/.bashrc; use path.prepend and
# path.append there so that repeated sourcing never duplicates PATH. Sourcing this
# file twice is safe: aliases and the environment are set up once per host, and
# RELOAD=1 forces a re-run.

#set -u
set -o pipefail

# Prepend/append a directory to PATH if it exists and is not there yet.
path.prepend() {
	local d="$1"
	[ -d "$d" ] || return 0
	case ":$PATH:" in
		*":$d:"*) ;;
		*) export PATH="$d:$PATH" ;;
	esac
}

path.append() {
	local d="$1"
	[ -d "$d" ] || return 0
	case ":$PATH:" in
		*":$d:"*) ;;
		*) export PATH="$PATH:$d" ;;
	esac
}

HOSTNAME=$(hostname)
PROGDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

	# Pick the first installed UTF-8 locale (POSIX as a fallback); checked against
	# locale -a because an unknown LC_ALL does not make locale fail on macOS.
	# (if ABC...abc... not ideal, switch to the US style)
	locales=$(locale -a 2>/dev/null)
	for loc in C.UTF-8 C.utf8 en_US.UTF-8 en_US.utf8 POSIX; do
		if grep -qxF "$loc" <<< "$locales"; then
			export LC_ALL="$loc"
			break
		fi
	done
	unset loc locales

	# bash behavior
	export BASH_SILENCE_DEPRECATION_WARNING=1
	export HISTIGNORE=' *'
	export HISTTIMEFORMAT='%d/%m/%y %T '


	## 2) PATH: tools first, then this repository in front of everything

	path.prepend "$HOME/.local/bin"

	if [ -f "$HOME/.cargo/env" ]; then
		. "$HOME/.cargo/env"
	fi

	# Homebrew: Apple Silicon, Intel macOS, or Linuxbrew (brew shellenv also sets
	# HOMEBREW_*, MANPATH, and INFOPATH; HOMEBREW_PREFIX marks it as done).
	if [ -z "${HOMEBREW_PREFIX:-}" ]; then
		for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew "$HOME/.linuxbrew/bin/brew"; do
			if [ -x "$brew_bin" ]; then
				eval "$("$brew_bin" shellenv)"
				break
			fi
		done
		unset brew_bin
	fi

	path.prepend "$HOME/miniconda/bin"

	path.prepend "${PROGDIR}/git"
	path.prepend "${PROGDIR}"
	path.prepend "${PROGDIR}/bin"

	## 3) MARK AS COMPLETED
	dt=$(date)
	export "$DIRID"="$dt"
fi
