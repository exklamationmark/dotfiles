#!/bin/bash

# This file contains functions for printing text with colors.
# Use ./scripts/show_bash_colors.bash to get the actual color code.

_COLOR_RED='\e[0;31m'
_COLOR_GREEN='\e[0;32m'
_COLOR_YELLOW='\e[0;33m'
_COLOR_BLUE='\e[0;34m'
_COLOR_NONE='\e[0m'

red(){
  local msg=$1
  echo -e $_COLOR_RED"$msg"$_COLOR_NONE
}

green(){
  local msg=$1
  echo -e $_COLOR_GREEN"$msg"$_COLOR_NONE
}

yellow(){
  local msg=$1
  echo -e $_COLOR_YELLOW"$msg"$_COLOR_NONE
}

blue(){
  local msg=$1
  echo -e $_COLOR_BLUE"$msg"$_COLOR_NONE
}
