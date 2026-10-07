#!/usr/bin/env bash
# Search C/C++ sources below the current directory.

set -euo pipefail

if [[ $# -eq 0 ]]; then
	printf 'usage: %s pattern...\n' "${0##*/}" >&2
	exit 1
fi

grep -rn --color=auto --exclude-dir=.git \
	--include='*.c' --include='*.cpp' --include='*.h' --include='*.hpp' \
	-- "$*" .
