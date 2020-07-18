#!/usr/bin/expect -f

# build date:  2018-03-08 10:45
# modify date: 2018-03-16 11:10
# time format: date "+%Y-%m-%d %H:%M"

# user name and passwd
set user_yourun              yourun 
set passwd_yourun            yourun
set user_root                root
set passwd_root              root

# current script exec path depend file initial
set NETHOST_RUNNING_PATH     "/tmp/nethost_running_path.db"
set DB_FILE_SWAP             [ exec cat $NETHOST_RUNNING_PATH ]

# database file catalog
set DB_FILE_1                "/database"
set DB_FILE_2                "/function/database"
#set DB_FILE_FULL             "`pwd`$DB_FILE_FULL/$NETHOST_DB_1"
set DB_FILE_FULL             "$DB_FILE_SWAP$DB_FILE_2"

# database file name initial                                                                                                                                                                                                                                              
set NETHOST_DB               "nethost.db"
#set VNC_DB                   "/tmp/vnc_.db"

# set variable from file $DB_FILE_FULL/$NETHOST_DB
set EXEC_FILE_ADDR  [ exec cat $DB_FILE_FULL/$NETHOST_DB | tail -n +1 | head -n 1 ]
set IP_COUNT        [ exec cat $DB_FILE_FULL/$NETHOST_DB | tail -n +2 | head -n 1 ]

# in address in the file $DB_FILE_FULL/$NETHOST_DB start line is 5
set ip_line 3

# set timeout value
set timeout 1

# set vnc_run_id number default value
#set running_count 0

# external environment: main bash environment
spawn bash
expect "*#"

# main function  
for {set i 1} {$i <= $IP_COUNT} {incr i} {
	
	# get ip_addr from $DB_FILE_FULL/$NETHOST_DB,ip_line default value is 2
	# incr ip_line means $ip_line++
	set IP_ADDR [ exec cat $DB_FILE_FULL/$NETHOST_DB | tail -n +$ip_line | head -n 1 ]
	incr ip_line

	set VNC_DB         "/tmp/vnc_$i.db"
	set VNC_RUNID_DB   "/tmp/runid_vnc_$i.db"
	
	# 1. login remote host, use $user user_root.
		send "ssh $user_root@$IP_ADDR\r"
		expect {
			"*yes/no*" {
	        	send "yes\r"
	        	exp_continue
	    	}
	    	"*assword*" {
	        	send "$passwd_root\r"
				exp_continue
			}
		}

	# 2. get nethost info by virsh list
		# save physical host info,once create file use '>'
       	send "echo -n \"host: $IP_ADDR\" > $VNC_DB\r"
		expect "#"

		# save network virtual host info,twice create file use '>>'
		send "echo -n \"  vnc_info: \" >> $VNC_DB\r"
		expect "#"
		send "echo \"`virsh list | grep 'NET*'`\" >> $VNC_DB\r"
		expect "#"

		# save network virtual host running-id,once create file use '>'
		send "echo -n \"`virsh list | grep 'NET*' | awk \{print'\$1'\}`\" > $VNC_RUNID_DB\r"
		expect "#"

		# scp VNC_RUNID_DB file to the local host ,to next set variable run_id_show
		send "scp $VNC_RUNID_DB $user_root@$EXEC_FILE_ADDR:/tmp\r"
		expect {
			"*yes/no*" {
	        	send "yes\r"
	        	exp_continue
	    	}
	    	"*assword*" {
	      		send "$passwd_root\r"
				exp_continue
			}
		}

		# count the running_id file numbers,each add 1
		#incr running_count	
	
		# each operate,set run_id_show from vncrunid_$i.db
		set run_id_show [ exec cat $VNC_RUNID_DB | tail -n +1 | head -n 1 ]

		if { $run_id_show !="" } {
		# save network virtual host vnc port number,twice create file use '>>'
			send "echo -n \"vnc_port: \" >> $VNC_DB\r"
			expect "#"
			send "echo \"`virsh vncdisplay $run_id_show`\" >> $VNC_DB\r"
			expect "#"
		}

	# 3. scp $VNC_DB(/tmp/vnc_i.db) to exec_file_addr/tmp
		send "scp $VNC_DB $user_root@$EXEC_FILE_ADDR:/tmp\r"
		expect {
			"*yes/no*" {
	        	send "yes\r"
	        	exp_continue
	    	}
	    	"*assword*" {
	        	send "$passwd_root\r"
				exp_continue
			}
		}

	# 4. delete current ssh host /tmp/*.db
	#send "rm -rf $VNC_DB\r"
	#expect "#"
	#send "rm -rf $VNC_RUNID_DB"
	#expect "#"
	send "rm -rf /tmp/*.db\r"
	expect "#"

}

# clean remote db file

# exit the remote host
send "exit\r"
expect "*#"


