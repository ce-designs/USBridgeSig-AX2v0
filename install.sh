#!/bin/bash

kernel=$(uname -r)
driver="ax88179_178a"
module_bin="$driver.ko"
module_dir="/lib/modules/$kernel/kernel/drivers/net/usb/"
source_dir="/usr/local/src/$driver"

echo "Create working folder"
mkdir $source_dir
echo

echo "Download $driver source code" 
wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/ax88179_178a.c -P $source_dir
wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/ax88179_178a.h -P $source_dir
wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/Makefile -P $source_dir
echo

echo "Start building the driver binaries using the Makefile"
make clean -C $source_dir
make -C $source_dir
echo

echo "Start the installation of $module_bin in $module_dir"
mod_layout=$(modprobe --dump-modversions /lib/modules/$kernel/kernel/drivers/net/usb/asix.ko* | grep module_layout | awk '{print $1}')
new_layout=$(modprobe --dump-modversions $source_dir/$module_bin | grep module_layout | awk '{print $1}')

if [ "$((mod_layout))" -eq "$((new_layout))" ] 
then
	echo "sudo install -p -m 644 $module_bin $module_dir"
	sudo install -p -m 644 $module_bin_n $module_dir 

	echo "sudo depmod $kernel"
	sudo depmod $kernel
else
	echo "module_layout NOT matching"
	echo "existing is $mod_layout    new one is $new_layout"
fi
echo

echo "Remove source files and binaries"
echo "rm -rf $source_dir"
#rm -rf $source_dir
echo

if [ "$((mod_layout))" -eq "$((new_layout))" ] 
then
	echo "Reboot to run the driver"
else
	echo "The installation failed"
fi
echo
