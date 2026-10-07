#!/usr/bin/env bash
# Open a file or directory in Neovim (or Vim), optionally at a line number or search string; file:line also works.

set -euo pipefail

if [[ "$*" == *:* ]]; then
	newargs=$(printf '%s ' "$@" | tr ':' ' ')
	# shellcheck disable=SC2086
	exec "$0" $newargs
fi

if command -v nvim >/dev/null 2>&1; then
	editor=nvim
else
	editor=vim
fi

case "$#" in
	0)
		exec "$editor"
		;;
	1)
		file="$1"
		cmd=""
		;;
	2)
		file="$1"
		str="$2"
		if [[ "$str" =~ ^[0-9]+$ ]]; then
			cmd="+$str"
		else
			cmd="+/$str"
		fi
		;;
	*)
		printf 'usage: %s [file/directory] [line_no/string_to_search]\n' "${0##*/}" >&2
		exit 1
		;;
esac

if ! [[ -f "$file" || -d "$file" ]]; then
	printf "File '%s' does not exist\\n" "$file" >&2
	exit 1
fi

if [[ -n "$cmd" ]]; then
	exec "$editor" "$cmd" "$file"
else
	exec "$editor" "$file"
fi
