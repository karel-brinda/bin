#! /usr/bin/env bash

if [ $# -ne 1 ]; then
	s=`basename $0`
	echo "usage: $s file.sh"
	exit 1
fi

BASEDIR=$(dirname "$0")
cp $BASEDIR/samples/sample.sh $1
