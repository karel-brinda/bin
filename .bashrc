export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#if [ -f ~/bin/bash-sensible/sensible.bash ]; then
#	echo "" > /dev/null
#	source ~/bin/bash-sensible/sensible.bash
#fi

source ~/bin/.aliases

ANACONDA_ROOT=~/anaconda
export PATH="$PATH:$ANACONDA_ROOT/bin"
export MANPATH="$ANACONDA_ROOT/share/man:$MANPATH"

export PATH="~/bin:~/bin2:~/bin/tabulator/bin:$PATH"

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# gateway in Curie
(ifconfig en0 | grep 10.249.) >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
	export http_proxy="www-cache:3128"
	export https_proxy="www-cache:3128"
	export ftp_proxy="www-cache:8021"
fi;

if [[ `uname` == 'Linux' ]]; then
	source ~/bin/.bashrc.linux
else
	source ~/bin/.bashrc.osx
fi;

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi
