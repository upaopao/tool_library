#!/bin/bash

# udevadm info --attribute-walk --name=/dev/ttyACM0 ;

# use idVendor and idProduct
#echo 'KERNEL=="ttyUSB*",ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE:="0666", GROUP:="dialout",  SYMLINK+="dashgo"' > /etc/udev/rules.d/ismart_udev.rules

# use hard port number
#echo 'KERNELS=="3-1.1",  MODE:="0666", GROUP:="dialout",  SYMLINK+="usb_0"' >> /etc/udev/rules.d/ismart_udev.rules  

# link usb
echo 'KERNEL=="ttyUSB*",ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE:="0666", GROUP:="dialout",  SYMLINK+="ANPP"' > /etc/udev/rules.d/ismart_udev.rules
#echo 'KERNEL=="ttyUSB*",ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE:="0666", GROUP:="dialout",  SYMLINK+="RTCM"' >> /etc/udev/rules.d/ismart_udev.rules
#echo 'KERNEL=="ttyUSB*",ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE:="0666", GROUP:="dialout",  SYMLINK+="CONTROL"' >> /etc/udev/rules.d/ismart_udev.rules

# link acm0
#echo 'KERNEL=="ttyACM*",ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE:="0666", GROUP:="dialout",  SYMLINK+="/dev/ttyACM_CONTROL"' >> /etc/udev/rules.d/ismart_udev.rules


