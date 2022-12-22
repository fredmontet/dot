#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "› Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Run Homebrew through the Brewfile
# Set global packages
requirements=$ZSH/rel/brew/Brewfile

# Upgrade homebrew
echo "› brew update"
brew update
echo "Packages installed!"

# Install new softwares if needed
echo "› brew bundle"
brew bundle --file=$requirements
echo "All packages installed!"
