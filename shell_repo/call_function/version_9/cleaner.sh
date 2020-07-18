#!/bin/bash                                                                                                                                                                                                                                                               

# build date:  2018-03-01 10:00
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# get the function scripts's directory
FIND_FUNCTION_CATALOG=`find -name 1-buildall.sh | awk 'BEGIN{FS="/"}{print $(NF-1)}'`

# database file catalog
#DB_FILE_2="/function/database"
DB_FILE_1="/database"
DB_FILE_2="/$FIND_FUNCTION_CATALOG/database"
DB_FILE_FULL="`pwd`$DB_FILE_2"

# catalog /tmp file path initial
TMP_FILE_CATALOG="/tmp"

# remove the database file catalog
echo " "
rm -rfv $DB_FILE_FULL 2> /dev/null;

# remove the /tmp file
rm -rfv $TMP_FILE_CATALOG/*.data
rm -rfv $TMP_FILE_CATALOG/*.db

# remove the nohup.out file,when the script 'file_monitor' was not running.
FILE_MONITOR=`ps -aux | grep file_monitor.sh | awk {print'$11'} | head -n 1`
if [ "$FILE_MONITOR" != "/bin/bash" ];then
	#rm -rfv ./function/nohup.out
	rm -rfv ./$FIND_FUNCTION_CATALOG/nohup.out
fi

# tips status to the screen
echo " "
echo "status ok..."
echo " "


