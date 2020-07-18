#!/bin/bash                                                                                                                       

# build date:  2018-03-14 10:37
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# set the initial path,when the script exec to the end,restore the initial 'path'
ENV_PATH=`pwd`

# get the function scripts's directory
FIND_FUNCTION_CATALOG=`find -name 1-buildall.sh | awk 'BEGIN{FS="/"}{print $(NF-1)}'`

###
# main function start,use endless loop
while :
	do

# go to the env_path
cd $ENV_PATH;

# database file catalog
#DB_FILE_2="/function/database/monitor"
DB_FILE_1="/database/monitor"
DB_FILE_2="/$FIND_FUNCTION_CATALOG/database"
DB_FILE_FULL="`pwd`$DB_FILE_1"

# create new db depend catalog for all data
mkdir -p $DB_FILE_FULL;

# define db file
GREP_ORI_EDITOR_DB="1_aori_editor.db"
GREP_NEW_EDITOR_DB="1_bnew_editor.db"

GREP_ORI_FROMFILE_DB="2_aori_fromfile.db"
GREP_NEW_FROMFILE_DB="2_bnew_fromfile.db"

GREP_ORI_FILE_DB="3_a_orifile.db"
GREP_NEW_FILE_DB="3_b_newfile.db"
GREP_FILE_BUFFER_DB="grepbuffer_3c.db"

MD5_ORI_FILE_DB="4_a_orimd5.db"
MD5_NEW_FILE_DB="4_b_newmd5.db"

MD5_ORI_BUFFER_DB="orimd5buffer_4c.db"
MD5_NEW_BUFFER_DB="newmd5buffer_4c.db"

###
# step-01 data accumulation
ps -aux | grep 'vim' > $DB_FILE_FULL/$GREP_ORI_EDITOR_DB
cat $DB_FILE_FULL/$GREP_ORI_EDITOR_DB | grep 'vim ' > $DB_FILE_FULL/$GREP_ORI_FROMFILE_DB
cat $DB_FILE_FULL/$GREP_ORI_FROMFILE_DB | awk {print'$12'} > $DB_FILE_FULL/$GREP_FILE_BUFFER_DB

# file.sh count
FILE_COUNT=`wc -l $DB_FILE_FULL/$GREP_FILE_BUFFER_DB | awk {print'$1'}`

# add/insert line number to file
NUMBER_ORI_BUFFER_DB="number_ori_buffer.db"
sed -n "=" $DB_FILE_FULL/$GREP_FILE_BUFFER_DB > $DB_FILE_FULL/$NUMBER_ORI_BUFFER_DB
paste $DB_FILE_FULL/$NUMBER_ORI_BUFFER_DB $DB_FILE_FULL/$GREP_FILE_BUFFER_DB > $DB_FILE_FULL/$GREP_ORI_FILE_DB

# catalog ori initial. initial the status. 
CATALOG_CURRENT=`pwd`

# ori funciton to get md5 value
for ((i=1;$i<=$FILE_COUNT;i=$i+1))
	do
		# get editing file's name
		EDIT_FILE_NAME=`cat $DB_FILE_FULL/$GREP_ORI_FILE_DB | grep $i | awk {print'$2'}`
	
		# use find program to find the edit-file real-path,the 'real-path' include the file's name
		# find operate 1,if not found ,change the catalog 
		REAL_PATH=`find $CATALOG_CURRENT -name $EDIT_FILE_NAME`
		if test -z $REAL_PATH
		then
			cd ../
			CATALOG_CURRENT=`pwd`
		fi
		
		# find operate 2,if the previous step is not found,exec this step
		# if the previous step is found success,exec this step will get the same result with the previous step.
		REAL_PATH=`find $CATALOG_CURRENT -name $EDIT_FILE_NAME`
		if test -z $REAL_PATH
		then
			echo "Tips: find file failed!..."
		fi
		
		# get edit file path
		#EDIT_PATH=`pwd`

		# get edit file's md5 values, must used the $NUMBER_ORI_DB to insert the line-number to the md5_new_file_db.
		md5sum $REAL_PATH >> $DB_FILE_FULL/$MD5_ORI_BUFFER_DB
		paste $DB_FILE_FULL/$NUMBER_ORI_BUFFER_DB $DB_FILE_FULL/$MD5_ORI_BUFFER_DB > $DB_FILE_FULL/$MD5_ORI_FILE_DB
	done

###
# set scan time to oversee the edit file status,default value is 1s,the test used by value of 15s.
sleep 1s
#sleep 15s

###
# step-02 data accumulation,define the edit-over file's data info
ps -aux | grep 'vim' > $DB_FILE_FULL/$GREP_NEW_EDITOR_DB
cat $DB_FILE_FULL/$GREP_NEW_EDITOR_DB | grep 'vim ' > $DB_FILE_FULL/$GREP_NEW_FROMFILE_DB
cat $DB_FILE_FULL/$GREP_NEW_FROMFILE_DB | awk {print'$12'} > $DB_FILE_FULL/$GREP_FILE_BUFFER_DB

# add/insert line number to file
NUMBER_NEW_BUFFER_DB="number_new_buffer.db"
sed -n "=" $DB_FILE_FULL/$GREP_FILE_BUFFER_DB > $DB_FILE_FULL/$NUMBER_NEW_BUFFER_DB
paste $DB_FILE_FULL/$NUMBER_NEW_BUFFER_DB $DB_FILE_FULL/$GREP_FILE_BUFFER_DB > $DB_FILE_FULL/$GREP_NEW_FILE_DB

