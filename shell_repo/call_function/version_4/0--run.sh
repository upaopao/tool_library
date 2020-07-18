#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 19:40
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
echo "***************Time statistics***************" >> $DB_FILE/runtime.db;
echo -n "compile/copy begin: " >> $DB_FILE/runtime.db;
date "+%H:%M:%S" >> $DB_FILE/runtime.db;

# operating
cd $FUNC_CATALOG;
./1-buildall.sh;./2-commit.sh;./3-getfile.sh;./4-releaseall.sh;./5-valuecheck.sh;

# Keep the screen prompts
./5-valuecheck.sh > $DB_FILE/report.db;

echo -n "compile/copy end: " >> $DB_FILE/runtime.db;
date "+%H:%M:%S" >> $DB_FILE/runtime.db;


