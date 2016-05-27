pause "This script install the driver of USB Wireless Adapter TP-Link AC1200..."

sudo apt-get install linux-headers-generic build-essential git dkms

# a copy of this is also available in the dotfiles repo
git clone https://github.com/abperiasamy/rtl8812AU_8821AU_linux /tmp/rtl8812AU_8821AU_linux
cd /tmp/rtl8812AU_8821AU_linux

sudo cp -R /tmp/rtl8812AU_8821AU_linux /usr/src/rtl8812AU_8821AU_linux-1.0
sudo dkms add -m rtl8812AU_8821AU_linux -v 1.0
sudo dkms build -m rtl8812AU_8821AU_linux -v 1.0
sudo dkms install -m rtl8812AU_8821AU_linux -v 1.0

pause "Take out the adapter and plug in again..."
sudo dkms status

# http://swkstudios.com/tutorials/ubuntu/ubuntu-14-04-installing-tp-link-ac1200-t4u/