# catalog new initial. restore the the initial status.
CATALOG_CURRENT=$ENV_PATH

# new funciton to get md5 value
for ((i=1;$i<=$FILE_COUNT;i=$i+1))
	do
		# according to the order,get the old and new file name
		EDIT_FILE_ORI=`cat $DB_FILE_FULL/$GREP_ORI_FILE_DB | grep $i | awk {print'$2'}`
		EDIT_FILE_NEW=`cat $DB_FILE_FULL/$GREP_NEW_FILE_DB | grep $i | awk {print'$2'}`
		#echo "edit_ori=$EDIT_FILE_ORI"
		#echo "edit_new=$EDIT_FILE_NEW"
	
		# if file edit status is equal,continue to operate the next step
		if [ "$EDIT_FILE_ORI" == "$EDIT_FILE_NEW" ];then
			continue;
		fi

		#if test -z $EDIT_FILE_NEW
		#then

			# use find program to find the edit-file real-path,the 'real-path' include the file's name
			# find operate 1,if not found ,change the catalog 
			REAL_PATH=`find $CATALOG_CURRENT -name $EDIT_FILE_ORI`
			if test -z $REAL_PATH
			then
				cd ../
				CATALOG_CURRENT=`pwd`
			fi
			
			# find operate 2,if the previous step is not found,exec this step
			# if the previous step is found success,exec this step will get the same result with the previous step.
			REAL_PATH=`find $CATALOG_CURRENT -name $EDIT_FILE_ORI`
			if test -z $REAL_PATH
			then
				echo "Tips: find file failed!..."
			fi

			# get new file md5,must used the $NUMBER_ORI_DB to insert the line-number to the md5_new_file_db.
			md5sum $REAL_PATH >> $DB_FILE_FULL/$MD5_NEW_BUFFER_DB
			paste $DB_FILE_FULL/$NUMBER_ORI_BUFFER_DB $DB_FILE_FULL/$MD5_NEW_BUFFER_DB > $DB_FILE_FULL/$MD5_NEW_FILE_DB
			
			# check the ori-md5_value and the new-md5_value
			CHECK_MD5_ORI=`cat $DB_FILE_FULL/$MD5_ORI_FILE_DB | grep $EDIT_FILE_ORI | awk {print'$2'}` 
			CHECK_MD5_NEW=`cat $DB_FILE_FULL/$MD5_NEW_FILE_DB | grep $EDIT_FILE_ORI | awk {print'$2'}`
			#echo "md5_ori=$CHECK_MD5_ORI"
			#echo "md5_new=$CHECK_MD5_NEW"
			
			# if the file's md5 value is not equal, use sed to modify file's 'modify-date'
			if [ "$CHECK_MD5_ORI" != "$CHECK_MD5_NEW" ];then
			
				# use sed binary-program to modify the file's 'modify-date'
				new_time=`date "+%Y-%m-%d %H:%M"`
				#echo "test ok"

				# get current file 's modify date and time,the 'MODIFY_DATA' include file's path and the name.
				MODIFY_DATA=`cat $DB_FILE_FULL/$MD5_ORI_FILE_DB | grep $EDIT_FILE_ORI | awk {print'$3'}`
				CURRENT_TIME=`cat $MODIFY_DATA | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
			
				# get current file 's modify date and modify time to two varaible
				current_date_value=`cat $MODIFY_DATA | grep 'modify date' | awk {print'$4'} | head -n 1`
				current_time_value=`cat $MODIFY_DATA | grep 'modify date' | awk {print'$5'} | head -n 1`
				#echo "current_date_value=$current_date_value"
				#echo "current_time_value=$current_time_value"

				# current_date_value is null,use default time value: '1970-01-01 00:00'
				if test -z $current_date_value
				then
					CURRENT_TIME_DEFAULT=" 1970-01-01 00:00"	
					swap_data=`cat $MODIFY_DATA | grep 'modify date' | head -n 1`
					sed -i 's/'"$swap_data"'/'"# modify date:$CURRENT_TIME_DEFAULT"'/' `pwd`/$MODIFY_DATA -i	
					CURRENT_TIME=`cat $MODIFY_DATA | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
					current_time_value=`cat $MODIFY_DATA | grep 'modify date' | awk {print'$5'} | head -n 1`
				fi

				# current_time_value is null,use default time value: '1970-01-01 00:00'
				if test -z $current_time_value
				then
					CURRENT_TIME_DEFAULT=" 1970-01-01 00:00"	
					swap_data=`cat $MODIFY_DATA | grep 'modify date' | head -n 1`
					sed -i 's/'"$swap_data"'/'"# modify date:$CURRENT_TIME_DEFAULT"'/' `pwd`/$MODIFY_DATA -i	
					CURRENT_TIME=`cat $MODIFY_DATA | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
				fi

				#echo "$CATALOG_CURRENT/$EDIT_FILE_ORI CURRENT_TIME: $CURRENT_TIME"	
				sed -i 's/'"$CURRENT_TIME"'/'"$new_time"'/' $MODIFY_DATA -i

				# use touch operate to update file all times,update to the new modify times.
				touch $MODIFY_DATA
			fi
		#fi
	done

###
# delete the current(old) db file
cd $ENV_PATH;
#rm -rf ./*.out
rm -rf $DB_FILE_FULL/*.db

# main function end,enter the next cycle.
done


