#!/bin/bash

render_home_manager() {
	local username=$(whoami)

	sed --in-place \
		-e "s|HOME_MANAGER_USERNAME|${username}|g" \
		home-manager/home-manager/home.nix
	sed --in-place \
		-e "s|HOME_MANAGER_USERNAME|${username}|g" \
		home-manager/flake.nix
}

render_gitconfig_for() {
	local PURPOSE=$(echo -n ${1} | tr 'a-z' 'A-Z')
	local file=$2

	local confirmed="n"
	local placeholder_username=GIT_USER_NAME_FOR_${PURPOSE}
	local placeholder_email=GIT_USER_EMAIL_FOR_${PURPOSE}

	red "Configure Git for ${PURPOSE}:"
	local git_user_name
	local git_user_email
	while [ "${confirmed}" != "y" ]
	do
		read -p "Git user.name for ${PURPOSE} (Github username): " git_user_name
		read -p "Git user.email for ${PURPOSE} (Github email): " git_user_email
		echo -e "Configure git for ${PURPOSE}: user.name=\"${YELLOW}${git_user_name}${NONE}\"; user.email=\"${YELLOW}${git_user_email}${NONE}\""
		read -p "Are you sure (y/n): " confirmed
	done

	local tmp=$(mktemp)
	sed --in-place \
		-e "s/${placeholder_username}/${git_user_name}/g" \
		-e "s/${placeholder_email}/${git_user_email}/g" \
		${file}
}

post_install_nvim() {
	red "Post-install: nvim:"
	nvim +':PlugInstall' +qall
	nvim +':GoInstallBinaries' +qall
	nvim +':RecompileSpell' +qall
}

post_install_unattended_upgrades() {
	red "Configure Ubuntu Software & Updates:"
	echo "Open the app: Software & Updates (blue icon) to configure its settings"
	echo "Go to: Updates (tab). Set:"
	yellow "- Subscribed to: Security and recommended updates"
	yellow "- Automatically check for updates: Daily"
	yellow "- When there are security updates: Download and install automatically"
	yellow "- When there are other updates: Display weekly"
	pause
}

post_install_1password() {
	red "Configure 1Password:"
	echo "Open 1Password and login"
	echo "Go to: Developer (tab). Set:"
	yellow "- Show 1password Developer experience"
	yellow "- Use the SSH Agent"
	yellow "- Integrate with 1Password CLI"
	pause
}

post_install_d2() {
	local api_token=$(op item get 'D2 (Terrastruct)' --fields label='license key')

	local source=${PWD}/home-manager/home-manager/apps/dev-tools/d2/auth.json
	local symlink=${HOME}/.config/tstruct/auth.json
	mkdir -p ${HOME}/.config/tstruct
	ln -sf ${source} ${symlink}

	sed --in-place -e "s/D2_TALA_API_TOKEN/${api_token}/g" ${source}
}
