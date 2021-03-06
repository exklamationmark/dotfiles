#!/bin/bash

render_gitconfig() {
	local confirmed="n"

	local git_user_name
	local git_user_email
	while [ "${confirmed}" != "y" ]
	do
		read -p "Enter git user.name (or Github username): " git_user_name
		read -p "Enter git user.email (or Github email): " git_user_email
		echo -e "Configure git: user.name=\"${YELLOW}${git_user_name}${NONE}\"; user.email=\"${YELLOW}${git_user_email}${NONE}\""
		read -p "Are you sure (y/n): " confirmed
	done

	local tmp=$(mktemp)
	cp ./data/.gitconfig ${tmp}
	cat ${tmp} | \
		sed -e "s/GIT_USER_NAME/${git_user_name}/g" | \
		sed -e "s/GIT_USER_EMAIL/${git_user_email}/g" \
		> ./data/.gitconfig
	rm ${tmp}
}

render_bash_dw() {
	local confirmed="n"

	local ldap_username
	local github_token
	while [ "${confirmed}" != "y" ]
	do
		read -p "Enter Demonware's DC username (in LDAP): " ldap_username
		read -p "Enter DW Github's token (Settings > Developer settings > Personal access token): " github_token
		echo -e "Configure data/.bash_dw's DW_LDAP_USERNAME=\"${YELLOW}${ldap_username}${NONE}\""
		read -p "Are you sure (y/n): " confirmed
	done

	local tmp=$(mktemp)
	cp ./data/.bash_dw ${tmp}
	cat ${tmp} | \
		sed -e "s/DW_LDAP_USERNAME/${ldap_username}/g" | \
		sed -e "s/DW_GITHUB_PERSONAL_ACCESS_TOKEN/${github_token}/g" \
		> ./data/.bash_dw
	rm ${tmp}
}

connect_to_github() {
	local confirmed="n"

	local github_private_key
	while [ "${confirmed}" != "y" ]
	do
		read -p "Enter path to Github's private key: " github_private_key
		echo -e "Running: \"${YELLOW}ssh -T git@github.com -i ${github_private_key}${NONE}\""
		read -p "Are you sure (y/n): " confirmed
	done
}
