#! /usr/bin/env bash -u -e -o pipefail

rm -fr numerical.recipes

d=numerical.recipes/CS395T/lectures2010/

wget -m http://numerical.recipes/CS395T/lectures2010/
rename 's/2010_/2010_0/g' $d/2010_?_*.pdf
rename 's/2010_//g' n$d/?_*.pdf
rename 's/_/-/g' $d/*.pdf

for x in $d/*.pdf; do
	echo $x
	y=`echo ${x##*/}`
	echo $y
	echo
	pdfjam-slides3up --paper letter --batch \
	--suffix '1x3' \
	--pagecommand "{\thispagestyle{myheadings}\markright{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$y}}" $x
	#--pagecommand "{\thispagestyle{myheadings}\markright{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$y}}" $x
done;

pdfunite *1x3*.pdf comp_stat_bio.pdf
