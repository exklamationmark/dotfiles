#!/bin/bash

# This file contains functions for printing text with colors.
# Use ./scripts/show_bash_colors.bash to get the actual color code.

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
NONE='\e[0m'

red(){
  local msg=$1
  echo -e $RED"$msg"$NONE
}

green(){
  local msg=$1
  echo -e $GREEN"$msg"$NONE
}

yellow(){
  local msg=$1
  echo -e $YELLOW"$msg"$NONE
}

blue(){
  local msg=$1
  echo -e $BLUE"$msg"$NONE
}
