#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-03-16 11:10
# time format: date "+%Y-%m-%d %H:%M"

# database file catalog
DB_FILE_1="/database"
DB_FILE_2="/function/database"
DB_FILE_FULL="`pwd`$DB_FILE_1"

# database file name initial
GIT_DB="git.db"
TMP_DB="tmp.db"

# create new db depend catalog for all data
mkdir -p $DB_FILE_FULL;

# rm old git.db file
rm -f $DB_FILE_FULL/$GIT_DB;

# touch new file
touch $DB_FILE_FULL/$GIT_DB;
touch $DB_FILE_FULL/$TMP_DB;

echo "**********************git log**********************" >> $DB_FILE_FULL/$GIT_DB;

echo -n "common: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/common;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "xedge: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/xedge;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "converger: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/converger;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "costor: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/Costor;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "strategy: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/strategy;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "vagent: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/vagent;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "xlauncher: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/xlauncher;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

echo -n "xviewer: " >> $DB_FILE_FULL/$GIT_DB;
cd /root/develop/xviewer;
git log > $DB_FILE_FULL/$TMP_DB; 
cat $DB_FILE_FULL/$TMP_DB | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo -n "	" >> $DB_FILE_FULL/$GIT_DB;
cat $DB_FILE_FULL/$TMP_DB | grep Date | head -n 1 >> $DB_FILE_FULL/$GIT_DB;
echo " " >> $DB_FILE_FULL/$GIT_DB;

# rm tmp.db
rm -f $DB_FILE_FULL/$TMP_DB

# tips status to the screen
echo " "
echo "status ok..."
echo " "


