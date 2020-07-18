#!/bin/bash

# build date:  2018-01-30 14:10
# modify date: 2018-03-23 17:45
# time format: date "+%Y-%m-%d %H:%M"
# dependent function: 10-sshFunc.sh 

#EXEC_FILE="function/test_func.sh"
#EXEC_FILE="function/11-unsshFunc.sh"
EXEC_FILE="function/10-sshFunc.sh"
IP_TYPE_A="192.168.16."
IP_TYPE_B="192.168.17."
IP_TYPE_C="192.168."

# database file catalog
DB_FILE_1="/database"
DB_FILE_2="/function/database"
DB_FILE_FULL="`pwd`$DB_FILE_2"

# database file name initial                                                                                                                                                                                                                                              
SSH_DB="ssh.db"
SSH_RUNNING_PATH="/tmp/ssh_running_path.db"

# create new db depend catalog for all data
mkdir -p $DB_FILE_FULL;

# menu
echo "   "
echo "—————————————————————————————————————————————————————————————————————————"
echo "net  segment:  1 2     [ 1=192.168.16.x  2=192.168.17.x  3=192.168.x.x  ]"
echo "host count:    1 2     [ example:        1 2 3 4 5...                   ]"
echo "ip   address:  43      [ example:        43  44  17.45...               ]" 
echo "------------------------------------------------------------------------]"
echo "Tips1:[ net segment=3,input the ipaddr=x.x , 1 or 2 input the ipaddr=x  ]"
echo "Tips2:[ Function Description: open ssh features for root.               ]"
echo "—————————————————————————————————————————————————————————————————————————"

# input variable
read -p "net  segment(1/2/3,default=1): "      file_network
read -p "host count: "                         host_count

# file_network default value initial
if test -z $file_network
then
    file_network=1
fi

# clean old file ./data.db
rm -f $DB_FILE_FULL/$SSH_DB

# network segment 1 options
if [ $file_network -eq 1 ]; then
	
	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$SSH_DB

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_A >> $DB_FILE_FULL/$SSH_DB
			echo $file_ip >> $DB_FILE_FULL/$SSH_DB
		done
fi

# network segment 2 options
if [ $file_network -eq 2 ]; then
	
	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$SSH_DB

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_B >> $DB_FILE_FULL/$SSH_DB
			echo $file_ip >> $DB_FILE_FULL/$SSH_DB
		done
fi

# network segment 3 options
if [ $file_network -eq 3 ]; then
	
	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$SSH_DB

	# save ip_address eg:192.168.19.43 | 192.168.23.43 | 192.168.x.x
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_C >> $DB_FILE_FULL/$SSH_DB
			echo $file_ip >> $DB_FILE_FULL/$SSH_DB
		done
fi

# keep the exec script path to file path : 'SSH_RUNNING_PATH'
pwd > $SSH_RUNNING_PATH;

# exec function
./$EXEC_FILE

# clean local db file
rm -rf $SSH_RUNNING_PATH

# tips status to the screen
echo " "
echo " "
echo "status ok..."
echo " "


