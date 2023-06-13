#! /usr/bin/env bash

set -e
set -o pipefail
set -u
#set -f

set -x
rename 's/ /_/g' "$@"
