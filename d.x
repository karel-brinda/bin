#!/usr/bin/env bash
# Diff two files after decompressing them (gz, bz2, xz, tar archives).

set -euo pipefail

if [[ $# -ne 2 ]]; then
	printf 'usage: %s file1.{gz,xz,bz2} file2.{gz,xz,bz2}\n' "${0##*/}" >&2
	exit 1
fi

xcat() {
	case "$1" in
		*.tar|*.tgz|*.tbz2|*.txz|*.tar.*) tar.cat "$1" 2>/dev/null ;;
		*.gz|*.Z) gzip -dc "$1" ;;
		*.bz2) bzip2 -dc "$1" ;;
		*.xz|*.lzma) xz -dc "$1" ;;
		*) cat "$1" ;;
	esac
}

# --color needs diffutils 3.4+ (missing on CentOS 7 and macOS before 13).
color=""
if diff --color=auto /dev/null /dev/null >/dev/null 2>&1; then
	color="--color=always"
fi

# shellcheck disable=SC2086
diff $color <(xcat "$1") <(xcat "$2") | less -R
