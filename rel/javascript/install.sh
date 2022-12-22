#!/bin/sh
#
# Javascript

# Set global packages
requirements=$ZSH/rel/javascript/requirements.txt

# Install global packages
echo "› Install all packages in $requirements"
sed 's/#.*//' $requirements | xargs npm install -g
echo "All packages installed!"
