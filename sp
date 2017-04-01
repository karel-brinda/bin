#! /usr/bin/env bash

if [[ $# -eq 0 ]]; then
	s=`basename $0`
	echo "create a new Conda Python environment"
	echo "usage: $s env_name"
	exit 1
fi

conda create -y -c bioconda --name $1 Python=3.6

