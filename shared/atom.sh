#!/usr/bin/env bash -eu

function append_atom_config() {
  if [[ -e ~/.atom -a -e ~/.atom/keymap.cson ]] ; then
    if [[ ! -n "`cat ~/.atom/keymap.cson | grep $1`" ]] ; then
      echo $1 >> ~/.atom/keymap.cson
    fi
  fi
}

function apm_install() {
  apm $1
}
