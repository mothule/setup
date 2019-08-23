#!/usr/bin/env bash -eu

function installed() {
  if [[ ! -x "`which $1`" ]]; then
    return 1
  fi
  return 0
}

function no_installed() {
  if [[ -x "`which $1`" ]]; then
    return 1
  fi
  return 0
}
