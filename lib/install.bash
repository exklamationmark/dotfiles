#!/bin/bash

# -------------------- colors --------------------
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
NONE='\e[0m'

red(){
	local msg=$1
	echo -e $RED"$msg"$NONE
}

green(){
	local msg=$1
	echo -e $GREEN"$msg"$NONE
}

yellow(){
	local msg=$1
	echo -e $YELLOW"$msg"$NONE
}

blue(){
	local msg=$1
	echo -e $BLUE"$msg"$NONE
}

# -------------------- install --------------------

is_installed(){
	local package=$1
	if dpkg --get-selections | grep -q "^$package[[:space:]]*install$" >/dev/null
	then
		return 0
	fi
	return 1
}

is_installed_snap() {
	local package=$1
	if snap list | grep -q "^$package" >/dev/null
	then
		return 0
	fi
	return 1
}

install_apt() {
	local package=$1
	sudo apt-get install $package -y
}

install_deb() {
	# install a .deb file from a URL
	local package=$1
	local url=$2

	if [[ -n "$url" ]]
	then
		curl $url > /tmp/$package.deb
	fi
	sudo dpkg -i /tmp/$package.deb
}

install_snap() {
	# install a package from Ubuntu's snap store
	local package=$1
	sudo snap install $package
}

install() {
	local installer=$1
	local package=$2
	if is_installed $package
	then
		green "$package is already installed"
		return 0
	fi

	# run apt-get install for apt packages
	if ( ! is_installed $package ) && [[ $installer == "apt" ]]
	then
		yellow "Installing $package using $installer ..."
		install_apt $package
	fi

	# run dpkg -i for .deb files
	if ( ! is_installed $package ) && [[ $installer == "deb" ]]
	then
		local package_url=$3
		yellow "Installing $package using $installer ..."
		install_deb $package $package_url
	fi

	# run snap install for snap packages
	if ( ! is_installed_snap $package ) && [[ $installer == "snap" ]]
	then
		yellow "Installing $package using $installer ..."
		install_snap $package
	fi

	# install from source
	if ( ! is_installed $package ) && [[ $installer == "source" ]]
	then
		local install_function=${package}_from_source
		yellow "Installing $package using $installer ..."
		$install_function ${@:3}
	fi

	# install with custom function
	if ( ! is_installed $package ) && [[ $installer == "custom" ]]
	then
		local install_function=${package}_custom_install
		yellow "Installing $package using $installer ..."
		$install_function ${@:3}
	fi
}

pause(){
	read -p "$*"
}

configure_apt_mirror() {
	local backup=$(mktemp)
	local tmp=$(mktemp)
	local src="/etc/apt/sources.list.d/ubuntu.sources"

	local pattern="http://[a-z]\+\.archive\.ubuntu\.com/ubuntu/"
	local ubuntu_mirror="mirror://mirrors.ubuntu.com/mirrors.txt"
	local ubc_mirror="http://mirror.it.ubc.ca/ubuntu/"

	yellow "Backing up $src at $backup ..."
	cp $src $backup
	yellow "Updating $src to use Ubuntu's mirrors list ..."
	cat $backup | sed -e "s|${pattern}|${ubuntu_mirror}|g" > $tmp
	sudo mv $tmp $src
	rm -f $tmp
}

configure_google_chrome_ppa() {
	wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/keyrings/google-chrome.asc >/dev/null
	echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.asc] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
}

configure_mozilla_ppa() {
	wget -q -O - https://packages.mozilla.org/apt/repo-signing-key.gpg | sudo tee /etc/apt/keyrings/mozilla.asc >/dev/null
	echo "deb [signed-by=/etc/apt/keyrings/mozilla.asc] https://packages.mozilla.org/apt/ mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list >/dev/null
	echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozilla >/dev/null
}

configure_1password_ppa() {
	wget -q -O - https://downloads.1password.com/linux/keys/1password.asc | sudo tee /etc/apt/keyrings/1password.asc >/dev/null
	echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/1password.asc] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list >/dev/null

	sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
	wget -q -O - https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol >/dev/null
	sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
	wget -q -O - https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg >/dev/null
}

configure_docker_ppa() {
	wget -q -O - https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

configure_tailscale_ppa() {
	wget -q -O - https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).gpg | sudo tee /etc/apt/keyrings/tailscale.asc >/dev/null
	echo "deb [signed-by=/etc/apt/keyrings/tailscale.asc] https://pkgs.tailscale.com/stable/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/tailscale.list > /dev/null
}

