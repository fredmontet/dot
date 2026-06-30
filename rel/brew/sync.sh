#!/bin/sh
#
# sync.sh -- append newly installed Homebrew packages to the Brewfile.
#
# Run only by `dot` (never by run/install, which scans for install.sh, nor on
# shell startup, which globs *.zsh). It snapshots the currently installed
# brew/tap/cask state and appends any package that is installed but not yet
# listed in rel/brew/Brewfile, under a dated "# Added by dot" header.
#
# This is append-only: it never edits, reorders, or removes existing lines, so
# the hand-curated sections (# CLI Apps / # Languages / # Shell tooling / # Cask)
# stay intact.
#
# Commented entries count as "known": a line like `# brew "go"` suppresses the
# automatic re-add of a still-installed package. So to stop a package from
# coming back: either `brew uninstall` it (then it is no longer installed and
# won't be dumped) or keep it as a commented `# brew "..."` line.

set -e

. "$DOT/run/_common.sh"

BREWFILE="$DOT/rel/brew/Brewfile"

installed="$(mktemp)"
existing="$(mktemp)"
added="$(mktemp)"
trap 'rm -f "$installed" "$existing" "$added"' EXIT INT TERM

# Snapshot the currently installed state. --file=- pipes the dump to stdout
# (no file written); --no-mas/--no-vscode keep the comparison to the
# Homebrew-managed entries the Brewfile actually tracks.
brew bundle dump --file=- --no-vscode --no-mas >"$installed" 2>/dev/null || true

# Keys already known to the Brewfile, treating commented lines as known. Each
# entry is reduced to a "type name" key: `brew "node"` and `# brew "go"` become
# `brew node` and `brew go` respectively.
grep -E '^#?[[:space:]]*(tap|brew|cask) ' "$BREWFILE" 2>/dev/null \
	| sed -E 's/^#?[[:space:]]*([a-z]+) "([^"]+)".*/\1 \2/' >"$existing" || true

# Walk the installed lines; keep those whose "type name" key is not already
# known. Matching uses only the leading `type "name"`; any trailing options
# (args:, etc.) are ignored for matching but preserved when the line is appended.
while IFS= read -r line; do
	case "$line" in
		tap\ *|brew\ *|cask\ *) ;;
		*) continue ;;
	esac
	key="$(printf '%s\n' "$line" | sed -E 's/^([a-z]+) "([^"]+)".*/\1 \2/')"
	if ! grep -Fxq "$key" "$existing"; then
		printf '%s\n' "$line" >>"$added"
	fi
done <"$installed"

if [ ! -s "$added" ]; then
	success "Brewfile already in sync"
	exit 0
fi

count="$(grep -c '.' "$added")"

{
	printf '\n# Added by dot (%s)\n' "$(date +%F)"
	cat "$added"
} >>"$BREWFILE"

success "Added $count package(s) to Brewfile"
