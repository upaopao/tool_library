#!/bin/bash

# build date:  2018-01-18 09:00
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"
# dependent function: 8-replaFunc.sh 

# get the function scripts's directory
FIND_FUNCTION_CATALOG=`find -name 1-buildall.sh | awk 'BEGIN{FS="/"}{print $(NF-1)}'`

#EXEC_FILE="function/test_func.sh"
#EXEC_FILE="function/8-replaFunc.sh"
#EXEC_FILE="$FIND_FUNCTION_CATALOG/test_func.sh"
EXEC_FILE="$FIND_FUNCTION_CATALOG/8-replaFunc.sh"
IP_TYPE_A="192.168.16."
IP_TYPE_B="192.168.17."
IP_TYPE_C="192.168."
FILE_TYPE_A="binary"
FILE_TYPE_B="directory"
FILE_TYPE_C="profile"

# database file catalog
#DB_FILE_2="/function/database"
DB_FILE_1="/database"
DB_FILE_2="/$FIND_FUNCTION_CATALOG/database"
DB_FILE_FULL="`pwd`$DB_FILE_2"

# database file name initial                                                                                                                                                                                                                                              
DATA_DB="data.db"
DB_IP="/tmp/ip.data"
SRV_RUNNING_PATH="/tmp/srv_running_path.db"
REPLACE_FILE_CATALOG="/root/replace-file"

# create new db depend catalog for all data
mkdir -p $DB_FILE_FULL;
mkdir -p $REPLACE_FILE_CATALOG;

# menu
echo "   "
echo "—————————————————————————————————————————————————————————————————————————"
echo "file name:     costor  [ example:        costor app.conf                ]"
echo "srv  name:     nginx   [ example:        nginx manager                  ]"
echo "file type:     1 2     [ 1=binary-file   2=directory     3=profile      ]"
echo "file path:     /usr    [ example:        /usr/local                     ]"
echo "net  segment:  1 2     [ 1=192.168.16.x  2=192.168.17.x  3=192.168.x.x  ]"
echo "host count:    1 2     [ example:        1 2 3 4 5...                   ]"
echo "ip   address:  43      [ example:        43  44  17.45...               ]" 
echo "------------------------------------------------------------------------]"
echo "Tips1:[ net segment=3,input the ipaddr=x.x , 1 or 2 input the ipaddr=x  ]"
echo "Tips2:[ src file path = /root/replace-file                              ]"
echo "Tips3:[ file path = '/usr/local/bin',must input the file's full path    ]"
echo "Tips4:[ service name='' means srv_name=file_name,'-' means not service  ]"
echo "Tips5:[ app.conf/error.conf/vespace.conf/dist/swagger have default path ]"
echo "Tips6:[ app.conf/error.conf/vespace.conf/dist have initial service name ]"
echo "—————————————————————————————————————————————————————————————————————————"

# input variable
read -p "file name: "                                        file_name
read -p "srv  name(default=file_name,'-'=null service): "    srv_name
read -p "file type(1/2/3,default=1): "                       file_type
read -p "file path(default=/usr/local/bin): "                file_path
read -p "net  segment(1/2/3,default=1): "                    file_network
read -p "host count: "                                       host_count

# initial the default value,when the value is nil
# srv_name default value initial
if test -z $srv_name
then
	srv_name=$file_name
fi

# file_path default value initial
if test -z $file_path
then
	file_path="/usr/local/bin"
fi

# file_type default value initial
if test -z $file_type 
then
	file_type=1
fi

# file_network default value initial
if test -z $file_network
then
	file_network=1
fi

# clean old file ./data.db
rm -f $DB_FILE_FULL/$DATA_DB
rm -f ./$DB_IP

# set local ip address to save current_ip_addr
ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}' >> $DB_FILE_FULL/$DATA_DB

# network segment 1 options
if [ $file_network -eq 1 ]; then
	
	# save file_name eg:costor
	echo $file_name >> $DB_FILE_FULL/$DATA_DB
	
	# save srv_name eg:nginx
	echo $srv_name >> $DB_FILE_FULL/$DATA_DB
	
	# save file_type eg:binary
	if [ $file_type -eq 1 ]; then
		echo $FILE_TYPE_A >> $DB_FILE_FULL/$DATA_DB
	elif [ $file_type -eq 2 ]; then
		echo $FILE_TYPE_B >> $DB_FILE_FULL/$DATA_DB
	elif [ $file_type -eq 3 ]; then
		echo $FILE_TYPE_C >> $DB_FILE_FULL/$DATA_DB
	fi
	
	# save file_path eg:/usr/local/bin
	echo $file_path >> $DB_FILE_FULL/$DATA_DB

	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$DATA_DB

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_A >> $DB_FILE_FULL/$DATA_DB
			echo $file_ip >> $DB_FILE_FULL/$DATA_DB
		done
fi

# network segment 2 options
if [ $file_network -eq 2 ]; then
	
	# save file_name eg:costor
	echo $file_name >> $DB_FILE_FULL/$DATA_DB
	
	# save srv_name eg:nginx
	echo $srv_name >> $DB_FILE_FULL/$DATA_DB
	
	# save file_type eg:binary
	if [ $file_type -eq 1 ]; then
		echo $FILE_TYPE_A >> $DB_FILE_FULL/$DATA_DB
	elif [ $file_type -eq 2 ]; then
		echo $FILE_TYPE_B >> $DB_FILE_FULL/$DATA_DB
	elif [ $file_type -eq 3 ]; then
		echo $FILE_TYPE_C >> $DB_FILE_FULL/$DATA_DB
	fi
	
	# save file_path eg:/usr/local/bin
	echo $file_path >> $DB_FILE_FULL/$DATA_DB

	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$DATA_DB

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_B >> $DB_FILE_FULL/$DATA_DB
			echo $file_ip >> $DB_FILE_FULL/$DATA_DB
		done
fi

# network segment 3 options
if [ $file_network -eq 3 ]; then
	
	# save file_name eg:costor
	echo $file_name >> $DB_FILE_FULL/$DATA_DB
	
	# save file_type eg:binary
	if [ $file_type -eq 1 ]; then
		echo $FILE_TYPE_A >> $DB_FILE_FULL/$DATA_DB
	elif [ $file_type -eq 2 ]; then
		echo $FILE_TYPE_B >> $DB_FILE_FULL/$DATA_DB
	elif [ $file_type -eq 3 ]; then
		echo $FILE_TYPE_C >> $DB_FILE_FULL/$DATA_DB
	fi

	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$DATA_DB

	# save ip_address eg:192.168.19.43 | 192.168.23.43 | 192.168.x.x
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_C >> $DB_FILE_FULL/$DATA_DB
			echo $file_ip >> $DB_FILE_FULL/$DATA_DB
		done
fi

# keep the exec script path to file path: 'SRV_RUNNING_PATH'
pwd > $SRV_RUNNING_PATH;

# exec function
./$EXEC_FILE

# clean local db file
rm -rf $DB_IP
rm -rf $SRV_RUNNING_PATH

# tips status to the screen
echo " "
echo " "
echo "status ok..."
echo " "


