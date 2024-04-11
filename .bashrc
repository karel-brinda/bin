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
