export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if [ -f ~/bin/bash-sensible/sensible.bash ]; then
	echo "" > /dev/null
	#source ~/bin/bash-sensible/sensible.bash
fi

alias cd-='cd -'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias cg='cd ~/github'
alias cgm='cd ~/github/my'

alias ga='git add'
alias gb='git branch'
alias gs='git status'
alias gt='git commit'
alias gf='git diff --cached'
alias gpull='git pull --rebase'
alias gpush='git push'
alias g{='git stash -u'
alias g}='git stash pop'

alias sm='snakemake -p --cores'


export PATH="$PATH:~/anaconda3/bin"
export PATH="~/bin:$PATH"

# vim as default editor for git
export VISUAL=vim
export EDITOR="$VISUAL"

# default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# open in Linux using gnome-open

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
