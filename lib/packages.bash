#!/bin/bash

# This file contains functions for working with packages (status, install, etc).


git_from_source() {
  # Use Git >= 2.19. There some bugs with 'git add --patch' that was fixed there.
  local version=$1 # e.g: 2.26.0

  install apt make
  install apt tar
  install apt gzip
  install apt autoconf
  install apt clang
  install apt zlib1g-dev # required for building
  install apt asciidoc-base

  local orig_dir=$(pwd)
  mkdir -p /tmp/git
  local tmpdir="/tmp/git"
  # local tmpdir=$(mktemp -d)
  curl -sX GET "https://codeload.github.com/git/git/tar.gz/v$version" -o $tmpdir/v$version.tar.gz
  tar -xzvf $tmpdir/v$version.tar.gz -C $tmpdir
  cd $tmpdir/git-$version && \
    make configure && \
    ./configure && \
    make all man && \
    sudo make install install-man

  rm -rf $tmpdir
  cd $orig_dir
}


