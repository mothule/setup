#!/usr/bin/env bash -eu

function brew_install() {
  if brew_installed $1 ; then
    info "$1 already installed."
    return 1
  fi
  ret=brew install $1
  if [[ ret ]] ; then
    info "$1 installed."
    return 0
  fi
  return 1
}

function brew_installed() {
  if [[ -n "`brew list -l | awk '{print $9}' | grep -E \"^$1$\"`" ]] ; then
    return 0
  fi
  return 1
}

function brew_cask_installed() {
  if [[ -n "`brew cask list -1 | grep -E \"^$1$\"`" ]] ; then
    return 0
  fi
  return 1
}

function brew_cask_install() {
  if brew_cask_installed $1 ; then
    info "$1 already installed."
    return 1
  fi
  ret=brew cask install $1
  if ret ; then
    info "$1 installed."
    return 0
  fi
  return 1
}
