# build date:  2018-01-13 10:00
# modify date: 2018-01-13 19:50
# time format: date "+%Y-%m-%d %H:%M"

# common
cd /root/develop/common
git checkout .
git checkout develop
git pull

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


