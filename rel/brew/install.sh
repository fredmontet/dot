#!/bin/sh

# Homebrew

# Install Homebrew if needed
if ! command -v brew >/dev/null 2>&1
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Fetch the newest versions
brew update

# Install softwares
brew bundle --file="$DOT/rel/brew/Brewfile"
