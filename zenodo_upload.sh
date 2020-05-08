#! /usr/bin/env bash

# based on https://github.com/jhpoelen/zenodo-upload

set -e
set -o pipefail
set -u
#set -f

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

BUCKET=$(curl -H "Accept: application/json" -H "Authorization: Bearer $ZENODO_TOKEN" "https://www.zenodo.org/api/deposit/depositions/$DEPOSITION" | jq --raw-output .links.bucket)


curl --progress-bar -o /dev/null --upload-file $FILEPATH $BUCKET/$FILENAME?access_token=$ZENODO_TOKEN
