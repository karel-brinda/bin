#!/usr/bin/env bash
# Create a new conda environment for osx-64 with mamba, falling back to conda.

set -euo pipefail

if [[ $# -eq 0 ]]; then
	printf 'usage: %s env_name [packages...]\n' "${0##*/}" >&2
	exit 1
fi

name="$1"
shift

args=(create -y --platform=osx-64 --name "$name" "$@")

printf 'Command to create the environment:\n  mamba %s\n' "${args[*]}"
if ! mamba "${args[@]}"; then
	printf 'Mamba failed, trying conda via the following command:\n  conda %s\n' "${args[*]}"
	conda "${args[@]}"
fi
