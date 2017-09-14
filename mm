#! /usr/bin/env bash

# display n-th line

if [[ $# -ne 1 ]]; then
	s=`basename $0`
	echo "display n-th line"
	echo "usage: $s n"
	exit 1
fi

offset=$(echo "+$1" | perl -pe 's/^\+([\+\-]{1})/\1/g')
tail -n $offset | head -n 1
