# Dependencies, building and installing

This is a fork from Allo's USBridgeSig-AX2v0 driver with the addition of the install.sh and Makefile. It was created to be able to build and install the ax88179_178a driver on a Allo USBridge Sig using DietPi or any other Debian based OS. This eliminates the dependecy on Allo to build and provide kernel builds of this driver. Follow the steps below to download, build and install the driver.

You will need some addition free space to install the Build Essential Package and kernel source. 

Please note that I'm by no means a linux expert. For me this is just a learning excercise, so use these instructions at your own risk and do make a backup of your current OS before going down this road!!

## Dependencies

### Build Essential Package
Building the driver requires the Build Essential Package, so make sure it's installed. 
Skip this part when it is already installed.

 * On DietPi run the command below. Then search for 'Build-Essential', select and install
 * ```
   dietpi-software
   ```  
 * For any other Debian based OS try (not tested!):
 * ```
   udo apt update && sudo apt install build-essential
   ```
### rpi-source
rpi-source installs the kernel source used to build rpi-update kernels and the kernel on the Raspberry Pi OS image.
This makes it possible to build loadable kernel modules.
It is not possible to build modules that depend on missing parts that need to be built into the kernel proper (bool in Kconfig).

The script uses sudo internally when self-updating and when making the links */lib/modules/$(uname -r)/{build,source}*

More info: 
https://github.com/RPi-Distro/rpi-source

Skip this part when it is already installed.

Dependencies
```text
sudo apt install git bc bison flex libssl-dev python2 xz-utils
```

Install
```text
sudo wget https://raw.githubusercontent.com/RPi-Distro/rpi-source/master/rpi-source -O /usr/local/bin/rpi-source && sudo chmod +x /usr/local/bin/rpi-source && /usr/local/bin/rpi-source -q --tag-update
```

Run
```text
rpi-source
```

Optional: remove the extracted kernel source to free up some space
```text
rm /root/linux-*.tar.gz
```


## Building and installing
Proceed wih the build and installation of the driver.

 * Download install.sh:
 * ```
   wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/install.sh -P /usr/local/src
   ```
 * Build and install the driver:
 * ```
   sh /usr/local/src/install.sh
   ```
 * Answer the question to reboot with yes (y).
 * Done

# USBridgeSig-AX2v0

USBridgeSig having ASIX AX88179 Gigabit Etherenet Port. Asix Driver need to update  for USB audio streaming applications.

Updated Files are ax88179_178a.c , ax88179_178a.h and copy to linux source tree for compilation.

./Linux/drivers/net/usb/ax88179_178a.c
./Linux/drivers/net/usb/ax88179_178a.h


info :previous version is 0.1.4 ,  this is the updated driver source code, tesing in progress with various switches


check the version on terminal/ command mode.

modinfo ax88179_178a | grep version

version:        v2.0.0
