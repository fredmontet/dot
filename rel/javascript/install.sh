#!/bin/sh

# Javascript

requirements=$DOT/rel/javascript/requirements.txt
sed 's/#.*//' $requirements | xargs npm install.sh -g
