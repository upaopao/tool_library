
# use kernel ttyUSB*
echo 'KERNEL=="ttyUSB*",ATTRS{idVendor}="04d8",ATTRS{idProduct}=="0053",MODE:="0777",SYMLINK+="conti_rardar"' > /etc/udev/rules.d/ismart-udev.rules
echo 'KERNEL=="ttyUSB*",ATTRS{idVendor}="0403",ATTRS{idProduct}=="6001",MODE:="0777",SYMLINK+="gps_rtcm"' >> /etc/udev/rules.d/ismart-udev.rules
echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0777", SYMLINK+="rplidar"' >> /etc/udev/rules.d/ismart-udev.rules
# restart service
#service udev reload
#sleep 2
#service udev restart
