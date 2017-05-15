#! /usr/bin/env bash

set -u # requied variable initialization
set -f # turn off wildcard expansion
set -e # exit immediately if a command exits with a non-zero status
set -o pipefail # fail if any command in a pipeline fails

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"

usage() {
    cat <<- EOF
    usage: $PROGNAME options
    EOF
}

main() {
#if [ $# -ne 1 ]; then
#	usage()
#	exit 1
#fi
}

main
