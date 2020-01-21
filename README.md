# USBridgeSig-AX2v0


USBridgeSig having ASIX AX88179 Gigabit Etherenet Port. Asix Driver need to update  for USB audio streaming applications.

Updated Files are ax88179_178a.c , ax88179_178a.h and copy to linux source tree for compilation.

./Linux/drivers/net/usb/ax88179_178a.c
./Linux/drivers/net/usb/ax88179_178a.h


info :previous version is 0.1.4 ,  this is the updated driver source code, tesing in progress with various switches


check the version on terminal/ command mode.

modinfo ax88179_178a |grep version

version:        v2.0.0
