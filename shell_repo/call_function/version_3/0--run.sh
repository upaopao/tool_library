#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 17:50
# time format: date "+%Y-%m-%d %H:%M"

# db_file catalog
DB_FILE="/root/function/dbfile"

# function scripts catalog
FUNC_CATALOG="/root/function"

# create new db depend catalog for all data
mkdir -p $DB_FILE;

# rm old time stamp file
rm -f $DB_FILE/runtime.db;
rm -f $DB_FILE/report.db;

# rm old db file
rm -f $DB_FILE/remote.db
rm -f $DB_FILE/version.db
rm -f $DB_FILE/git.db

# new time stamp
echo "***************操作时间总计***************" >> $DB_FILE/runtime.db;
echo -n "编译/拷贝开始: " >> $DB_FILE/runtime.db;
date "+%H:%M:%S" >> $DB_FILE/runtime.db;

# operating
cd $FUNC_CATALOG;
./1-buildall.sh;./2-commit.sh;./3-getfile.sh;./4-releaseall.sh;./5-valuecheck.sh;

# Keep the screen prompts
./5-valuecheck.sh > $DB_FILE/report.db;

echo -n "编译/拷贝结束: " >> $DB_FILE/runtime.db;
date "+%H:%M:%S" >> $DB_FILE/runtime.db;


