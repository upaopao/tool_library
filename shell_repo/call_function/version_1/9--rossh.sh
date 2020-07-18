#!/bin/bash

# build date:  2018-01-30 14:10
# modify date: 2018-01-30 16:00
# time format: date "+%Y-%m-%d %H:%M"
# dependent function: 10-rosshFunc.sh 

#EXEC_FILE="test.sh"
EXEC_FILE="10-rosshFunc.sh"
IP_TYPE_A="192.168.16."
IP_TYPE_B="192.168.17."
DB_FILE="remote.db"

# menu
echo "   "
echo "----------------------------------------------------------"
echo "network segment: 1 2    [ 1=192.168.16.x  2=192.168.17.x ]"
echo "host count: 1           [ example:  1 2 3 4 5...         ]"
echo "ip address: 43          [ example:  43 44 45...          ]" 
echo "----------------------------------------------------------"

# input variable
read -p "network segment(1/2,default=1): "   file_network
read -p "host count: "        host_count

# clean old file ./data.db
rm -f ./$DB_FILE

# network segment 1 options
if [ $file_network -eq 1 ]; then
	
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

# exec function
./$EXEC_FILE

# clean local db file
#rm -rf $DB_IP


