#!/bin/bash

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
