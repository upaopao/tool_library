#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-26 16:00
# time format: date "+%Y-%m-%d %H:%M"

# rm old time stamp file
rm -rf /root/runtime.db;
rm -rf /root/report.db;

# rm old db file
rm -fv /root/remote.db
rm -fv /root/version.db
rm -fv /root/git.db

# new time stamp
echo "***************操作时间总计***************" >> /root/runtime.db;
echo -n "编译/拷贝开始: " >> /root/runtime.db;
date "+%H:%M:%S" >> /root/runtime.db;

# operating
./1-buildall.sh;./2-commit.sh;./3-getfile.sh;./4-releaseall.sh;./5-valuecheck.sh;

# Keep the screen prompts
./5-valuecheck.sh > /root/report.db;

echo -n "编译/拷贝结束: " >> /root/runtime.db;
date "+%H:%M:%S" >> /root/runtime.db;


