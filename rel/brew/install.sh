#!/bin/sh

# Homebrew

# Install Homebrew if needed
if test ! $(which brew)
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Fetch the newest versions
brew update

# Install softwares
brew bundle --file=$DOT/rel/brew/Brewfile
