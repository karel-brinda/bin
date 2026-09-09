#!/usr/bin/env bash

set -euo pipefail

if [[ $# -gt 1 ]]; then
	printf 'usage: %s [Snakefile]\n' "${0##*/}" >&2
	exit 1
fi

BASEDIR=$(dirname "$0")
if [[ $# -eq 0 ]]; then
	DESTINATION=Snakefile
else
	DESTINATION="$1"
fi

cp "$BASEDIR/samples/sample.snakefile" "$DESTINATION"
