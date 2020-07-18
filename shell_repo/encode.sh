#!/bin/bash                                                                                                                       

# build  date: 2018-06-02 09:45
# modify date: 2018-06-05 11:13
# time format: date "+%Y-%m-%d %H:%M"
# author name: lovfer

# define the db data.
ENCODE_NAME_DB="encodeData.db"
ENCODE_PATH_DB="/tmp/encodingRecord"
ENCODE_FULL_DB="$ENCODE_PATH_DB/$ENCODE_NAME_DB"

# initial the base-enviroment.
rm -rf $ENCODE_PATH_DB > /dev/null;
mkdir -p $ENCODE_PATH_DB

# initial the project's catalog. 
if test -z $1
then
	BASE_PATH=`pwd`
elif [ "$1" == "." ];then	
	BASE_PATH=`pwd`
else
	cd $1 2> /dev/null;
	if [ $? -ne 0 ];then
		echo -e "\033[31m error: \033[0m param '$1' error"
		exit
	fi
	BASE_PATH=`pwd`;
fi

# initial the transcoding format.
if test -z $2
then
	TRANSCODING_FORMAT="utf8"
else
	if [[ "$2" != "utf8" ]] && [[ "$2" != "gb2312" ]];then
		echo -e "\033[31m error: \033[0m param '$2' error"
		exit
	fi
	TRANSCODING_FORMAT=$2;
fi

# after the all initial option,main funtion was start.
echo " "
echo -e "\033[32m *** \033[0m Project's BASE_PATH='$BASE_PATH'"

# Secondary confirmation. 
echo " "
read -p "Are you sure start the transcoding?(default [yes/y]): "   daemon_check

if [ "$daemon_check" == "" ];then
	daemon_check="yes"
fi

case $daemon_check in
yes | YES )
	echo " "
	echo -e "\033[32m *** \033[0m Start transcoding,please wait a moment..."
	;;
y | Y )
	echo " "
	echo -e "\033[32m *** \033[0m Start transcoding,please wait a moment..."
	;;
* )
	echo " "
	echo -e "\033[31m error: \033[0m Suspension of execution..."
	echo " "
	exit
	;;
esac

# Step-01: get the all file's name,and save the data to $ENCODE_FULL_DB.
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file="$1/$element"
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            echo $dir_or_file >> $ENCODE_FULL_DB;
        fi  
    done
}
# exec the function getdir().
base_dir=$BASE_PATH
getdir $base_dir

# Step-02: transcode the file's encoding format.
function transcoding(){
while read LINE
	do
		origin_file_name=$LINE
		utf8_check=`file $origin_file_name | grep 'UTF-8'`
		iso_check=`file $origin_file_name | grep 'ISO-'`
		if [ "$utf8_check" != "" ];then
			if [ $TRANSCODING_FORMAT == "utf8" ];then
				continue;
			else	
				iconv -f utf8 -t $TRANSCODING_FORMAT $origin_file_name -o $origin_file_name;
			fi	
		elif [ "$iso_check" != "" ];then
			if [ $TRANSCODING_FORMAT == "gb2312" ];then
				continue;
			else	
				iconv -f gb2312 -t $TRANSCODING_FORMAT $origin_file_name -o $origin_file_name;
			fi	
		else
			continue;
		fi	
	
	done  < $ENCODE_FULL_DB
}
# exec the function transcoding().
transcoding $ENCODE_FULL_DB

# tips status to the screen
echo " "
echo -e "\033[32m Success... \033[0m"
echo " "


