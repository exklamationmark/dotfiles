cd ~/alx

cp /usr/src/linux-headers-`uname -r`/.config ./

cp /usr/src/linux-headers-$(uname -r)/Module.symvers ./

make -C /lib/modules/$(uname -r)/build M=$(pwd) modules

sudo cp alx.ko /lib/modules/$(uname -r)/kernel/drivers/net/ethernet/atheros/alx/alx.ko

sudo depmod -a

make -C /lib/modules/$(uname -r)/build M=$(pwd) clean
 