configure_ubuntu_dotnet_ppa() {
	sudo add-apt-repository ppa:dotnet/backports
}

kubectl_custom_install() {
	local version=$1

	curl -LO https://storage.googleapis.com/kubernetes-release/release/${version}/bin/linux/amd64/kubectl
	chmod +x kubectl
	mv kubectl ~/.local/bin/
}

k8s_kind_custom_install() {
	local version=$1
	# For AMD64 / x86_64
	[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/${version}/kind-linux-amd64
	# For ARM64
	[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/${version}/kind-linux-arm64
	chmod +x ./kind
	mv ./kind ~/.local/bin
}

download_licensed_aseprite() {
	local confirmed="n"
	red "Get Aseprite licensed download link"

	local link
	while [ "${confirmed}" != "y" ]
	do
		read -p "Aseprite licensed download link: " link
		echo -e "Configure Aseprite download link: \"${YELLOW}${link}\"${NONE}"
		read -p "Are you sure (y/n): " confirmed
	done

	install deb aseprite ${link}
}

install_twine_from_github_release() {
	local version=${1}

	local url="https://github.com/klembot/twinejs/releases/download/${version}/Twine-${version}-Linux-x64.zip"
	local package=twine
	local file=/tmp/$package.zip
	local install_dir=~/.local/share/${package}

	curl -L $url -o $file
	mkdir -p $install_dir
	unzip -o $file -d $install_dir
	rm $file

	local chrome_sandbox=${install_dir}/chrome-sandbox
	sudo chown root $chrome_sandbox
	sudo chmod 4755 $chrome_sandbox

	local logo_url="https://twinery.org/icons/twine.svg"
	curl -L $logo_url -o ${install_dir}/twine.svg
}

install_tweego_from_github_release() {
	local version=${1}

	local url="https://github.com/tmedwards/tweego/releases/download/v${version}/tweego-${version}-linux-x64.zip"
	local package=tweego
	local file=/tmp/$package.zip
	local install_dir=~/.local/share/${package}

	curl -L $url -o $file
	mkdir -p $install_dir
	unzip -o $file -d $install_dir
	rm $file

	chmod +x ${install_dir}/tweego
	ln -sf ${install_dir}/tweego ~/.local/bin/tweego

	local format_logo_url="https://klembot.github.io/chapbook/logo.svg"
	local format_logo_file=${install_dir}/storyformats/chapbook-2/logo.svg
	local format_url="https://klembot.github.io/chapbook/use/2.3.0/format.js"
	local format_file=${install_dir}/storyformats/chapbook-2/format.js
	mkdir -p $(dirname ${format_file})
	curl -L ${format_url} -o ${format_file}
	curl -L ${format_logo_url} -o ${format_logo_file}

	local logo_url="https://twinery.org/icons/twine.svg"
	curl -L $logo_url -o ${install_dir}/twine.svg
}

install_godot() {
	local version=${1}

	local package=godot
	local file=/tmp/$package.zip
	local install_dir=~/.local/share/${package}

	mkdir -p $install_dir

	# GDScript binary
	local url="https://github.com/godotengine/godot/releases/download/${version}/Godot_v${version}_linux.x86_64.zip"
	curl -L $url -o $file
	unzip -o $file -d $install_dir
	rm $file
	mv $install_dir/Godot_v${version}_linux.x86_64 $install_dir/godot
	local logo_url="https://godotengine.org/assets/press/icon_color.svg"
	curl -L $logo_url -o ${install_dir}/godot.svg

	# .NET binary
	local url="https://github.com/godotengine/godot/releases/download/${version}/Godot_v${version}_mono_linux_x86_64.zip"
	curl -L $url -o $file
	unzip -o $file -d $install_dir
	rm $file
	mv $install_dir/Godot_v${version}_mono_linux_x86_64 $install_dir/godot_dotnet
	local dotnet_install_dir=$install_dir/godot_dotnet
	mv $dotnet_install_dir/Godot_v${version}_mono_linux.x86_64 $dotnet_install_dir/godot_dotnet

	local logo_url="https://godotengine.org/assets/press/icon_monochrome_dark.svg"
	curl -L $logo_url -o ${install_dir}/godot_dotnet.svg
}
