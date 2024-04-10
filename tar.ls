#! /usr/bin/env bash

set -e
set -o pipefail
set -u

for x in $@; do
	tar -vtf "$x"
done
