#!/bin/bash

# build date:  2018-09-20 16:40
# modify date: 2018-09-20 16:40
# time format: date "+%Y-%m-%d %H:%M"

#user info
USER=`id | awk -F"(" '{print $1}' | awk -F"=" '{print $2}'`

#check user
if [ $USER != 0 ];then
	echo " "
	echo -e "\033[31m [ Failed ]: \033[0m This operation requires root user to execute..."
	echo " "
	exit
fi

#destroy memory
echo 3 > /proc/sys/vm/drop_caches

#screen prompt
echo " "
echo -e "\033[32m [ Success ]: \033[0m Congratulations! destroy cache success...!"
echo " "

