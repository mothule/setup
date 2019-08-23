#!/usr/bin/env bash -eu

COLOR_START='\033[1;'
COLOR_END='\033[0m'

BLACK_TEXT_COLOR=30
RED_TEXT_COLOR=31
GREEN_TEXT_COLOR=32
YELLOW_TEXT_COLOR=33
BLUE_TEXT_COLOR=34
MAGENTA_TEXT_COLOR=35
CYAN_TEXT_COLOR=36
WHITE_TEXT_COLOR=37

INFO_COLOR=$YELLOW_TEXT_COLOR
ERROR_COLOR=$RED_TEXT_COLOR


function log() {
  echo "${COLOR_START}$1m$2${COLOR_END}"
}

function notice() {
  echo "$1"
}

function info() {
  if [[ ! $# -eq 1 ]]; then
    echo "${FUNCNAME[0]}: wrong number of arguments ($# for 1)"
    exit 1
  fi
  log $INFO_COLOR "$1"
}

function error() {
  if [[ ! $# -eq 1 ]]; then
    echo "${FUNCNAME[0]}: wrong number of arguments ($# for 1)"
    exit 1
  fi
  log $ERROR_COLOR "$1"
}
