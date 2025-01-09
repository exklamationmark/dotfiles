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

render_default_gitconfig() {
	local file=${PWD}/home-manager/home-manager/apps/git/git.nix

	local confirmed="n"
	local placeholder_username=GIT_DEFAULT_USER_NAME
	local placeholder_email=GIT_DEFAULT_USER_EMAIL
	local placeholder_work_directory=GIT_WORK_DIRECTORY

	red "Configure Git"
	local git_user_name
	local git_user_email
	local git_work_directory
	while [ "${confirmed}" != "y" ]
	do
		read -p "Default git user.name (Github username): " git_user_name
		read -p "Default git user.email (Github email): " git_user_email
		read -p "Git's work directory: " git_work_directory
		echo -e "Configure git default: user.name=\"${YELLOW}${git_user_name}${NONE}\"; user.email=\"${YELLOW}${git_user_email}${NONE}\"; workDir=\"${YELLOW}${git_work_directory%/}\"${NONE}"
		read -p "Are you sure (y/n): " confirmed
	done

	sed --in-place \
		-e "s/${placeholder_username}/${git_user_name}/g" \
		-e "s/${placeholder_email}/${git_user_email}/g" \
		-e "s|${placeholder_work_directory}|${git_work_directory%/}|g" \
		${file}
}

render_gitconfig_for() {
	local PURPOSE=$(echo -n ${1} | tr 'a-z' 'A-Z')
	local file=${PWD}/$2

	local basename=$(basename ${file})
	local symlink=~/.config/git/${basename}

	echo -e "Configure Git for ${PURPOSE}"
	mkdir -p $(dirname ${symlink})
	ln -sf ${file} ${symlink}
}

render_sshconfig_for() {
	local PURPOSE=$(echo -n ${1} | tr 'a-z' 'A-Z')
	local file=${PWD}/$2

	local basename=$(basename ${file})
	local symlink=~/.ssh/${basename}

	echo -e "Configure SSH for ${PURPOSE}"
	mkdir -p $(dirname ${symlink})
	ln -sf ${file} ${symlink}
}

render_work() {
	local file=${PWD}/home-manager/home-manager/apps/work/work.nix

	local confirmed="n"
	local placeholder_vault_addr=WORK_VAULT_ADDRESS
	local placeholder_github_token=WORK_PERSONAL_GITHUB_TOKEN

	red "Configure Git"
	local vault_addr
	local github_token
	while [ "${confirmed}" != "y" ]
	do
		read -p "Vault's address (e.g: https://vault.work.domain:port): " vault_addr
		read -p "Github (Enterprise)'s personal access token: " github_token
		echo -e "Configure VAULT_ADDR: \"${YELLOW}${vault_addr}${NONE}\""
		echo -e "Configure GITHUB_TOKEN: \"${YELLOW}${github_token}${NONE}\""
		read -p "Are you sure (y/n): " confirmed
	done

	sed --in-place \
		-e "s|${placeholder_vault_addr}|${vault_addr}|g" \
		-e "s/${placeholder_github_token}/${github_token}/g" \
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
	mkdir -p $(dirname ${symlink})
	ln -sf ${source} ${symlink}

	sed --in-place -e "s/D2_TALA_API_TOKEN/${api_token}/g" ${source}
}
