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
	cat ${tmp} | sed -e "s/GIT_USER_NAME/${git_user_name}/g" | sed -e "s/GIT_USER_EMAIL/${git_user_email}/g" > ./data/.gitconfig
	rm ${tmp}
}
