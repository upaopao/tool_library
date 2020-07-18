# build date:  2018-01-13 10:00
# modify date: 2018-01-13 19:50
# time format: date "+%Y-%m-%d %H:%M"

cd /root/release/release-image
rm ubuntu1604-*.iso -rf
rm squashfs-root/ -rf

cd /root/release/release-image
git checkout ubuntu1604/install/filesystem.squashfs
./buildsquashfs.sh --unpack

# etcd file
rm -f /root/release/release-image/release-service/strategy/vemerge/usr/local/bin/etcd*;
rm -f /root/release/release-image/release-service/manager/vemerge/usr/local/bin/etcd*;
cp -f /root/single-file/etcd* /root/release/release-image/release-service/strategy/vemerge/usr/local/bin;
cp -f /root/single-file/etcd* /root/release/release-image/release-service/manager/vemerge/usr/local/bin;

# libtarget file
rm -f /usr/local/lib/libtarget.so;
rm -f /usr/lib/libtarget.so;
cp -f /root/single-file/libtarget.so /usr/local/lib/; 
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

cp -f /root/single-file/libtarget.so /root/release/release-image/release-service/host/vemerge/usr/local/lib;
ln -s /usr/local/lib/libtarget.so /root/release/release-image/release-service/host/vemerge/usr/lib/;

cp -f /root/single-file/libtarget.so /root/release/release-image/release-service/manager/vemerge/usr/local/lib;
ln -s /usr/local/lib/libtarget.so /root/release/release-image/release-service/manager/vemerge/usr/lib/;

cp -f /root/single-file/libtarget.so /root/release/release-image/release-service/storage/vemerge/usr/local/lib;
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

# check version
/root/release/release-image/release-service/host/vemerge/usr/local/bin/conver -v
/root/release/release-image/release-service/host/vemerge/usr/local/bin/costor -v
/root/release/release-image/release-service/host/vemerge/usr/local/bin/vagent -v

md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/manager
/root/release/release-image/release-service/manager/vemerge/usr/local/bin/vagent -v

/root/release/release-image/release-service/storage/vemerge/usr/local/bin/costor -v
/root/release/release-image/release-service/storage/vemerge/usr/local/bin/vagent -v

/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/cosrv -v
/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/vagent -v

# version value to /root/version.db
rm -f /root/version.db;
echo "**********************version value check**********************" >> /root/version.db;

/root/release/release-image/release-service/host/vemerge/usr/local/bin/conver -v >> /root/version.db
/root/release/release-image/release-service/host/vemerge/usr/local/bin/costor -v >> /root/version.db
/root/release/release-image/release-service/host/vemerge/usr/local/bin/vagent -v >> /root/version.db

md5sum /root/release/release-image/release-service/manager/vemerge/usr/local/bin/manager >> /root/version.db
/root/release/release-image/release-service/manager/vemerge/usr/local/bin/vagent -v >> /root/version.db

/root/release/release-image/release-service/storage/vemerge/usr/local/bin/costor -v >> /root/version.db
/root/release/release-image/release-service/storage/vemerge/usr/local/bin/vagent -v >> /root/version.db

/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/cosrv -v >> /root/version.db
/root/release/release-image/release-service/strategy/vemerge/usr/local/bin/vagent -v >> /root/version.db
echo " " >> /root/version.db

