#!/bin/bash
set -euo
# set -x # DEBUG

GH_ORG=exklamationmark
GH_REPO=dotfiles
GH_BRANCH=main

# This script is meant to run directly from 'wget | bash'. It will:
# - Download a .zip copy of ${GH_ORG}/${GH_REPO}
# - Unzip into /tmp/${GH_REPO}-${GH_BRANCH}
# - Load (publicly accessible) helper scripts from within /tmp/${GH_REPO}-${GH_BRANCH}
# - Run some basic setup, e.g: get 'curl' and 'git'
# - Clone ${GH_ORG}/${GH_REPO} (via https) to ~/workspace
# - Prompt to run 'setup.bash' from the cloned repo

cd /tmp
wget -q https://github.com/${GH_ORG}/${GH_REPO}/archive/refs/heads/${GH_BRANCH}.zip -O ${GH_REPO}.zip
unzip ${GH_REPO}.zip
cd ${GH_REPO}-${GH_BRANCH}
source lib/public/ui.bash
source lib/public/detect_system.bash

# Installs a minimal setup of tools, thenclone the repo using git
# and then run the actual setup from there.
#
# This way, we can mutate the repo (e.g: adding work email, secrets, etc),
# yet track the changes as and commit them for future use.
# ------------------------------------------------------------------------------
case "${OS}" in
	linux*)
		case "${LINUX_DISTRO}" in
			ubuntu*) ;&
			debian*)
				info "Installing: git + curl..."
				sudo apt install git curl -y
				highlight "Installed: git + curl"
				;;
			*)
				error "Unsupported Linux distro: ${LINUX_DISTRO}."
				;;
		esac
		;;
	*)
		error "Unsupported OS: ${OS}. On Windows, run in WSL."
		;;
esac

# Clone exlkamationmark/${GH_REPO} to ~/workspace
REPO_DIR=${HOME}/workspace/src/github.com/${GH_ORG}/${GH_REPO}
mkdir -p "$(dirname ${REPO_DIR})"
cd "$(dirname ${REPO_DIR})"
git clone https://github.com/${GH_ORG}/${GH_REPO}.git

# Prompt to run the next action (setup.bash)
info "cd ${REPO_DIR} && ./setup.bash"
cd ${REPO_DIR} && ./setup.bash
