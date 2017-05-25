#! /usr/bin/env bash

set -e -o pipefail

if [[ $# -ne 1 ]]; then
	s=`basename $0`
	echo "get help message"
	echo "usage: $s program"
	exit 1
fi
PROG=$1

which $PROG ||
	(
		echo "program $PROG is not installed"
		exit 1
	)

($PROG --help || $PROG -h) 2>&1 | less

