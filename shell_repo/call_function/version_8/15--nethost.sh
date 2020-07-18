#!/bin/bash

# build date:  2018-03-08 10:45
# modify date: 2018-03-23 17:45
# time format: date "+%Y-%m-%d %H:%M"
# dependent function: 16-nhostFunc.sh 

#EXEC_FILE="function/test_func.sh"
EXEC_FILE="function/16-nhostFunc.sh"
IP_TYPE_A="192.168.16."
IP_TYPE_B="192.168.17."
IP_TYPE_C="192.168."

# database file catalog
DB_FILE_1="/database"
DB_FILE_2="/function/database"
DB_FILE_FULL="`pwd`$DB_FILE_2"

# database file name initial                                                                                                                                                                                                                                              
NETHOST_DB="nethost.db"
NETHOST_RUNNING_PATH="/tmp/nethost_running_path.db"
VNC_INFO="vnc_info.db"

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
echo "Tips2:[ Function Description: Lookup the network host VNC information.  ]"
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
rm -f $DB_FILE_FULL/$NETHOST_DB
rm -f $DB_FILE_FULL/$VNC_INFO

# set local ip address to save current_ip_addr
ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}' >> $DB_FILE_FULL/$NETHOST_DB

# network segment 1 options
if [ $file_network -eq 1 ]; then
	
	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$NETHOST_DB

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_A >> $DB_FILE_FULL/$NETHOST_DB
			echo $file_ip >> $DB_FILE_FULL/$NETHOST_DB
		done
fi

# network segment 2 options
if [ $file_network -eq 2 ]; then
	
	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$NETHOST_DB

	# save ip_address eg:192.168.16.43
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_B >> $DB_FILE_FULL/$NETHOST_DB
			echo $file_ip >> $DB_FILE_FULL/$NETHOST_DB
		done
fi

# network segment 3 options
if [ $file_network -eq 3 ]; then
	
	# save host_count eg:3
	echo $host_count >> $DB_FILE_FULL/$NETHOST_DB

	# save ip_address eg:192.168.19.43 | 192.168.23.43 | 192.168.x.x
	for((i=1;i<=$host_count;i=$i+1))
		do
			read -p "ip addr $i: " file_ip
			echo -n $IP_TYPE_C >> $DB_FILE_FULL/$NETHOST_DB
			echo $file_ip >> $DB_FILE_FULL/$NETHOST_DB
		done
fi

# keep the exec script path to file path : 'NETHOST_RUNNING_PATH'
pwd > $NETHOST_RUNNING_PATH;

# exec function
./$EXEC_FILE


# get the network virtual host's vnc port number and the 

# get vnc_*.db file count,eg: vnc_1.db
vncnum=`ls -alF /tmp/vnc_*.db | wc -l`

# get real data to the vnc_info.db: host_info
for((i=1;i<=$vncnum;i++))
do
	# if the vnc_port filed is null. continue next cycle
	vnc_running_number=`cat /tmp/vnc_$i.db | awk {print'$4'}`
	if test -z $vnc_running_number
	then
		continue	
	fi

	# echo operate to save the real vnc data to the file
	cat /tmp/vnc_$i.db | grep 'host' >> $DB_FILE_FULL/$VNC_INFO;

	# delete the ': :',   eg: 'vnc_port: :4' ==> 'vnc_port 4'
	sed -i 's/:\ :/\ /g' /tmp/vnc_$i.db

	# deal with the vnc port,  eg: 4 ==> 04 | 11 ==> 11
	old_num=`cat /tmp/vnc_$i.db | grep 'port' | awk {print'$2'}`
	vncline=`cat -n /tmp/vnc_$i.db | grep 'port' | awk {print'$1'}`

	if [ $old_num -lt 10 ];then
		# sed the line data, eg: vncline=2 vncline=3,modify the line 2's data
		sed -i ''$vncline' s/'"$old_num"'/'"\ 0$old_num"'/' /tmp/vnc_$i.db
	fi
	
	# echo operate to save the vnc_port data to the file
	echo -n "vnc_port: 59" >> $DB_FILE_FULL/$VNC_INFO;
	cat /tmp/vnc_$i.db | grep 'vnc_port' | awk {print'$2'} >> $DB_FILE_FULL/$VNC_INFO;

done

# set variable to storage vnc data
vnc_physic_ip=`cat $DB_FILE_FULL/$VNC_INFO | grep 'NET*' | awk {print'$2'}`
vnc_running_id=`cat $DB_FILE_FULL/$VNC_INFO | grep 'NET*' | awk {print'$4'}`
vnc_running_name=`cat $DB_FILE_FULL/$VNC_INFO | grep 'NET*' | awk {print'$5'}`
vnc_running_status=`cat $DB_FILE_FULL/$VNC_INFO | grep 'NET*' | awk {print'$6'}`
vnc_running_port=`cat $DB_FILE_FULL/$VNC_INFO | grep 'vnc_port' | awk {print'$2'}`

# echo vnc data to screen
echo " "
echo "——————————————————————————————————————————————————————————————————"
echo "vnc_physic_ip:            $vnc_physic_ip"
echo "vnc_running_port:         $vnc_running_port"
echo "vnc_running_id:           $vnc_running_id"
echo "vnc_running_name:         $vnc_running_name" 
echo "vnc_running_status:       $vnc_running_status"

# clean local db file
rm -rf $NETHOST_RUNNING_PATH
rm -rf /tmp/*.db

# tips status to the screen
echo " "
echo " "
echo "status ok..."
echo " "


