#! /usr/bin/env bash

set -e -o pipefail

if [[ $# -eq 0 ]]; then
	pwd
	exit 0
fi

if [[ $# -eq 1 ]]; then
	realpath "$1"
	exit 0
fi

s=`basename $0`
echo "print pwd/absolute path"
echo "usage: $s [file/directory]"
exit 1

