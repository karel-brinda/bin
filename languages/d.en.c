#! /usr/bin/env bash

set -e -o pipefail


if [ $# -eq 0 ]; then
	s=`basename $0`
	echo "usage: $s word"
	exit 1
fi

if [ $# -eq 1 ]; then
	open "http://dictionary.cambridge.org/dictionary/english/$1"
else
	q=`echo $* | sed 's/ /\+/g'`
	open "http://dictionary.cambridge.org/spellcheck/english/?q=$q"
fi	

