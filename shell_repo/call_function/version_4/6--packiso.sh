#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 19:40
# time format: date "+%Y-%m-%d %H:%M"

# db_file catalog
DB_FILE="/root/function/dbfile"

# create new db depend catalog for all data
mkdir -p $DB_FILE;

# *record the start time
echo -n "Image packaging begin: " >> $DB_FILE/runtime.db;
date "+%H:%M:%S" >> $DB_FILE/runtime.db;

# 1. Modify the configuration file
# set variable
VAR_APP_CONF=/root/release/release-image/release-service/manager/vemerge/usr/local/bin/conf/app.conf
VAR_WEBCONFIG=/root/release/release-image/release-service/manager/vemerge/etc/nginx/dist/static/js/webconfig.js

# modify /root/release/release-image/release-service/manager/vemerge/usr/local/bin/conf/app.conf
sed -i 's/runmode = dev/#runmode = dev/' $VAR_APP_CONF -i
sed -i 's/#runmode = pro/runmode = pro/' $VAR_APP_CONF -i
sed -i 's/logpath = ".\/logs\/manager.log"/logpath = "\/var\/log\/vespace\/manager.log"/' $VAR_APP_CONF -i
sed -i 's/EnableDocs = true/#EnableDocs = true/' $VAR_APP_CONF -i
sed -i 's/EnableAdmin = false/#EnableAdmin = false/' $VAR_APP_CONF -i
sed -i 's/AdminAddr = 127.0.0.1/#AdminAddr = 127.0.0.1/' $VAR_APP_CONF -i
sed -i 's/AdminPort = 10002/#AdminPort = 10002/' $VAR_APP_CONF -i
sed -i 's/ErrorDebug = true/ErrorDebug = false/' $VAR_APP_CONF -i

# modify /root/release/release-image/release-service/manager/vemerge/etc/nginx/dist/static/js/webconfig.js
sed -i 's/const ISDEV = true/const ISDEV = false/' $VAR_WEBCONFIG -i
sed -i 's/const ISDEV =true/const ISDEV = false/' $VAR_WEBCONFIG -i


# 2. Pack the release images
cd /root/release/release-image;

sync;sync;sync;
./buildsquashfs.sh --pack;

sync;sync;sync;
./buildiso.sh --pack;

cd /root/release/release-image;

# *record the end time
echo -n "Image packaging end: " >> $DB_FILE/runtime.db;
date "+%H:%M:%S" >> $DB_FILE/runtime.db;

echo " "
echo "status ok"
echo " "


