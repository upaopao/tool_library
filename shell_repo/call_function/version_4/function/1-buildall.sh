#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 19:40
# time format: date "+%Y-%m-%d %H:%M"

# common
echo "git pull commmom start..."
cd /root/develop/common
git checkout .
git checkout develop
git pull
echo "git pull commmom end..."

# xedge
cd /root/develop/xedge
git checkout .
git checkout develop
git pull
source init.sh
make rebuild

# build converger
cd /root/develop/converger
git checkout .
git checkout develop
git pull 
source init.sh
make rebuild

# build strategy
cd /root/develop/strategy
git checkout .
git checkout develop
git pull 
source init.sh
make rebuild

# build costor
cd /root/develop/Costor
git checkout .
git checkout develop
git pull
source init.sh
mkdir bin
rm costor
rm ./bin/costor
make version
go build -v -tags notcmu costor
cp costor ./bin/costor

# build vagent
cd /root/develop/vagent 
git checkout .
git checkout develop
git pull 
source init.sh
make rebuild

# build xlauncher
cd /root/develop/xlauncher
git checkout .
git checkout develop
git pull
cd /root/develop/xlauncher 
source init.sh 
make rebuild

# build xviewer-dist
cd /root/develop/xviewer
git checkout .
git checkout develop
git pull 
npm run build

# build hci-manager
#cd /root/develop/hci-manager
#git checkout .
#git checkout develop
#git pull 
#cd /root/develop/hci-manager/backend
#source init.sh
#make rebuild

# build hci-manager-dist
#cd /root/develop/hci-manager/front
#npm run build

echo " "
echo "status ok..."
echo " "


