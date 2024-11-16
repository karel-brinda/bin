#! /usr/bin/env bash

if [[ $# -eq 0 ]]; then
	s=`basename $0`
	echo "create a new Conda environment"
	echo "usage: $s env_name [packages]"
	exit 1
fi

command1="mamba create -y --platform=osx-64 --name $1 ${@:2}"
command2="conda create -y --platform=osx-64 --name $1 ${@:2}"
(
	echo "Command to create the enviroment:"
	echo "$command1"
	$command1
) || (
	echo "Mamba failed, trying Conda via the following command:"
	echo "$command2"
	$command2
)
