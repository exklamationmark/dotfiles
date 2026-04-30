#!/bin/bash

# UI-related helpers

RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[1;36m'
GREEN='\e[0;32m'
NONE='\e[0m'

error(){
	echo -e "${RED}[error]${NONE} $*"
	exit 1
}

warn(){
	echo -e "${YELLOW}[warn]${NONE} $*"
}


info(){
	echo -e "${CYAN}[info]${NONE} $*"
}

highlight(){
	echo -e "${GREEN}>>>>>> $*${NONE}"
}


