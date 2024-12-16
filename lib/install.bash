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
}

pause(){
  read -p "$*"
}

configure_apt_mirror() {
  local backup=$(mktemp)
  local tmp=$(mktemp)
  local src="/etc/apt/sources.list"

  local ubuntu_mirror="mirror://mirrors.ubuntu.com/mirrors.txt"
  local ubc_mirror="http://mirror.it.ubc.ca/ubuntu/"

  yellow "Backing up $src at $backup ..."
  cp $src $backup
  yellow "Updating $src to use Ubuntu's mirrors list ..."
  cat $backup | sed -e "s|http://us.archive.ubuntu.com/ubuntu/|${ubc_mirror}|g" > $tmp
  sudo mv $tmp $src
  rm -f $tmp
}

test_github_private_key() {
	red "Make sure ssh private keys are added..."
	pause
	echo "Testing..."
	ssh -T git@github.com
}
