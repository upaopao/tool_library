#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-03-16 11:10
# time format: date "+%Y-%m-%d %H:%M"

# record the exec script path before copy data
EXEC_SCRIPT_PATH="`pwd`"

cd /root/release/release-image
rm ubuntu1604-*.iso -rf
rm squashfs-root/ -rf

cd /root/release/release-image
git checkout ubuntu1604/install/filesystem.squashfs
./buildsquashfs.sh --unpack

# etcd file
rm -f /root/release/release-image/release-service/strategy/vemerge/usr/local/bin/etcd*;
rm -f /root/release/release-image/release-service/manager/vemerge/usr/local/bin/etcd*;
cp -f /root/replace-file/etcd* /root/release/release-image/release-service/strategy/vemerge/usr/local/bin;
cp -f /root/replace-file/etcd* /root/release/release-image/release-service/manager/vemerge/usr/local/bin;

# libtarget file
rm -f /usr/local/lib/libtarget.so;
rm -f /usr/lib/libtarget.so;
cp -f /root/replace-file/libtarget.so /usr/local/lib/; 
ln -s /usr/local/lib/libtarget.so /usr/lib/;

rm -rf /root/release/release-image/release-service/host/vemerge/usr/local/lib/;
mkdir -p /root/release/release-image/release-service/host/vemerge/usr/local/lib;
rm -rf /root/release/release-image/release-service/host/vemerge/usr/lib/;
mkdir -p /root/release/release-image/release-service/host/vemerge/usr/lib;

rm -rf /root/release/release-image/release-service/manager/vemerge/usr/local/lib/;
mkdir -p /root/release/release-image/release-service/manager/vemerge/usr/local/lib;
rm -rf /root/release/release-image/release-service/manager/vemerge/usr/lib/;
mkdir -p /root/release/release-image/release-service/manager/vemerge/usr/lib;

rm -rf /root/release/release-image/release-service/storage/vemerge/usr/local/lib/;
mkdir -p /root/release/release-image/release-service/storage/vemerge/usr/local/lib;
rm -rf /root/release/release-image/release-service/storage/vemerge/usr/lib/;
mkdir -p /root/release/release-image/release-service/storage/vemerge/usr/lib;

cp -f /root/replace-file/libtarget.so /root/release/release-image/release-service/host/vemerge/usr/local/lib;
ln -s /usr/local/lib/libtarget.so /root/release/release-image/release-service/host/vemerge/usr/lib/;

cp -f /root/replace-file/libtarget.so /root/release/release-image/release-service/manager/vemerge/usr/local/lib;
ln -s /usr/local/lib/libtarget.so /root/release/release-image/release-service/manager/vemerge/usr/lib/;

cp -f /root/replace-file/libtarget.so /root/release/release-image/release-service/storage/vemerge/usr/local/lib;
ln -s /usr/local/lib/libtarget.so /root/release/release-image/release-service/storage/vemerge/usr/lib/;

# costor
cp /root/develop/Costor/bin/costor /root/release/release-image/release-service/host/vemerge/usr/local/bin/
cp /root/develop/Costor/bin/costor /root/release/release-image/release-service/storage/vemerge/usr/local/bin/
cp /root/develop/Costor/bin/costor /root/release/release-image/release-service/manager/vemerge/usr/local/bin/

# host
cd /root/release/release-image/release-service/host/vemerge/usr/local/bin
cp /root/develop/converger/bin/conver ./
cp /root/develop/vagent/bin/vagent ./
cp /root/develop/common/conf/vespace.conf /root/release/release-image/release-service/host/vemerge/var/lib/vespace/vespace.conf

# manager
cd /root/release/release-image/release-service/manager/vemerge/usr/local/bin
cp /root/develop/vagent/bin/vagent ./
cp /root/develop/xlauncher/bin/server ./manager 
cp /root/develop/common/conf/vespace.conf /root/release/release-image/release-service/manager/vemerge/var/lib/vespace/vespace.conf
cp /root/develop/common/conf/error.conf  /root/release/release-image/release-service/manager/vemerge/usr/local/bin/conf/error.conf
cp /root/develop/xlauncher/src/server/conf/app.conf /root/release/release-image/release-service/manager/vemerge/usr/local/bin/conf/

