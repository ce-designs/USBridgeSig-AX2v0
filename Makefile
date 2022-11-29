KERN_DIR	= /usr/src/linux-headers-$(shell uname -r)
PWD 		= $(shell pwd)

obj-m 		= ax88179_178a.o

default:
	$(MAKE) -C $(KERN_DIR) M=$(PWD) modules

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.ko.xz *.mod.c .tmp_versions
