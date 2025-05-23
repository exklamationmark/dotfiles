#!/bin/bash
set -euo
# set -x # DEBUG

source lib/install.bash
source lib/configure.bash

# Install things that haven't switched to home-manager (or can't work with it)
# ==============================================================================
blue "Configure PPAs"
configure_google_chrome_ppa
configure_mozilla_ppa
configure_1password_ppa
configure_docker_ppa
configure_ubuntu_dotnet_ppa
sudo apt-get update

blue "Install: google-chrome"
install apt google-chrome-stable

blue "Install: firefox (non-snap version)"
sudo snap remove --purge firefox
sudo apt remove firefox -y
install apt firefox

blue "Install: 1password"
install apt 1password
install apt 1password-cli

blue "Install: docker"
install apt docker-ce
install apt docker-ce-cli
install apt containerd.io
install apt docker-buildx-plugin
sudo usermod -aG docker $(whoami)

blue "Install: kubernetes tools"
mkdir -p ${HOME}/.local/bin
install custom kubectl v1.31.0
install custom k8s_kind v0.26.0

blue "Install: tailscale"
install apt tailscale

blue "Install: slack"
install snap slack

blue "Install: Aseprite"
download_licensed_aseprite

blue "Install: Twine"
install_twine_from_github_release 2.10.0
install_tweego_from_github_release 2.1.1

blue "Install: Godot"
install_godot "4.3-stable"
install apt dotnet-sdk-9.0
# ==============================================================================

# Template secrets/sensitive info
# ==============================================================================
render_home_manager

render_work

render_default_gitconfig
render_gitconfig_for "WORK" home-manager/home-manager/apps/work/git/work
render_gitconfig_for "PERSONAL" home-manager/home-manager/apps/personal/git/personal

render_sshconfig_for "WORK" home-manager/home-manager/apps/work/ssh/work.config
render_sshconfig_for "PERSONAL" home-manager/home-manager/apps/personal/ssh/personal.config
# ==============================================================================

blue "Install: nix"
curl --proto '=https' --tlsv1.2 -sSf \
	-L https://install.determinate.systems/nix | \
	sh -s -- install
export PATH=/nix/var/nix/profiles/default/bin:$PATH

blue "Install: things configured by home-manager"
ln -sf ${PWD}/home-manager ${HOME}/.config/home-manager
cd ~/.config/home-manager
nix run home-manager switch -- -b backup

red "For the best experience, reboot using:"
blue "sudo reboot"
pause
