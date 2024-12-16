#!/bin/bash

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

bash setup.bash
