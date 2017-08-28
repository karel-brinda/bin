#! /usr/bin/env bash

set -e
set -o pipefail
set -u
#set -f

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(dirname $0)
readonly -a ARGS=("$@")
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
