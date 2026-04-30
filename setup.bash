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
				sudo apt update
				highlight "Added: 3rd-party PPAs."

				info "Adding: 3rd-party applications..."
				install_google_chrome_linux_ubuntu
				install_firefox_linux_ubuntu
				install_1password_linux_ubuntu
				install_slack_linux_ubuntu
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
render_home_manager_for_current_user
install_nix_linux_ubuntu
export PATH=/nix/var/nix/profiles/default/bin:$PATH
rm -f ${HOME}/.config/home-manager
ln -sf ${PWD}/home-manager ${HOME}/.config/home-manager
cd ~/.config/home-manager
nix run home-manager switch -- -b backup
highlight "Installed: Nix"

# Clone private setup repo and install more elaborate tools
wait_for_1password_setup
GH_ORG=exklamationmark
GH_REPO=init
GH_BRANCH=main
REPO_DIR=${HOME}/workspace/src/github.com/${GH_ORG}/${GH_REPO}
info "Cloning : ${GH_REPO}/${GH_BRANCH}..."
mkdir -p "$(dirname ${REPO_DIR})"
cd "$(dirname ${REPO_DIR})"
git clone --origin https https://github.com/${GH_ORG}/${GH_REPO}.git
cd ${GH_REPO}
render_home_manager_for_current_user
rm -f ${HOME}/.config/home-manager
ln -sf ${PWD}/home-manager ${HOME}/.config/home-manager
highlight "Cloned: ${GH_REPO}/${GH_BRANCH}."

cd ~/.config/home-manager
echo -e "${YELLOW}Create a branch with this machine-specific configs:${NONE}"
echo -e "${GREEN}git checkout -b [MACHINE_BRANCH]${NONE}"
echo -e "${GREEN}git commit${NONE}"
echo -e "${GREEN}nix run home-manager switch${NONE}"
