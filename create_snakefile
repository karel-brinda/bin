#! /usr/bin/env bash

BASEDIR=$(dirname "$0")
SAMPLE="$BASEDIR/samples/sample.snakefile"

if [ $# -eq 0 ]; then
	cp $SAMPLE Snakefile
	exit 0
fi

if [ $# -eq 1 ]; then
	cp $SAMPLE "$1"
	exit 0
fi

s=`basename $0`
echo "usage: $s [Snakefile]"
exit 1
