#! /usr/bin/env bash


if [[ `uname` == 'Darwin' ]]; then
	colors="-G"
else
	colors="--color"
fi

ls $colors -Galh $@

