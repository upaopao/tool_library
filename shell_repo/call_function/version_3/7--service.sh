#!/bin/bash

# build date:  2018-01-18 09:00
# modify date: 2018-02-27 17:50
# time format: date "+%Y-%m-%d %H:%M"
# dependent function: 8-replaceFunc.sh 

#EXEC_FILE="function/test.sh"
EXEC_FILE="function/8-replaceFunc.sh"
IP_TYPE_A="192.168.16."
IP_TYPE_B="192.168.17."
IP_TYPE_C="192.168."
FILE_TYPE_A="binary"
FILE_TYPE_B="directory"
DB_FILE="function/dbfile/data.db"
DB_CATALOG="/root/function/dbfile"
DB_IP="/tmp/ip.data"

# create new db depend catalog for all data
mkdir -p $DB_CATALOG;

# menu
echo "   "
echo "—————————————————————————————————————————————————————————————————————————"
echo "file name:     costor  [ example:        costor conf...                 ]"
echo "file type:     1 2     [ 1=binary-file   2=directory                    ]"
echo "net  segment:  1 2     [ 1=192.168.16.x  2=192.168.17.x  3=192.168.x.x  ]"
echo "host count:    1 2     [ example:        1 2 3 4 5...                   ]"
echo "ip   address:  43      [ example:        43 44 45...                    ]" 
echo "------------------------------------------------------------------------]"
echo "Tips1:[ net segment=3,input the ipaddr=x.x , 1 or 2 input the ipaddr=x  ]"
echo "Tips2:[ src file path = /root/replace-file                              ]"
echo "—————————————————————————————————————————————————————————————————————————"

# input variable
read -p "file name: "                          file_name
read -p "file type(1/2,default=1): "           file_type
read -p "net  segment(1/2/3,default=1): "      file_network
read -p "host count: "                         host_count

# initial the default value , when the value is nil
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
rm -f ./$DB_FILE
rm -f ./$DB_IP

# set local ip address to save current_ip_addr
ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}' >> ./$DB_FILE

# network segment 1 options
if [ $file_network -eq 1 ]; then
	
	# save file_name eg:costor
	echo $file_name >> ./$DB_FILE
	
	# save file_type eg:binary
	if [ $file_type -eq 1 ]; then
		echo $FILE_TYPE_A >> ./$DB_FILE
	elif [ $file_type -eq 2 ]; then
		echo $FILE_TYPE_B >> ./$DB_FILE
	fi

	# save host_count eg:3
	echo $host_count >> ./$DB_FILE

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_A >> ./$DB_FILE
			echo $file_ip >> ./$DB_FILE
		done
fi

# network segment 2 options
if [ $file_network -eq 2 ]; then
	
	# save file_name eg:costor
	echo $file_name >> ./$DB_FILE
	
	# save file_type eg:binary
	if [ $file_type -eq 1 ]; then
		echo $FILE_TYPE_A >> ./$DB_FILE
	elif [ $file_type -eq 2 ]; then
		echo $FILE_TYPE_B >> ./$DB_FILE
	fi

	# save host_count eg:3
	echo $host_count >> ./$DB_FILE

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_B >> ./$DB_FILE
			echo $file_ip >> ./$DB_FILE
		done
fi

# network segment 3 options
if [ $file_network -eq 3 ]; then
	
	# save file_name eg:costor
	echo $file_name >> ./$DB_FILE
	
	# save file_type eg:binary
	if [ $file_type -eq 1 ]; then
		echo $FILE_TYPE_A >> ./$DB_FILE
	elif [ $file_type -eq 2 ]; then
		echo $FILE_TYPE_B >> ./$DB_FILE
	fi

	# save host_count eg:3
	echo $host_count >> ./$DB_FILE

	# save ip_address eg:192.168.19.43 | 192.168.23.43 | 192.168.x.x
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_C >> ./$DB_FILE
			echo $file_ip >> ./$DB_FILE
		done
fi

# exec function
./$EXEC_FILE

# clean local db file
rm -rf $DB_IP

echo " "
echo " "
echo "status ok"
echo " "


