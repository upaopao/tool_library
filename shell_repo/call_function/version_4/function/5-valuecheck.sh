#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 19:40
# time format: date "+%Y-%m-%d %H:%M"

echo "  "
echo "********************Please Copy From The Line,Thank You********************"

echo "md5sum develop"
md5sum /root/develop/xlauncher/src/server/conf/app.conf
md5sum /root/develop/common/conf/error.conf;
md5sum /root/develop/common/conf/vespace.conf;

md5sum /root/replace-file/libtarget.so;
md5sum /root/replace-file/etcd*

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
# db_file catalog
DB_FILE="/root/function/dbfile"

# create new db depend catalog for all data
mkdir -p $DB_FILE;

# cat all db data
cat $DB_FILE/remote.db
cat $DB_FILE/version.db
cat $DB_FILE/git.db

# Screen prompts
echo "———————————————————————————————————————————————————————————————————————————————"
echo "Successful Implementation, Please Follow The On-Screen Instructions To Check..."
echo " "
echo "status ok..."
echo "  "

# clean db file
#echo "————————————————————————————————————————"
#rm -fv $DB_FILE/remote.db
#rm -fv $DB_FILE/version.db
#rm -fv $DB_FILE/git.db


