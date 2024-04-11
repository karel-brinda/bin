#! /usr/bin/env bash

set -uo pipefail

HOSTNAME=$(hostname)
PROGDIR="$HOME/bin"
DIRID=$(echo "${PROGDIR}__${HOSTNAME}" | tr -cd '[:alnum:]_')

##
## WAS THIS ALREADY LOADED?
##
eval "value=\${$DIRID+set}"
if [ "$value" = "set" ]; then
    true
else
    dt=$(date)
    export "$DIRID"="$dt"

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
    . "${PROGDIR}/.aliases"
    . "${PROGDIR}/git/.aliases"


    ##
    ## PREPREND TO PATH
    ##
    export PATH="${PROGDIR}:${PROGDIR}/bioinformatics:${PROGDIR}/git:$PATH"

    if [ -d "$HOME/.linuxbrew/bin" ]; then
        export PATH="$HOME/.linuxbrew/bin:$PATH"
    fi

    if [ -d "$HOME/miniconda/bin" ]; then
        export PATH="$HOME/miniconda/bin:$PATH"
    fi

    if [ -d "$HOME/binbin" ]; then
        export PATH="$HOME/miniconda/bin:$PATH"
    fi

    export PATH="${PROGDIR}/bin:$PATH"
fi
