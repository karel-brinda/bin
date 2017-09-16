#! /usr/bin/env bash

set -e -o pipefail

domain=$(hostname -d 2>/dev/null || echo "unknown")
hostname=$(hostname 2>/dev/null || echo "unknown")

if [[ "$domain" = "orchestra" ]]; then
	env="orchestra"
fi

if [[ "$hostname" =~ 'o2.rc.hms.harvard.edu' ]]; then
	env="o2"
fi

if [[ "$hostname" =~ 'rc.fas.harvard.edu' ]]; then
	env="odyssey"
fi

if [[ "$env" != "" ]]; then
	echo "$env"
fi
echo "$hostname"
