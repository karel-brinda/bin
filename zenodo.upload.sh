#!/usr/bin/env bash
# Upload a file to an existing Zenodo deposition (needs ZENODO_TOKEN); based on https://github.com/jhpoelen/zenodo-upload

set -euo pipefail

if [[ $# -ne 2 ]]; then
	printf 'usage: %s deposition_id file\n' "${0##*/}" >&2
	exit 1
fi

if [[ -z "${ZENODO_TOKEN:-}" ]]; then
	printf '%s: ZENODO_TOKEN is not set\n' "${0##*/}" >&2
	exit 1
fi

deposition="$1"
filepath="$2"
filename="${filepath##*/}"

if [[ ! -f "$filepath" ]]; then
	printf '%s: not a file: %s\n' "${0##*/}" "$filepath" >&2
	exit 1
fi

# Pass the token through a private curl config file so that it never appears
# in the process list, in URLs, or in server logs.
curlrc="$(mktemp)"
trap 'rm -f "$curlrc"' EXIT
chmod 600 "$curlrc"
printf 'header = "Authorization: Bearer %s"\n' "$ZENODO_TOKEN" > "$curlrc"

printf 'Deposition: %s; file: %s\n' "$deposition" "$filepath"

bucket="$(
	curl -fsS -K "$curlrc" -H 'Accept: application/json' \
		"https://zenodo.org/api/deposit/depositions/$deposition" \
		| tee -a "$deposition.log" \
		| jq --raw-output .links.bucket
)"

printf '\n\n'

curl -fS --progress-bar -K "$curlrc" --upload-file "$filepath" "$bucket/$filename"
