#!/bin/sh

# Python

# Set the desired Python versions
python="3.10.0"

# Set global packages
requirements=$DOT/rel/python/requirements.txt
# Install Python
pyenv install --skip-existing $python
# Set the default version
pyenv global $python
# Let pip be in its latest version
pip install -q --upgrade pip
# Install global packages
pip install -q -r $requirements
