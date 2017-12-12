#! /usr/bin/env bash

set -e -o pipefail

q=$(echo "$@" | perl -pe 's/ /+/g')
open "https://explainshell.com/explain?cmd=$q"

