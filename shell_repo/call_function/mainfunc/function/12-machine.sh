#!/bin/bash

# build date:  2018-03-01 14:10
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# functional description: remove ./host-root/etc/machine.conf and ./host-root/etc/openvswitch/system-id.conf

# 1.stop all running virtual host
cd /root/systemvm;
./stop-hosts.py;
sync;
sync;

# 2.unpack from base.img
cd /root/systemvm;
./buildhost.py unpack;

# 3. main operating
# rm machine.conf
cd /root/systemvm/host-root/etc/;
rm -fv machine*;

# scp new machine.conf from host:192.168.16.227
scp root@192.168.16.227:/root/systemvm/machine.conf .
cat machine.conf;

# rm system-id.conf
cd /root/systemvm/host-root/etc/openvswitch;
rm -fv system-id.conf;

# sync all data
sync;
sync;

# 4.pack to base.img
cd /root/systemvm;
./buildhost.py pack;
sync;
sync;


