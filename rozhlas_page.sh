#! /usr/bin/env bash -u -f -e -o pipefail

if [ $# -ne 1 ]; then
	s=`basename $0`
	echo "usage: $s param"
	exit 1
fi

url=$1
urls=$(curl $url | perl -pe 's/"/\n/g' | grep prehravac | grep "prehravac.rozhlas.cz/audio" | sed 's/\n/ /g')

for x in $urls; do
	echo $x
	rozhlas_pl.sh $x &
done
wait
echo "done"

