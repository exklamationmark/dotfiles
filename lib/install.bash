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

kubectl_custom_install() {
	local version=$1

	curl -LO https://storage.googleapis.com/kubernetes-release/release/${version}/bin/linux/amd64/kubectl
	chmod +x kubectl
	mv kubectl ~/.local/bin/
}
