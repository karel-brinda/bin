#! /usr/bin/env bash

#set -u
set -o pipefail

HOSTNAME=$(hostname)
PROGDIR="$HOME/bin"
DIRID=$(echo "${PROGDIR}__${HOSTNAME}" | tr -cd '[:alnum:]_')

##
## ALIASES
##

if [ "$(type -t _alias_stamp_)" = 'alias' ]; then
    true
else
    ## 1) SETUP ALIASES
    . "${PROGDIR}/.aliases"
    . "${PROGDIR}/git/.aliases"

    ## 2) MARK AS COMPLETED
    alias _alias_stamp_=true
fi


##
## VARIABLES
##
eval "value=\${$DIRID+set}"
if [ "$value" = "set" ]; then
    true
else
    ## 1) ENVIRONMENT SETUP

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


    ## 2) PREPREND TO PATH
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

    ## 3) MARK AS COMPLETED
    dt=$(date)
    export "$DIRID"="$dt"
fi
