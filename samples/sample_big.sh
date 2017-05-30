#! /usr/bin/env bash

set -u
set -f
set -e
set -o pipefail

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"
readonly NARGS="$#"

usage() {
	cat <<- EOF
	usage: $PROGNAME options
	EOF
}

main() {
	#if [ $NARGS -ne 1 ]; then
	#	usage
	#	exit 1
	#fi
}

main
