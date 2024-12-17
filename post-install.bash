#!/bin/bash
set -euo
# set -x # DEBUG

source lib/install.bash
source lib/configure.bash

blue "Sign in: 1password"
op signin

post_install_nvim

post_install_unattended_upgrades

post_install_1password

blue "Setup D2's license key"
post_install_d2
