#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
	printf 'usage: %s file.R\n' "${0##*/}" >&2
	exit 1
fi

BASEDIR=$(dirname "$0")
cp "$BASEDIR/samples/sample.R" "$1"
