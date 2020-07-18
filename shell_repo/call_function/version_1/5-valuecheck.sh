# build date:  2018-01-13 10:00
# modify date: 2018-01-23 20:50
# time format: date "+%Y-%m-%d %H:%M"

#!/bin/sh

echo "  "
echo "**********拷贝区域起始位置,请从该行开始拷贝,谢谢**********"

echo "md5sum develop"
md5sum /root/develop/xlauncher/src/server/conf/app.conf
md5sum /root/develop/common/conf/error.conf;
md5sum /root/develop/common/conf/vespace.conf;

md5sum /root/single-file/libtarget.so;
md5sum /root/single-file/etcd*

md5sum /root/develop/xlauncher/bin/server;
md5sum /root/develop/Costor/bin/costor;

echo "  "
echo "md5sum release"
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/conf/app.conf;
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/conf/error.conf;	

echo "  "
md5sum /root/release/release-image/release-service/host/vemerge/var/lib/vespace/vespace.conf;
md5sum /root/release/release-image/release-service/manager/vemerge/var/lib/vespace/vespace.conf;
md5sum /root/release/release-image/release-service/storage/vemerge/var/lib/vespace/vespace.conf;
md5sum /root/release/release-image/release-service/strategy/vemerge/var/lib/vespace/vespace.conf;

echo "  "
md5sum /usr/local/lib/libtarget.so; 
md5sum /usr/lib/libtarget.so;
md5sum /root/release/release-image/release-service/host/vemerge/usr/local/lib/libtarget.so;
md5sum /root/release/release-image/release-service/host/vemerge/usr/lib/libtarget.so;
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/lib/libtarget.so; 
md5sum /root/release/release-image/release-service/manager/vemerge/usr/lib/libtarget.so;
md5sum /root/release/release-image/release-service/storage/vemerge/usr/local/lib/libtarget.so
md5sum /root/release/release-image/release-service/storage/vemerge/usr/lib/libtarget.so

echo "  "
md5sum /root/release/release-image/release-service/strategy/vemerge/usr/local/bin/etcd*;
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/etcd*;

echo "  "
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/manager

echo "  "
md5sum /root/release/release-image/release-service/host/vemerge/usr/local/bin/costor;
md5sum /root/release/release-image/release-service/storage/vemerge/usr/local/bin/costor; 
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/costor;

echo "  "
md5sum /root/release/release-image/release-service/host/vemerge/usr/local/bin/target*;
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/target*;

echo " "
cat /root/dst.db
cat /root/git.db
cat /root/version.db

# clean db file
rm -fv /root/dst.db
rm -fv /root/git.db
rm -fv /root/version.db

