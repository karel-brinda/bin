#! /usr/bin/env bash

if [[ $# -eq 0 ]]; then
	s=`basename $0`
	echo "create a new Conda environment"
	echo "usage: $s env_name [packages]"
	exit 1
fi

command="conda create -y -c bioconda -c defaults -c conda-forge --name $1 ${@:2}"
echo
echo "Command to create the enviroment:"
echo "$command"
echo
$command

