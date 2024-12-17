#!/bin/bash
set -euo
# set -x # DEBUG

source lib/install.bash
source lib/configure.bash

# Install things that haven't switched to home-manager (or can't work with it)
# ==============================================================================
configure_google_chrome_ppa
configure_mozilla_ppa
configure_1password_ppa
configure_docker_ppa

sudo apt-get update

install apt google-chrome-stable

sudo snap remove --purge firefox
sudo apt remove firefox -y
install apt firefox

install apt 1password
install apt 1password-cli

install apt docker-ce
install apt docker-ce-cli
install apt containerd.io
install apt docker-buildx-plugin
sudo usermod -aG docker $(whoami)

install custom kubectl v1.31.0
install custom k8s_kind v0.26.0
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
