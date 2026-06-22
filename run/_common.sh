#!/usr/bin/env bash
#
# Shared output helpers, sourced by run/setup, run/install, run/lint and bin/dot.
# Not named *.zsh (so it is never auto-sourced into the shell) and not
# install.sh (so run/install does not try to execute it).
#
# The message is passed as a %b argument (not interpolated into the format
# string) so callers can embed escapes like \n while staying shellcheck-clean.

info () {
  printf "\r  [ \033[00;34m..\033[0m ] %b\n" "$1"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] %b\n" "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %b\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %b\n" "$1"
  echo ''
  exit 1
}
