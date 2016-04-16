#! /usr/bin/env bash

#re='(.*)\.svg'
#
#find . -name "*.svg" | while read svg; do
#
#	if [[ $svg =~ $re ]] ; then
#		pdf=${BASH_REMATCH[1]}.pdf
#		echo "$svg => $pdf"
#		svg42pdf -m 'inkscape' $svg $pdf &
#		sleep 0.4
#	fi
#
#done;

find . -name '*.svg' | parallel -P 10 svg42pdf -m 'inkscape' {} {.}.pdf

