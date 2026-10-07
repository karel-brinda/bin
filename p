#!/usr/bin/env bash
# Print the absolute path of a file or directory (default: the current directory) and copy it to the clipboard.

set -euo pipefail

if [[ $# -gt 1 ]]; then
	printf 'usage: %s [file/directory]\n' "${0##*/}" >&2
	exit 1
fi

# realpath is missing on macOS before 13.
abspath() {
	if command -v realpath >/dev/null 2>&1; then
		realpath -- "$1"
	elif [[ -d "$1" ]]; then
		(cd -- "$1" && pwd -P)
	else
		printf '%s/%s\n' "$(cd -- "$(dirname -- "$1")" && pwd -P)" "$(basename -- "$1")"
	fi
}

if [[ $# -eq 0 ]]; then
	res="$(pwd)"
else
	res="$(abspath "$1")"
fi

printf '"%s"' "$res" | clip 2>/dev/null || true
printf '%s\n' "$res"
