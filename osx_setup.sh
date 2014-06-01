. setup_functions

# machine setup
yellow "Setting up machine for dev"
mkdir -p ~/workspace/src ~/workspace/bin ~/workspace/pkg
echo "alias ll='ls -alF'" >> ~/.bash_profile

# add an admin group and make yourself part of it
yellow "Create admin group & add you there"
sudo dscl . -create /groups/admin
MYUSER=`whoami`
sudo dscl . append /Groups/admin GroupMembership $MYUSER

# create /usr/local for homebrew
yellow "Prepare for Homebrew install"
sudo mkdir -p /usr/local
sudo chown -R root:admin /usr/local
# install homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
# OSX will ask some stuff about install Developer Tools. Okay for now & install it (we will use our own later)
# remember to run brew doctor & check for errors

# install a few necessary tools
brew install gpg
brew install git-crypt
# should have curl, wget, make, gcc by default

# prepare for installation
TEMPDIR='/tmp/.install'
rm -rf $TEMPDIR
mkdir -p $TEMPDIR
# create a folder for new apps, local to this user (to avoid permission problems)
OPTDIR=$HOME/.opt
rm -rf $OPTDIR
mkdir $OPTDIR
# where to put binaries
BINDIR=/usr/local/bin

# get virtual box
yellow "Install VirtualBox"
install_dmg VirtualBox http://dlc.sun.com.edgesuite.net/virtualbox/4.3.12/VirtualBox-4.3.12-93733-OSX.dmg $TEMPDIR

# install docker & dependencies
brew install docker
brew install boot2docker
yellow "Setting up Docker VM"
boot2docker init
yellow "Starting docker VM"
boot2docker up
yellow "Set DOCKER_HOST via .bash_profile"
echo "export DOCKER_HOST=tcp://localhost:4243" >> ~/.bash_profile

# install rvm
yellow "Install RVM"
\curl -sSL https://get.rvm.io | bash -s stable

# install postgres
yellow "Install Postgres (latest)"
brew install postgresql

# install python & pip
yellow "Install python (no-symlink) and pip"
brew install python

# install supervisord
yellow "Install supervisor"
pip install supervisor

# install fabric
yellow "Install fabric"
pip install fabric

# install redis
yellow "Install redis"
brew install redis

# install phantomjs
yellow "install phantomjs
brew install phantomjs

# advanced stuff

# do some port forwarding, depending on dev machine
yellow "Forward ports from the docker with this syntax:" 
echo "    boot2docker ssh -L 8000:localhost:8000"
echo "    most of the time you will need to forward 22, 80 and 443 (for ssh, http & https)"
# most will need port 22, 80, 443 on the docker to be open, at least
# just ouput a cmd here to tell them will be fine
# read more: https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding

# tell them how to ssh to the docker host
yellow "You can ssh into the docker VM with:"
echo "    boot2docker ssh"
echo "    username: docker"
echo "    password: tcuser"

# tell them how to upgrade to a new release of docker
# boot2docker stop
# boot2docker download
# boot2docker start

# homework
green "non-mandatory things you should install yourself:"
echo "    A ruby version (i.e: 2.1)"
echo "    Your editor (vim / emacs / sublime...)"
echo "    Browsers for your work (Chrome, Firefox, Safari)"
echo "    RubyMine"
echo "    GitX / Gitk / SourceTree"
echo "    oh my zsh"
echo "    Viki's Redis (with fvind) (Platform)"

# clean up
green "Cleaning up"
rm -rf $TEMPDIR
