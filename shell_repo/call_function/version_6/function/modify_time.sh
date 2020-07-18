#!/bin/bash

# build date:  2018-03-01 10:00
# modify date: 2018-03-05 20:30
# time format: date "+%Y-%m-%d %H:%M"

# define common data
LINE_A="———————————————————"
SUB_FUNC_COUNT=0
MAIN_FUNC_COUNT=0
SUM_COUNT=0

# tips a choose to user
echo " "
read -p "use the current time or enter a fixed time?(1/2,default=1) : "    time_choose

# time_choose is null, use default value
if test -z $time_choose
then
	time_choose=1
fi

# time_choose equal 1, use `date "+%Y-%m-%d %H:%M"`
if [ $time_choose -eq 1 ];then
	new_time=`date "+%Y-%m-%d %H:%M"`
fi

# time_choose equal 2, enter new time
if [ $time_choose -eq 2 ];then
	echo " "
	read -p "new time[ eg: 2018-18-18 18:18 ]: "                            new_time
fi

# Judge new_time format input is correct, define date_format and time_format 
new_date_format=`echo $new_time | awk {print'$1'}`
new_time_format=`echo $new_time | awk {print'$2'}`
#echo "new_date_format: $new_date_format"
#echo "new_time_format: $new_time_format"

# test -z new_date_format is null
if test -z $new_date_format
then
	echo " "
	echo "date format is error,please try again..."	
	echo " "
	exit -1
fi

# test -z new_time_format is null
if test -z $new_time_format
then
	echo " "
	echo "time format is error,please try again..."	
	echo " "
	exit -1
fi

# get main func file name
cd ../ >> /dev/null;
MAIN_FUNC_NAME=`ls -alF *.sh | awk {print'$9'}`

# echo all main function modify date's status info
for main_var in ${MAIN_FUNC_NAME[@]}
do
	# get current file 's modify date and time
	CURRENT_TIME=`cat $main_var | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
	
	# get current file 's modify date and modify time to two varaible
	current_date_value=`cat $main_var | grep 'modify date' | awk {print'$4'} | head -n 1`
	current_time_value=`cat $main_var | grep 'modify date' | awk {print'$5'} | head -n 1`
	#echo "current_date_value=$current_date_value"
	#echo "current_time_value=$current_time_value"
	
	# current_date_value is null,use default time value: '1970-01-01 00:00'
	if test -z $current_date_value
	then
		CURRENT_TIME_DEFAULT=" 1970-01-01 00:00"	
		swap_data=`cat $main_var | grep 'modify date' | head -n 1`
		sed -i 's/'"$swap_data"'/'"# modify date:$CURRENT_TIME_DEFAULT"'/' `pwd`/$main_var -i	
		CURRENT_TIME=`cat $main_var | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
		current_time_value=`cat $main_var | grep 'modify date' | awk {print'$5'} | head -n 1`
	fi
	
	# current_time_value is null,use default time value: '1970-01-01 00:00'
	if test -z $current_time_value
	then
		CURRENT_TIME_DEFAULT=" 1970-01-01 00:00"	
		swap_data=`cat $main_var | grep 'modify date' | head -n 1`
		sed -i 's/'"$swap_data"'/'"# modify date:$CURRENT_TIME_DEFAULT"'/' `pwd`/$main_var -i	
		CURRENT_TIME=`cat $main_var | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
	fi
	
	#echo "$main_var CURRENT_TIME: $CURRENT_TIME"	
	sed -i 's/'"$CURRENT_TIME"'/'"$new_time"'/' `pwd`/$main_var -i

	# use touch operate to update file all times
	touch $main_var

	# use 'main_func_count' and 'sum_count' to count the file numbers.
	let MAIN_FUNC_COUNT++
	let SUM_COUNT++
done

# get sub func file name,return return catalog: 'cd -;'
#cd ./function/;
cd - >> /dev/null;
SUB_FUNC_NAME=`ls -alF *.sh | awk {print'$9'}`

# echo all sub  function modify date's status info
for sub_var in ${SUB_FUNC_NAME[@]}
do
	# get current file 's modify date and time
	CURRENT_TIME=`cat $sub_var | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
	
	# get current file 's modify date and modify time to two varaible
	current_date_value=`cat $sub_var | grep 'modify date' | awk {print'$4'} | head -n 1`
	current_time_value=`cat $sub_var | grep 'modify date' | awk {print'$5'} | head -n 1`
	#echo "current_date_value=$current_date_value"
	#echo "current_time_value=$current_time_value"
	
	# current_date_value is null,use default time value: '1970-01-01 00:00'
	if test -z $current_date_value
	then
		CURRENT_TIME_DEFAULT=" 1970-01-01 00:00"	
		swap_data=`cat $sub_var | grep 'modify date' | head -n 1`
		sed -i 's/'"$swap_data"'/'"# modify date:$CURRENT_TIME_DEFAULT"'/' `pwd`/$sub_var -i	
		CURRENT_TIME=`cat $sub_var | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
		current_time_value=`cat $sub_var | grep 'modify date' | awk {print'$5'} | head -n 1`
	fi
	
	# current_time_value is null,use default time value: '1970-01-01 00:00'
	if test -z $current_time_value
	then
		CURRENT_TIME_DEFAULT=" 1970-01-01 00:00"	
		swap_data=`cat $sub_var | grep 'modify date' | head -n 1`
		sed -i 's/'"$swap_data"'/'"# modify date:$CURRENT_TIME_DEFAULT"'/' `pwd`/$sub_var -i	
		CURRENT_TIME=`cat $sub_var | grep 'modify date' | awk {print'$4,$5'} | head -n 1`
	fi
	
	#echo "$sub_var CURRENT_TIME: $CURRENT_TIME"	
	sed -i 's/'"$CURRENT_TIME"'/'"$new_time"'/' `pwd`/$sub_var -i
	
	# use touch operate to update file all times 
	touch $sub_var
	
	# use 'sub_func_count' and 'sum_count' to count the file numbers.
	let SUB_FUNC_COUNT++
	let SUM_COUNT++
done

# echo end line
echo " "
echo "$LINE_A"

# echo modify file count
echo "modify file count:"
echo "	main func file: $MAIN_FUNC_COUNT"
echo "	sub  func file: $SUB_FUNC_COUNT"
echo "	all  func file: $SUM_COUNT"

# delete sed operate temp file: sedxxxx
rm -f ../sed*

# sed command modify file
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config -i
#sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config -i

# tips status to the screen
echo " "
echo "status ok..."
echo " "


