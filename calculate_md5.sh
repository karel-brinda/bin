#! /usr/bin/env bash

set -e
set -o pipefail
set -u

md5sum $(find . -type f) > md5sum.txt
