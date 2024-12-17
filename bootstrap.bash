#!/bin/bash
set -euo
# set -x # DEBUG

# Download the repo and run some initial setup:
# - Update Ubuntu mirrors URL
# - Install curl, git
# - Clone the repo to ~/workspace
#
# After that, the actual setup will be run out of the cloned repo

cd /tmp

wget -q https://github.com/exklamationmark/dotfiles/archive/refs/heads/main.zip -O dotfiles.zip
unzip dotfiles.zip
cd dotfiles-main

source lib/install.bash
source lib/configure.bash

# Installs a minimal setup of tools, clone the repo using git
# and then run the actual setup from there.
#
# This way, we can mutate the repo (e.g: adding work email, secrets, etc),
# yet track the changes as and commit them for future use.
# ------------------------------------------------------------------------------
blue "Configure: apt"
configure_apt_mirror
sudo apt-get clean
sudo apt-get update

blue "Install: apt-get upgrade"
sudo apt-get upgrade -y

blue "Install: git + curl"
install apt curl
install apt git

blue "Clone: github.com/exklamationmark/dotfiles"
GH_ORG_DIR=${HOME}/workspace/src/github.com/exklamationmark
REPO=${GH_ORG_DIR}/dotfiles
mkdir -p ${GH_ORG_DIR}
cd ${GH_ORG_DIR}
git clone https://github.com/exklamationmark/dotfiles.git

red "To continue, run:"
blue "cd ${REPO} && ./setup.bash"
