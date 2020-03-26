#!/bin/bash

# This file contains functions for working with packages (status, install, etc).

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
}

pause(){
  read -p "$*"
}

configure_apt_mirror() {
  local backup=$(mktemp)
  local tmp=$(mktemp)
  local src="/etc/apt/sources.list"

  yellow "Backing up $src at $backup ..."
  cp $src $backup
  yellow "Updating $src to use Ubuntu's mirrors list ..."
  cat $backup | sed -e 's|http://us.archive.ubuntu.com/ubuntu/|mirror://mirrors.ubuntu.com/mirrors.txt|g' > $tmp
  sudo mv $tmp $src
  rm -f $tmp
}

install_git_from_source() {
  local version=$1 # e.g: 2.26.0

  install apt make
  install apt tar
  install apt gzip
  install apt autoconf
  install apt clang
  install apt zlib1g-dev # required for building
  install apt asciidoc-base

  mkdir -p /tmp/git
  local tmpdir="/tmp/git"
  # local tmpdir=$(mktemp -d)
  curl -sX GET "https://codeload.github.com/git/git/tar.gz/v$version" -o $tmpdir/v$version.tar.gz
  tar -xzvf $tmpdir/v$version.tar.gz -C $tmpdir
  cd $tmpdir/git-$version && \
    make configure && \
    ./configure && \
    make all man && \
    sudo make install install-doc install-html
  # rm -rf $tmpdir
}
