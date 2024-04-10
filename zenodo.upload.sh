#! /usr/bin/env bash

# based on https://github.com/jhpoelen/zenodo-upload

set -e
set -o pipefail
set -u
#set -f

#set -x

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(dirname $0)
readonly -a ARGS=("$@")
readonly NARGS="$#"

if [[ $NARGS -ne 2 ]]; then
	>&2 echo "usage: $PROGNAME [deposition id] [filename]"
	exit 1
fi

DEPOSITION=$1
FILEPATH=$2
FILENAME=$(echo $FILEPATH | sed 's+.*/++g')

echo "Deposition: $1; filepath: $2"

BUCKET=$(curl -H "Accept: application/json" -H "Authorization: Bearer $ZENODO_TOKEN" "https://zenodo.org/api/deposit/depositions/$DEPOSITION" | tee -a "$DEPOSITION.log" | jq --raw-output .links.bucket)

echo
echo

curl --progress-bar --upload-file $FILEPATH $BUCKET/$FILENAME?access_token=$ZENODO_TOKEN
