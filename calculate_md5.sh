#! /usr/bin/env bash

set -e
set -o pipefail
set -u

md5sum *.tar > md5sum.txt
