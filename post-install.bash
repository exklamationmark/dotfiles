#!/bin/bash
set -euo
# set -x # DEBUG

source lib/install.bash
source lib/configure.bash

blue "Configure: 1password"
post_install_1password
op signin

blue "Configure: nvim"
post_install_nvim

blue "Configure: Ubuntu updates"
post_install_unattended_upgrades

blue "Configure: D2"
post_install_d2
