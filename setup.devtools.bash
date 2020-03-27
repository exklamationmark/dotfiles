#!/bin/bash

set -exuo

source lib/colors.bash
source lib/packages.bash



#################### Go ####################
blue "Install go 1.14"

install apt gcc

sudo rm -rf /usr/local/go
curl 'https://dl.google.com/go/go1.14.linux-amd64.tar.gz' > /tmp/golang.tar.gz
sudo tar -C /usr/local/ -xzvf /tmp/golang.tar.gz
sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go

# vim-go binaries
vim +'GoInstallBinaries' +qall

# bash helpers
cp -f data/.bash_golang ~/.bash_golang
echo "
# Go-specific helpers
if [ -f ~/.bash_golang ]; then
    . ~/.bash_golang
fi" >> ~/.bashrc

#################### Rust ####################



#################### Racket ####################



#################### Julia ####################



#################### Docker ####################
blue "Install Docker"

install apt apt-transport-https
install apt ca-certificates
install apt curl
install apt software-properties-common

# add docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# install
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
install apt docker-ce

# add current user to docker group
USER=`whoami`
sudo usermod -aG docker $USER




#################### Kubernetes ####################
blue "Install kubectl"

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# bash helpers
cp -f data/.bash_kubernetes ~/.bash_kubernetes
echo "
# Kubernetes-specific helpers
if [ -f ~/.bash_kubernetes ]; then
    . ~/.bash_kubernetes
fi" >> ~/.bashrc



#################### Debug ####################
blue "Install debug tools"

install apt dnsutils
install apt netcat
install apt socat
