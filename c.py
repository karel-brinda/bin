#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	s=`basename $0`
	echo "$s file.py"
	exit 1
fi

BASEDIR=$(dirname "$0")
cp $BASEDIR/samples/sample.py $1
