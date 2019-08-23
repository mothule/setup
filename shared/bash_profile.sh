#!/usr/bin/env bash -eu

function append_bash_profile() {
  if [[ ! $# -eq 1 ]]; then
    error "${FUNCNAME[0]}: wrong number of arguments ($# for 1)"
    exit 1
  fi
  if no_contains_hash_profile $1 ; then
    echo "$1" >> ~/.bash_profile
  fi
}

function reload_bash_profile() {
  source ~/.bash_profile
}

function contains_bash_profile() {
  if [[ -n "`cat ~/.bash_profile | grep $1`" ]] ; then
    return 0
  fi
  return 1
}

function no_contains_hash_profile() {
  if [[ ! -n "`cat ~/.bash_profile | grep $1`" ]] ; then
    return 0
  fi
  return 1
}
