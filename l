#! /usr/bin/env bash


if [[ `uname` == 'Darwin' ]]; then
	colors="-G"
else
	color="--color"
fi

ls $colors -Galh $@

