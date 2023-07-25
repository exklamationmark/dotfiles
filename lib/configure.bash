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
	local github_url
	local github_token
	local vault_url
	local activision_vpn_url
	local golang_private_prefix

	while [ "${confirmed}" != "y" ]
	do
		read -p "Enter Demonware's DC username (in LDAP): " ldap_username
		read -p "Enter DW Github's URL (<sth>.<sth>.<domain>): " github_url
		read -p "Enter DW Github's token (Settings > Developer settings > Personal access token): " github_token
		read -p "Enter DW Vault's URL (<sth>.<sth>.<domain>:<port>): " vault_url
		read -p "Enter Activision VPN's URL (<sth>.<sth>.<domain>): " activision_vpn_url
		read -p "Enter Golang's private prefix (<sth>.<sth>.<domain>): " golang_private_prefix
		echo -e "Configure data/.bash_dw's DW_LDAP_USERNAME=\"${YELLOW}${ldap_username}${NONE}\""
		read -p "Are you sure (y/n): " confirmed
	done

	local tmp=$(mktemp)
	cp ./data/.bash_dw ${tmp}
	cat ${tmp} | \
		sed -e "s/DW_LDAP_USERNAME/${ldap_username}/g" | \
		sed -e "s/DW_GITHUB_PERSONAL_ACCESS_TOKEN/${github_token}/g" | \
		sed -e "s/DW_GITHUB_URL/${github_url}/g" | \
		sed -e "s/DW_VAULT_URL/${vault_url}/g" | \
		sed -e "s/ACTIVISION_VPN_URL/${activision_vpn_url}/g" | \
		sed -e "s/DW_GOLANG_PRIVATE_PREFIX/${golang_private_prefix}/g" \
		> ./data/.bash_dw
	rm ${tmp}
}

render_d2lang_TALA_apikey() {
	local api_token

	local confirmed="n"
	while [ "${confirmed}" != "y" ]
	do
		read -p "Enter D2 Lang's TALA layout engine's API token: " api_token
		read -p "Are you sure (y/n): " confirmed
	done

	local tmp=$(mktemp)
	cp ./data/d2_terrastruct/auth.json ${tmp}
	cat ${tmp} | \
		sed -e "s/D2_TALA_API_TOKEN/${api_token}/g" \
		> ./data/d2_terrastruct/auth.json

	rm ${tmp}
}
