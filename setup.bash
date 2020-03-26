#!/bin/bash

set -exuo

source lib/colors.bash
source lib/packages.bash

# configure_apt_mirror
# sudo apt-get update
# 
# #################### Build essentials ####################
# 
# pause "Installing must-have packages. Press [Enter] to continue..."
# 
install apt make
install apt curl
install_git_from_source "2.26.0"
# # install apt git
# # install apt vim
# # install apt gitk
# # install apt tmux
# # install apt xclip
# # install apt w3m
# # install apt pandoc

