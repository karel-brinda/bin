#! /usr/bin/env bash

set -e -o pipefail

if [ $# -ne 1 ]; then
	s=`basename $0`
	echo "open an existing file using vim"
	echo "usage: $s file"
	exit 1
fi

(test -f $1 && vim $1) || (echo "File '$1' does not exist" 1>&2; exit 1)

