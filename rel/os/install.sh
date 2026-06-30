#!/bin/sh

set -e

. "$DOT/run/_common.sh"

# Install available macOS software updates
if sudo -n true 2>/dev/null; then
	sudo -n softwareupdate -i -a
else
	info "Skipping macOS software updates (admin password required)"
fi
