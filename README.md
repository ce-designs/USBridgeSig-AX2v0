# Dependencies, building and installing

This is a fork from Allo's USBridgeSig-AX2v0 driver with the addition of the install.sh and Makefile. It was created to be able to build and install the ax88179_178a driver on a Allo USBridge Sig using DietPi or any other Debian based OS. This eliminates the dependecy on Allo to build and provide kernel builds of this driver. Follow the steps below to download, build and install the driver. Please use this at your own risk!

## Dependencies
Building the driver requires the Build Essential Package, so make sure it's installed. Skip this part when it is already installed.

 * On DietPi run the command below. Then search for the Build-Essential, select and install
 * ```
   dietpi-software
   ```  
 * On other Debian OS try (not tested!):
 * ```
   udo apt update && sudo apt install build-essential
   ```

## Building and installing
Proceed wih the build and installation of the driver.

 * Download install.sh:
 * ```
   wget https://raw.githubusercontent.com/ce-designs/USBridgeSig-AX2v0/master/install.sh
   ```
 * Build and install the driver:
 * ```
   sh install.sh
   ```
 * Reboot to run the driver when the installation succeeded:
 * ```
   sudo reboot
   ```

# USBridgeSig-AX2v0

USBridgeSig having ASIX AX88179 Gigabit Etherenet Port. Asix Driver need to update  for USB audio streaming applications.

Updated Files are ax88179_178a.c , ax88179_178a.h and copy to linux source tree for compilation.

./Linux/drivers/net/usb/ax88179_178a.c
./Linux/drivers/net/usb/ax88179_178a.h


info :previous version is 0.1.4 ,  this is the updated driver source code, tesing in progress with various switches


check the version on terminal/ command mode.

modinfo ax88179_178a | grep version

version:        v2.0.0
