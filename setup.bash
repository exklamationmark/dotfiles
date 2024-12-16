#!/bin/bash
set -euo
# set -x # DEBUG

source lib/install.bash
source lib/configure.bash

# ==============================================================================
# This section is run from the bootstrapped repo (from .zip archive)
# It installs a minimal setup of tools, clone the repo using git
# and then run the actual setup from there.
#
# This way, we can mutate the repo (e.g: adding work email, secrets, etc),
# yet track the changes as and commit them for future use.
# ------------------------------------------------------------------------------
configure_apt_mirror
sudo apt-get clean
sudo apt-get update
install apt curl
install apt git

GH_ORG_DIR=${HOME}/workspace/src/github.com/exklamationmark
REPO=${GH_ORG_DIR}/dotfiles

mkdir -p ${GH_ORG_DIR}
cd ${GH_ORG_DIR}
git clone https://github.com/exklamationmark/dotfiles.git
cd ${REPO}
# ==============================================================================
# NOTE: From here onwards, we are in the cloned repo

# Upgrades
sudo apt-get upgrade -y

# Install things that haven't switched to home-manager (or can't work with it)
# ==============================================================================
configure_google_chrome_ppa
configure_mozilla_ppa
configure_1password_ppa

sudo apt-get update

install apt google-chrome-stable

sudo snap remove --purge firefox
sudo apt remove firefox -y
install apt firefox

install apt 1password
# ==============================================================================

# Template secrets/sensitive info
# ==============================================================================
render_gitconfig_for "WORK" home-manager/home-manager/apps/git/git.nix
# ==============================================================================

# Nix
curl --proto '=https' --tlsv1.2 -sSf \
	-L https://install.determinate.systems/nix | \
	sh -s -- install
export PATH=/nix/var/nix/profiles/default/bin:$PATH

# Setup with home-manager
ln -sf ${PWD}/home-manager ${HOME}/.config/home-manager
cd ~/.config/home-manager
nix run home-manager switch -- -b backup

red "For the best experience, reboot using:"
blue "sudo reboot"
pause

post_install_nvim
pause

post_install_unattended_upgrades
pause

post_install_1password
pause