# /dist 
rm -fr /root/release/release-image/release-service/manager/vemerge/etc/nginx/dist
cp -fr /root/develop/xviewer/dist /root/release/release-image/release-service/manager/vemerge/etc/nginx/dist

# storage
cd /root/release/release-image/release-service/storage/vemerge/usr/local/bin
cp /root/develop/vagent/bin/vagent ./
cp /root/develop/common/conf/vespace.conf /root/release/release-image/release-service/storage/vemerge/var/lib/vespace/vespace.conf

# strategy 
cd /root/release/release-image/release-service/strategy/vemerge/usr/local/bin
cp /root/develop/vagent/bin/vagent ./
cp /root/develop/strategy/bin/cosrv ./
cp /root/develop/common/conf/vespace.conf /root/release/release-image/release-service/strategy/vemerge/var/lib/vespace/vespace.conf

# xedge
cd /root/release/release-image/release-service/network/xedge/usr/local/bin
cp /root/develop/xedge/bin/xedge ./

# check version
#/root/release/release-image/release-service/host/vemerge/usr/local/bin/conver -v
#/root/release/release-image/release-service/host/vemerge/usr/local/bin/costor -v
#/root/release/release-image/release-service/host/vemerge/usr/local/bin/vagent -v

#md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/manager
#/root/release/release-image/release-service/manager/vemerge/usr/local/bin/vagent -v

#/root/release/release-image/release-service/storage/vemerge/usr/local/bin/costor -v
#/root/release/release-image/release-service/storage/vemerge/usr/local/bin/vagent -v

#/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/cosrv -v
#/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/vagent -v

#/root/release/release-image/release-service/network/xedge/usr/local/bin/xedge -v


# after copy data, return the exec script path by record in variable 'EXEC_SCRIPT_PATH'
cd $EXEC_SCRIPT_PATH;

# database file catalog
DB_FILE_1="/database"
DB_FILE_2="/function/database"
DB_FILE_FULL="`pwd`$DB_FILE_1"

# database file name initial
VERSION_DB="version.db"

# create new db depend catalog for all data
mkdir -p $DB_FILE_FULL;

# rm old version.db
rm -f $DB_FILE_FULL/$VERSION_DB;

# version value to $DB_FILE_FULL/$VERSION_DB
# create new db file
echo "**********************release version value**********************" >> $DB_FILE_FULL/$VERSION_DB;

/root/release/release-image/release-service/host/vemerge/usr/local/bin/conver -v >> $DB_FILE_FULL/$VERSION_DB
/root/release/release-image/release-service/host/vemerge/usr/local/bin/costor -v >> $DB_FILE_FULL/$VERSION_DB
/root/release/release-image/release-service/host/vemerge/usr/local/bin/vagent -v >> $DB_FILE_FULL/$VERSION_DB

echo -n "manager md5 value:  ">> $DB_FILE_FULL/$VERSION_DB
md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/manager >> $DB_FILE_FULL/$VERSION_DB
/root/release/release-image/release-service/manager/vemerge/usr/local/bin/costor -v >> $DB_FILE_FULL/$VERSION_DB
/root/release/release-image/release-service/manager/vemerge/usr/local/bin/vagent -v >> $DB_FILE_FULL/$VERSION_DB

/root/release/release-image/release-service/storage/vemerge/usr/local/bin/costor -v >> $DB_FILE_FULL/$VERSION_DB
/root/release/release-image/release-service/storage/vemerge/usr/local/bin/vagent -v >> $DB_FILE_FULL/$VERSION_DB

/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/cosrv -v >> $DB_FILE_FULL/$VERSION_DB
/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/vagent -v >> $DB_FILE_FULL/$VERSION_DB

/root/release/release-image/release-service/network/xedge/usr/local/bin/xedge -v >> $DB_FILE_FULL/$VERSION_DB

echo " " >> $DB_FILE_FULL/$VERSION_DB

# tips status to the screen
echo " "
echo "status ok... "
echo " "


