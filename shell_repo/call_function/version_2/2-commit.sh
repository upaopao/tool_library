#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-26 16:00
# time format: date "+%Y-%m-%d %H:%M"

# rm old git.db file
rm -f /root/git.db;

# touch new file
touch /root/git.db;
touch /root/tmp.db;

echo "**********************git log**********************" >> /root/git.db;

echo -n "common: " >> /root/git.db;
cd /root/develop/common;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "xedge: " >> /root/git.db;
cd /root/develop/xedge;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "converger: " >> /root/git.db;
cd /root/develop/converger;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "costor: " >> /root/git.db;
cd /root/develop/Costor;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "strategy: " >> /root/git.db;
cd /root/develop/strategy;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "vagent: " >> /root/git.db;
cd /root/develop/vagent;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "xlauncher: " >> /root/git.db;
cd /root/develop/xlauncher;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

echo -n "xviewer: " >> /root/git.db;
cd /root/develop/xviewer;
git log > /root/tmp.db; 
cat /root/tmp.db | head -n 1 >> /root/git.db;
echo -n "	" >> /root/git.db;
cat /root/tmp.db | grep Date | head -n 1 >> /root/git.db;
echo " " >> /root/git.db;

# rm tmp.db
rm -f /root/tmp.db

