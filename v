#! /usr/bin/env bash

set -e -o pipefail

if [[ $# -eq 0 ]]; then
	nvim || vim
	exit 0
fi

if [[ $# -eq 1 ]]; then
	if [[ -f "$1" || -d "$1" ]]; then
		nvim "$1" || vim "$1"
		exit 0
	else
		echo "File '$1' does not exist" 1>&2
		exit 1
	fi
fi

s=`basename $0`
echo "open an existing file or a directory using neovim/vim"
echo "usage: $s file"
exit 1

