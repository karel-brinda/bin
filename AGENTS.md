# AGENTS.md

## Scope

This repository is a personal cross-machine toolbox: shell commands, dotfiles, Vim/Neovim configuration, Git helpers, installers, converters, and file/project templates.

Prefer simple, portable code. Preserve existing short command names and behavior unless explicitly asked to change them. Normalize style when touching related files, but do not rewrite unrelated code.

## Compatibility

All general-purpose code must target:

- Bash >= 3.2.
- Vim >= 7.4.
- Neovim >= 0.9.0.
- macOS >= 10.15, on Intel and Apple Silicon.
- CentOS/RHEL >= 7, including Rocky Linux and AlmaLinux equivalents.

Ubuntu/Debian should work where this comes naturally, but they do not define the compatibility floor.

New functionality may require newer versions only when guarded so that startup/basic operation still works on the versions above.

### Bash 3.2 rule

Everything written in Bash must be Bash 3.2-compatible. In particular, do not use Bash 4+ features such as:

- associative arrays (`declare -A`),
- `mapfile` / `readarray`,
- `${var,,}` / `${var^^}` case conversion,
- `globstar`,
- `coproc`,
- namerefs (`declare -n`),
- `[[ -v var ]]`,
- `&>>` or `|&`.

Indexed arrays, `[[ ... ]]`, `local`, `BASH_SOURCE`, `$(...)`, and `pipefail` are fine.

Do not assume GNU userland on macOS. Avoid GNU-only `sed`, `grep`, `find`, `readlink`, `date`, `diff`, etc. unless the command is explicitly Linux-only or there is a portable fallback.

## Shell scripts

Use:

```bash
#!/usr/bin/env bash

set -euo pipefail
```

for normal standalone scripts unless there is a concrete reason not to. Do not enable strict mode in sourced files such as `.bashrc` or `.aliases`.

General style:

- Quote variable and pathname expansions.
- Use `$(...)`, never backticks.
- Use `"$@"` to forward arguments.
- Use `[[ ... ]]` for Bash conditionals.
- Use real tabs for shell indentation.
- Prefer `printf` over `echo -e`.
- Do not parse `ls`.
- Do not use unsafe `find | xargs` patterns for filenames.
- Use `mktemp` for temporary files/directories.
- Keep tiny scripts tiny.
- Do not add unused `PROGNAME`, `PROGDIR`, `ARGS`, `NARGS`, author blocks, dates, or similar boilerplate to ordinary scripts. Templates may retain illustrative boilerplate as described below.

A shell script header should contain only:

1. the shebang,
2. optionally one short comment if the purpose is not obvious,
3. strict mode when appropriate.

## Sourced shell code

Use a function rather than an executable when the command must modify the caller's shell, especially `cd`, environment variables, or shell options.

Use aliases only for simple argument-independent abbreviations. Parameterized or multi-step logic should be a function.

Functions must use `local` variables and quote their arguments.

Examples such as `ct`, `ctt`, `cdfirst`, and `cdlast` must remain sourced functions because they change the current directory.

## Command families

Preserve the existing naming model:

- `c.*` - create a file/project/object.
- `d.*` - compare/diff formats.
- `i.*` - install/configure software.
- `*.to_*` - convert formats.
- `dir.*` - directory operations.
- `git/g.*` - Git commands.
- `gg.*` - search helpers.
- `samples/` - canonical templates used by creators.

Do not rename established short commands merely to make names more descriptive.

### `c.*` creators

Creators should be thin wrappers around `samples/` whenever a template exists.

- Keep template content in one place.
- Validate arguments before creating anything.
- Quote source and destination paths.
- Do not add preflight destination-existence checks; preserve the underlying command's normal overwrite behavior unless explicitly asked to change it.
- Do not `touch` a destination before copying a template.

### Empty files

Create an empty file only when emptiness is intentional, for example a new README to edit or a marker file.

Do not use `touch` merely to ensure existence when updating the timestamp of an existing file would be unintended.

Prefer create-if-absent semantics for helpers that initialize files.

### Installers

`i.*` scripts may be OS-specific, but this must be obvious in the file.

- Detect OS/architecture where needed.
- Prefer idempotent operations.
- Keep download URLs and pinned versions near the top.
- Do not execute installers automatically while testing changes.

## Vim and Neovim

`.vimrc` is the shared source of truth. Neovim-specific configuration should remain minimal and source `.vimrc`.

The shared configuration must start successfully on Vim 7.4 and Neovim 0.9.0. Features requiring newer versions must be guarded with `has()`, `exists()`, `executable()`, `filereadable()`, or explicit version checks.

Do not rewrite portable Vimscript into Neovim-only Lua.

Use:

- `setlocal` for filetype-specific settings,
- named `augroup` blocks with `autocmd!`,
- non-recursive mappings (`nnoremap`, `inoremap`, etc.) by default,
- capability/version checks around optional features.

### `.vimrc` header

The top of `.vimrc` is a quick reference, not documentation of implementation details.

It should list only user-visible custom behavior that is useful to remember:

- leader key,
- important mappings,
- plugin maintenance commands,
- important filetype mappings,
- on-demand plugin commands/toggles.

When such behavior changes, update the header in the same change.

Do not put author/date/license information, changelogs, default Vim behavior, or implementation details in the header.

### Vim comments

Use comments to explain intent or non-obvious compatibility constraints, not the syntax immediately below them.

For plugins, prefer one concise line such as:

```vim
" Plugin: ALE - diagnostics/completion; disabled by default, <leader>a toggles it.
```

Put minimum-version information immediately next to the guarded plugin when relevant.

Keep major sections visually separated and named consistently:

```vim
" =============================================================================
" Section: Filetype-specific settings
" =============================================================================
```

## Templates

`samples/` defines the preferred style for newly created files. Keep new template content focused and avoid adding unused imports or dependencies.

Preserve existing instructional comments, commented examples, optional scaffolding, and illustrative boilerplate in templates unless explicitly asked to remove them. Do not treat template content as unused solely because the template itself does not invoke it.

A template should represent how a new file should look today, while still respecting the compatibility rules above.

## Changes by agents

Before changing a file:

1. read the whole file,
2. inspect related files in the same command family,
3. preserve command behavior unless changing it is the task,
4. normalize obvious inconsistencies in the touched family,
5. avoid unrelated repository-wide cleanup.

When an inconsistency requires a semantic choice rather than a stylistic cleanup, ask before choosing.
