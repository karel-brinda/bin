#!/usr/bin/env bash
# Wire ~/bin/.bashrc into the shell startup files; safe to run repeatedly.

set -euo pipefail

add_line() {
	local file="$1" pattern="$2" line="$3"
	if [[ -f "$file" ]] && grep -qE "$pattern" "$file"; then
		printf 'already set up: %s\n' "$file"
	else
		printf '%s\n' "$line" >> "$file"
		printf 'added to %s: %s\n' "$file" "$line"
	fi
}

# ~/.bashrc sources the shared configuration.
add_line "$HOME/.bashrc" '^[^#]*(\.|source) +[^ ]*/bin/\.bashrc' '. ~/bin/.bashrc'

# The login shell sources ~/.bashrc: via ~/.bash_profile, or via ~/.profile when
# only that exists (bash ignores ~/.profile once ~/.bash_profile is present).
if [[ ! -f "$HOME/.bash_profile" && -f "$HOME/.profile" ]]; then
	profile="$HOME/.profile"
else
	profile="$HOME/.bash_profile"
fi
add_line "$profile" '^[^#]*(\.|source) +(~|"?\$HOME"?)/\.bashrc' '[[ -f ~/.bashrc ]] && . ~/.bashrc'
