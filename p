#! /usr/bin/env bash

set -e -o pipefail

case "$#" in
	0)
		res=$(pwd)
		;;
	1)
		res=$(realpath "$1")
		;;
	*)
		s=`basename $0`
		echo "print pwd/absolute path"
		echo "usage: $s [file/directory]"
		exit 1
		;;
esac


echo "$res" | pbcopy || true
echo "$res"
