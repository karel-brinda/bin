export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias cg='cd ~/github'		

export PATH="~/anaconda3/bin:$PATH"
export PATH="~/bin:$PATH"

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# gateway in Curie
ifconfig en0 | grep 10.249.
if [ $? -eq 0 ]; then
	export http_proxy="www-cache:3128"
	export https_proxy="www-cache:3128"
	export ftp_proxy="www-cache:8021"
fi;

