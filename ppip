#! /usr/bin/env bash

set -o pipefail
set -e

readonly PROGDIR=$(dirname $0)
readonly ARGS="$@"

pipath=$(which pip)

if [[ "$pipath" != *"miniconda"* ]] &&  [[ -f "$HOME/miniconda/bin/pip" ]]; then
	pip="$HOME/miniconda/bin/pip"
else
	pip="$pipath"
fi

echo "pip: $pip"
"$pip" $ARGS
