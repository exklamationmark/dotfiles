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

configure_google_ppa() {
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/keyrings/google.asc
	echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.asc] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list
}

configure_mozilla_ppa() {
	wget -q -O - https://packages.mozilla.org/apt/repo-signing-key.gpg | sudo tee /etc/apt/keyrings/mozilla.asc
	echo "deb [signed-by=/etc/apt/keyrings/mozilla.asc] https://packages.mozilla.org/apt/ mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list
	echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozilla
}

test_github_private_key() {
	red "Make sure ssh private keys are added..."
	pause
	echo "Testing..."
	ssh -T git@github.com
}
