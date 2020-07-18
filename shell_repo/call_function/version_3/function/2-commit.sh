#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 17:50
# time format: date "+%Y-%m-%d %H:%M"

# db_file catalog
DB_FILE="/root/function/dbfile"

# create new db depend catalog for all data
mkdir -p $DB_FILE;

# rm old git.db file
rm -f $DB_FILE/git.db;

# touch new file
touch $DB_FILE/git.db;
touch $DB_FILE/tmp.db;

echo "**********************git log**********************" >> $DB_FILE/git.db;

echo -n "common: " >> $DB_FILE/git.db;
cd /root/develop/common;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "xedge: " >> $DB_FILE/git.db;
cd /root/develop/xedge;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "converger: " >> $DB_FILE/git.db;
cd /root/develop/converger;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "costor: " >> $DB_FILE/git.db;
cd /root/develop/Costor;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "strategy: " >> $DB_FILE/git.db;
cd /root/develop/strategy;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "vagent: " >> $DB_FILE/git.db;
cd /root/develop/vagent;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "xlauncher: " >> $DB_FILE/git.db;
cd /root/develop/xlauncher;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

echo -n "xviewer: " >> $DB_FILE/git.db;
cd /root/develop/xviewer;
git log > $DB_FILE/tmp.db; 
cat $DB_FILE/tmp.db | head -n 1 >> $DB_FILE/git.db;
echo -n "	" >> $DB_FILE/git.db;
cat $DB_FILE/tmp.db | grep Date | head -n 1 >> $DB_FILE/git.db;
echo " " >> $DB_FILE/git.db;

# rm tmp.db
rm -f $DB_FILE/tmp.db

echo " "
echo "status ok..."
echo " "


