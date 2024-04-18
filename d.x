#! /usr/bin/env bash

if [ $# -ne 2 ]; then
	s=`basename $0`
	echo "usage: $s file1.{gz,xz,bz2} file2.{gz,xz,bz2}"
	exit 1
fi

xcat () {
	x="$1"
	(
	zcat "$x" 2> /dev/null \
		|| bzcat "$x" 2> /dev/null \
		|| tar.cat "$x" 2> /dev/null \
		|| xzcat "$x" 2> /dev/null \
		|| cat "$x"
	) 2>/dev/null
}

diff --color=always <(xcat "$1") <(xcat "$2") | less -R

