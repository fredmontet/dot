# Plan: `dot` appends newly installed brew packages to the Brewfile

## Context
`bin/dot` is the periodic refresh: it pulls the repo, resets OS defaults, runs `brew upgrade`, then `run/install` (which `brew bundle`-installs from `rel/brew/Brewfile`). Today the Brewfile is one-way — `dot` installs *from* it but never records packages you've added ad-hoc with `brew install`. This change closes the loop: `dot` notices brew packages that aren't tracked yet and appends them, without disturbing the hand-curated `# CLI Apps / # Languages / # Shell tooling / # Cask` sections.

Per your choices: **append-new-only** (never overwrite or reorder; only add installed-but-unlisted packages under an auto-managed section) and **leave the change uncommitted** (review with `git diff` and commit yourself).

## Goal
Make `dot` append brew packages that are installed but not yet listed in `rel/brew/Brewfile`, under an auto-managed section, leaving existing curation and ordering intact.

## Approach
Add a small, self-contained `rel/brew/sync.sh` that diffs `brew bundle dump` output against entries already in the Brewfile and appends only the missing ones. Invoke it from `bin/dot` after `run/install`. Keeping the logic in `rel/brew/` — named `sync.sh` (not `install.sh`) and `.sh` (not `.zsh`) — matches the repo's topic convention and guarantees it runs **only** via `dot`, never on every `run/install` (`find ./rel -name install.sh`) nor on shell startup (`**/*.zsh` glob). Matching is by `(type, name)` key; **commented-out entries count as "known"**, so a line can be suppressed by commenting it instead of deleting it.

## File Changes

**Create — `rel/brew/sync.sh`** (executable, `#!/bin/sh`) — compares installed state to the Brewfile and appends new entries under a dated header.

**Modify — `bin/dot`** (insert after line 60, before `success "Installation completed"` on line 62):
```bash
# Record newly installed brew packages into the Brewfile
info "Syncing Brewfile"
"$DOT/rel/brew/sync.sh" || true
```
`$DOT` is already exported (line 45); `|| true` matches the resilient style every other `dot` step uses.

## Implementation Steps

**Task 1 — Write `rel/brew/sync.sh`**
1. `#!/bin/sh`, `set -e`, a top comment explaining append-only behavior + the "comment a line to suppress re-add / `brew uninstall` to drop for good" note; source `. "$DOT/run/_common.sh"` for `info`/`success`; `BREWFILE="$DOT/rel/brew/Brewfile"`.
2. Snapshot installed state: `installed="$(brew bundle dump --file=- --no-vscode --no-mas 2>/dev/null || true)"` (`--file=-` pipes to stdout, no file written; yields `tap`/`brew`/`cask` lines).
3. Build the set of keys already known to the Brewfile, treating commented entries as known: `existing="$(grep -E '^#?[[:space:]]*(tap|brew|cask) ' "$BREWFILE" | sed -E 's/^#?[[:space:]]*([a-z]+) "([^"]+)".*/\1 \2/' || true)"` (e.g. `brew "node"` and `# brew "go"` both reduce to keys `brew node` / `brew go`).
4. Loop the installed lines; for each `tap`/`brew`/`cask` line reduce to its `type name` key and, if absent from `existing`, collect the original line as "new".
5. If nothing new → `success "Brewfile already in sync"`; exit 0.
6. Else append a blank line, `# Added by dot ($(date +%F))`, then the new lines to `$BREWFILE`; print `success "Added N package(s) to Brewfile"`.
7. `chmod +x rel/brew/sync.sh`.

**Task 2 — Wire it into `bin/dot`**
8. Insert the `info "Syncing Brewfile"` + `"$DOT/rel/brew/sync.sh" || true` block between the install step (line 60) and `success` (line 62).

## Acceptance Criteria
- With a package installed but absent from the Brewfile, `DOT=~/.dot sh rel/brew/sync.sh` appends exactly its line under a `# Added by dot (YYYY-MM-DD)` header; nothing else changes (`git diff`).
- Re-running immediately reports "Brewfile already in sync" with an empty `git diff` (idempotent).
- Existing section comments and ordering of pre-existing entries are byte-for-byte unchanged.
- A package present only as a commented line (e.g. `# brew "go"`) is **not** re-added.
- `dot` runs the sync after install and still reaches `success` even if sync fails (`|| true`).
- `make install` / `run/install` do **not** trigger sync; `sync.sh` does not load into shells.

## Verification Steps
1. `DOT="$HOME/.dot" sh rel/brew/sync.sh`; `git -C ~/.dot diff rel/brew/Brewfile` — inspect the appended section.
2. Re-run — confirm "Brewfile already in sync" and empty diff.
3. Comment a still-installed formula (e.g. `# brew "tree"`), run sync, confirm `tree` is not re-added.
4. `find ./rel -name install.sh` still lists only `rel/brew/install.sh`; `grep -rn sync.sh run/` is empty — proves install won't run it.
5. `reload` a shell — no errors, no stray functions from `sync.sh`.
6. Run `dot` end-to-end and watch for the "Syncing Brewfile" step before "Installation completed".

## Risks & Mitigations
- **Re-adds hand-deleted-but-still-installed packages** (your current `go`/`kotlin`/`rust` removal): since they're still installed, sync appends them again. *Mitigation:* `brew uninstall` to drop for good, or keep them as commented `# brew "go"` lines (treated as known, not re-added). Documented in the `sync.sh` header comment.
- **`brew bundle dump` is slow** (inspects every cask). *Mitigation:* runs once per `dot`, after the already-slow upgrade/install; `|| true` prevents an error from failing `dot`.
- **Parsing brittleness** for unusual entries (`brew "x", args: [...]`). *Mitigation:* matching uses only the leading `type "name"`; trailing options are ignored for matching but preserved when the dump's line is appended.
- **`autostash` interaction**: `dot` stashes/re-applies uncommitted Brewfile edits around `git pull`, then sync appends — the change lands cleanly in the working tree for review. Noted for awareness.