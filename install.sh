#!/bin/bash

kernel=$(uname -r)
driver="ax88179_178a"
module_bin="$driver.ko"
module_bin_n="$module_bin.xz"
module_dir="/lib/modules/$kernel/kernel/drivers/net/usb/"
source_dir="/usr/local/src/$driver"

echo "Creating a temporary directory: $source_dir"
mkdir $source_dir
echo

echo "Downloading the $driver source code and Makefile" 
wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/ax88179_178a.c -P $source_dir
wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/ax88179_178a.h -P $source_dir
wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/Makefile -P $source_dir
echo

echo "Start with building the driver binaries using the Makefile"
make clean -C $source_dir
make -C $source_dir
echo

echo "Compressing the driver binary using xz-utils" 
sudo xz $source_dir/$module_bin
if [ -e $source_dir/$module_bin_n ]; then
        echo "Done"
else
        echo "Compression failed. Aborting the install procedure..."
        echo
        exit 1
fi
echo

echo "Starting the installation of $module_bin_n in $module_dir"
mod_layout=$(modprobe --dump-modversions /lib/modules/$kernel/kernel/drivers/net/usb/asix.ko* | grep module_layout | awk '{print $1}')
new_layout=$(modprobe --dump-modversions $source_dir/$module_bin_n | grep module_layout | awk '{print $1}')

if [ "$((mod_layout))" -eq "$((new_layout))" ]; then
        echo "sudo install -p -m 644 $source_dir/$module_bin_n $module_dir"
        sudo install -p -m 644 $source_dir/$module_bin_n $module_dir
        echo
        echo "sudo depmod $kernel"
        sudo depmod $kernel
else
        echo "module_layout NOT matching"
        echo "existing is $mod_layout --> new one is $new_layout"
fi
echo

echo "Removing the temporary directory: $source_dir"
echo "rm -rf $source_dir"
rm -rf $source_dir
echo "Done"
echo

if [ "$((mod_layout))" -eq "$((new_layout))" ]; then
        echo "Reboot needed to run the driver"
        while read -r -p "Reboot now (y/n): " answer ; do
                if [ "$answer" = "y" ] || [ "$answer" = "n" ]; then
                        break
                else
                        echo "Invalid input. Choose y or n."
                fi
        done
        if [ "$answer" = "y" ]; then
                sudo reboot
        fi
else
        echo "The installation failed"
        exit 1
fi
echo
exit 0
