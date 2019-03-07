#! /usr/bin/env bash

set -e
set -o pipefail
set -u

find . -type f | sort | xargs md5sum > md5sum.txt
