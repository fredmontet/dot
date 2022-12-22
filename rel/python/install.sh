#!/bin/sh
#
# Python
#
# Installation made with Pyenv

# Set the desired Python versions
python="3.8.7"

# Set global packages
requirements=$ZSH/rel/python/requirements.txt

# Install Python
echo "› Installing Python"
pyenv install --skip-existing $python

# Set the default version
echo "› Setting Python default version"
pyenv global $python
echo "Python default version is set to $default_ver"

# Let pip be in its latest version
echo "› Install latest pip version"
pip install -q --upgrade pip
echo "Pip version is now at $(pip --version | cut -c5-11)"

# Install global packages
echo "› Install all packages in $requirements"
pip install -q -r $requirements
echo "All packages installed!"
