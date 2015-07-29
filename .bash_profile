export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias l='ls -Galh'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(docker-machine env dev)"

gcs() {
	  git clone "ssh://git@github.com/$1"
  }
alias gcs='gcs'
alias gpr='git pull --rebase'
alias gb='git branch'
alias cg='cd ~/github'
alias ds="dropbox status"
alias sm="snakemake"
