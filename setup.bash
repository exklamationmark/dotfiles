#!/bin/bash
set -euo
# set -x # DEBUG

source lib/public/ui.bash
source lib/public/install.bash
source lib/public/sudo_while_running.bash
source lib/public/detect_system.bash

# Install things that haven't switched to home-manager (or can't work with it)
# ==============================================================================
case "${OS}" in
	linux*)
		case "${LINUX_DISTRO}" in
			ubuntu*)
				info "Configuring: apt's mirror..."
				configure_apt_mirror_linux_ubuntu
				sudo apt clean
				sudo apt update
				highlight "Configured: apt's mirror."

				info "Updating: apt's packages..."
				sudo apt upgrade -y
				highlight "Updated: apt's packages."

				info "Adding: 3rd-party PPAs..."
				add_google_chrome_ppa_linux_ubuntu
				add_mozilla_ppa_linux_ubuntu
				add_1password_ppa_linux_ubuntu
				add_tailscale_ppa_linux_ubuntu
				sudo apt update
				highlight "Added: 3rd-party PPAs."

				info "Adding: 3rd-party applications..."
				install_google_chrome_linux_ubuntu
				install_firefox_linux_ubuntu
				install_1password_linux_ubuntu
				install_1password_cli_linux_ubuntu
				install_slack_linux_ubuntu
				install_tailscale_linux_ubuntu
				highlight "Added: 3rd-party applications."
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

# Install Nix and configure basic tools
info "Installing: Nix..."
install_nix_linux_ubuntu
export PATH=/nix/var/nix/profiles/default/bin:$PATH
highlight "Installed: Nix"

# Clone private setup repo and install more elaborate tools
wait_for_1password_setup
GH_ORG=exklamationmark
GH_REPO=configure
GH_BRANCH=main
REPO_DIR=${HOME}/workspace/src/github.com/${GH_ORG}/${GH_REPO}
info "Cloning : ${GH_REPO}/${GH_BRANCH}..."
mkdir -p "$(dirname ${REPO_DIR})"
cd "$(dirname ${REPO_DIR})"
git clone --origin origin git@github.com:${GH_ORG}/${GH_REPO}.git
cd ${GH_REPO}
highlight "Cloned: ${GH_REPO}/${GH_BRANCH}."

echo -e "${YELLOW}Configure:${NONE}"
echo -e "${GREEN}cd ${$REPO_DIR} && nix run home-manager/master -- switch -b backup --flake.#${BLUE}USERNAME${NONE}@${BLUE}HOST${NONE}"
