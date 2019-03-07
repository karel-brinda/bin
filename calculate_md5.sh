#! /usr/bin/env bash

set -e
set -o pipefail
set -u

find . -type f -depth 1 | sort | xargs md5sum > md5sum.txt
