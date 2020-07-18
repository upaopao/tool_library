#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-01-15 08:57
# time format: date "+%Y-%m-%d %H:%M"

rm -f /root/runtime.db;

echo "***************脚本花费时间***************" >> /root/runtime.db;
echo -n "编译/拷贝开始: " >> /root/runtime.db;
date "+%H:%M:%S" >> /root/runtime.db;

./1-buildall.sh;./2-commit.sh;./3-getfile.sh;./4-releaseall.sh;./5-valuecheck.sh;

echo -n "编译/拷贝结束: " >> /root/runtime.db;
date "+%H:%M:%S" >> /root/runtime.db;


