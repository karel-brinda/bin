#! /usr/bin/env bash

set -e -o pipefail

if [[ "$@" == *:* ]]; then
	newargs=$(echo "$@" | perl -pe 's/:/ /g')
	"$0" $newargs
fi

case "$#" in
	0)
		nvim || vim
		#vim
		exit 0
		;;
	1)
		file="$1"
		cmd=""
		;;
	2)
		file="$1"
		str="$2"
		if [[ $str =~ ^[0-9]+$ ]]; then
			cmd="+$str"
		else
			cmd="+/$str"
		fi
		;;
	*)
		s=`basename $0`
		echo "open file/dir in vim"
		echo "usage: $s [file/directory] [line_no/string_to_search]"
		exit 1
		;;
esac


if ! [[ -f "$file" || -d "$file" ]]; then
	echo "File '$file' does not exist" 1>&2
	exit 1
fi

if [[ ! -z "$cmd" ]]; then
	nvim "$cmd" "$file" || vim "$cmd" "$file"
	#vim "$cmd" "$file"
else
	nvim "$file" || vim "$file"
	#vim "$file"
fi

