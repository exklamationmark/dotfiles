. setup_functions

# machine setup
echo -e $OSX_COLOR_YELLOW"Setting up machine for dev"$OSX_COLOR_NONE
mkdir -p ~/workspace/src ~/workspace/bin ~/workspace/pkg
echo "alias ll='ls -alF'" >> ~/.bash_profile

# add an admin group and make yourself part of it
echo -e $OSX_COLOR_YELLOW"Create admin group & add you there"$OSX_COLOR_NONE
sudo dscl . -create /groups/admin
MYUSER=`whoami`
sudo dscl . append /Groups/admin GroupMembership $MYUSER

# create /usr/local for homebrew
echo -e $OSX_COLOR_YELLOW"Prepare for Homebrew install"$OSX_COLOR_NONE
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
echo -e $OSX_COLOR_YELLOW"Install VirtualBox"$OSX_COLOR_NONE
install_dmg VirtualBox http://dlc.sun.com.edgesuite.net/virtualbox/4.3.12/VirtualBox-4.3.12-93733-OSX.dmg $TEMPDIR

# install docker & dependencies
brew install docker
brew install boot2docker
echo -e $OSX_COLOR_YELLOW"Set up Docker VM"$OSX_COLOR_NONE
boot2docker init
echo -e $OSX_COLOR_YELLOW"Starting docker VM"$OSX_COLOR_NONE
boot2docker up
echo -e $OSX_COLOR_YELLOW"Set DOCKER_HOST via .bash_profile"$OSX_COLOR_NONE
echo "export DOCKER_HOST=tcp://localhost:4243" >> ~/.bash_profile

# do some port forwarding, depending on dev machine
echo -e $OSX_COLOR_YELLOW"Forward ports from the docker with this syntax:"$OSX_COLOR_NONE
echo "    boot2docker ssh -L 8000:localhost:8000"
echo "    most of the time you will need to forward 22, 80 and 443 (for ssh, http & https)"
# most will need port 22, 80, 443 on the docker to be open, at least
# just ouput a cmd here to tell them will be fine
# read more: https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding

# tell them how to ssh to the docker host
echo -e $OSX_COLOR_YELLOW"You can ssh into the docker VM with:"$OSX_COLOR_NONE
echo "    boot2docker ssh"
echo "    username: docker"
echo "    password: tcuser"

# tell them how to upgrade to a new release of docker
# boot2docker stop
# boot2docker download
# boot2docker start
 
# clean up
echo -e $OSX_COLOR_YELLOW"Cleaning up"$OSX_COLOR_NONE
rm -rf $TEMPDIR
