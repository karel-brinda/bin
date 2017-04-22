#! /usr/bin/env bash -u -f -e -o pipefail

if [ $# -ne 1 ]; then
	s=`basename $0`
	echo "usage: $s param"
	exit 1
fi

url=$1

title=$(curl $url | grep "title=" | grep "<p" | head -n 1 | perl -pe 's/"/\n/g' | head -n 2 | tail -n -1 | perl -pe 's/\//_/g' | perl -pe 's/\.$//g' | perl -pe 's/ /_/g')

rid=$(echo "$url" | perl -pe 's/.*\/(\d+).*/$1/g')

echo $title
echo $rid
echo $url
rozhlas.cz $rid "$title"
