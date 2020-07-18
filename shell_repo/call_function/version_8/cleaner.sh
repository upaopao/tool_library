#!/bin/bash                                                                                                                                                                                                                                                               

# build date:  2018-03-01 10:00
# modify date: 2018-03-23 17:45
# time format: date "+%Y-%m-%d %H:%M"

# database file catalog
DB_FILE_1="/database"
DB_FILE_2="/function/database"
DB_FILE_FULL="`pwd`$DB_FILE_2"

# catalog /tmp file path initial
TMP_FILE_CATALOG="/tmp"

# remove the database file catalog
echo " "
rm -rfv $DB_FILE_FULL

# remove the /tmp file
rm -rfv $TMP_FILE_CATALOG/*.data
rm -rfv $TMP_FILE_CATALOG/*.db

# tips status to the screen
echo " "
echo "status ok..."
echo " "


