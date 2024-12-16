#!/bin/bash
set -euo
# set -x # DEBUG

source lib/install.bash
source lib/configure.bash

post_install_nvim

post_install_unattended_upgrades

post_install_1password
