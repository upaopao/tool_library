#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-03-16 11:10
# time format: date "+%Y-%m-%d %H:%M"

# database file catalog
DB_FILE_1="/database"
DB_FILE_2="/function/database"
DB_FILE_FULL="`pwd`$DB_FILE_2"

# database file name initial
RUNTIME_DB="runtime.db"
REPORT_DB="report.db"
REMOTE_DB="remote.db"
VERSION_DB="version.db"
GIT_DB="git.db"

# function scripts catalog
FUNC_CATALOG="`pwd`/function"

# create new db depend catalog for all data
mkdir -p $DB_FILE_FULL;

# rm old time stamp file
rm -f $DB_FILE_FULL/$RUNTIME_DB;
rm -f $DB_FILE_FULL/$REPORT_DB;

# rm old db file
rm -f $DB_FILE_FULL/$REMOTE_DB
rm -f $DB_FILE_FULL/$VERSION_DB
rm -f $DB_FILE_FULL/$GIT_DB

# new time start stamp
echo "***************Time statistics***************" >> $DB_FILE_FULL/$RUNTIME_DB;
echo -n "compile/copy begin: " >> $DB_FILE_FULL/$RUNTIME_DB;
date "+%H:%M:%S" >> $DB_FILE_FULL/$RUNTIME_DB;

# change the directory and its variable values
cd $FUNC_CATALOG;
DB_FILE_FULL="`pwd`$DB_FILE_1"

# execute the call function
./1-buildall.sh;./2-commit.sh;./3-getfile.sh;./4-releaseall.sh;./5-valuecheck.sh;

# keep the screen prompts
./5-valuecheck.sh > $DB_FILE_FULL/$REPORT_DB;

# new time end stamp
echo -n "compile/copy end: " >> $DB_FILE_FULL/$RUNTIME_DB;
date "+%H:%M:%S" >> $DB_FILE_FULL/$RUNTIME_DB;


