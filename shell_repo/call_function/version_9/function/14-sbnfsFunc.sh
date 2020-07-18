#!/usr/bin/expect -f

# build date:  2018-03-07 10:15 
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# user name and passwd
set user_yourun              yourun 
set passwd_yourun            yourun
set user_root                root
set passwd_root              root

# replace file path
set replace_file_path        "/root/replace-file"
set apt_path                 "/etc/apt"
set dns_path                 "/etc"

# replace file's name
set apt_list                 "sources.list"
set dns_file                 "resolv.conf"

# current script exec path depend file initial
set SAMBANFS_RUNNING_PATH    "/tmp/sambanfs_running_path.db"
set DB_FILE_SWAP             [ exec cat $SAMBANFS_RUNNING_PATH ]

# get the function scripts's directory
set FIND_FUNCTION_CATALOG    [ exec find -name 1-buildall.sh | awk "BEGIN{FS=\"/\"}{print \$(NF-1)}" ]

# database file catalog
#set DB_FILE_2                "/function/database"
#set DB_FILE_FULL             "`pwd`$DB_FILE_FULL/$SAMBANFS_DB_1"
set DB_FILE_1                "/database"
set DB_FILE_2                "/$FIND_FUNCTION_CATALOG/database"
set DB_FILE_FULL             "$DB_FILE_SWAP$DB_FILE_2"

# database file name initial                                                                                                                                                                                                                                              
set SAMBANFS_DB              "sambanfs.db"
set DB_IP                    "/tmp/nfsip.data"

# set variable from file $DB_FILE_FULL/$SAMBANFS_DB
set EXEC_FILE_ADDR           [ exec cat  $DB_FILE_FULL/$SAMBANFS_DB | tail -n +1 | head -n 1 ]
set IP_COUNT                 [ exec cat $DB_FILE_FULL/$SAMBANFS_DB | tail -n +2 | head -n 1 ]

# in address in the file $DB_FILE_FULL/$SAMBANFS_DB start line is 3
set ip_line 3

# set timeout value
set timeout 1

# external environment: main bash environment
spawn bash
expect "*#"

# main function  
for {set i 1} {$i <= $IP_COUNT} {incr i} {
	
	# get ip_addr from $DB_FILE_FULL/$SAMBANFS_DB,ip_line default value is 3
	# incr ip_line means $ip_line++
	set IP_ADDR [ exec cat $DB_FILE_FULL/$SAMBANFS_DB | tail -n +$ip_line | head -n 1 ]
	incr ip_line

	# ping the $IP_ADDR,update the route table.
	set timeout 5
	send "ping -c 5 $IP_ADDR\r"
	expect "#"

	### 1. login remote host, Ensure root user status.

	# set timeout=3,Make sure you enter the password 3 times
	set timeout 3
	#set timeout 4
	
	# login remote host, use $user user_root.
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
	expect "#"

	# reset timeout==1 ,improve execution speed
	set timeout 1
	
	# scp ip_address file to local host,use file /nfsip.data to set variable LOGIN_IP
	# 1 scp nfsip.data files from $IP_ADDR
	# 2 scp nfsip.data files from local_host
	# set variable only read local_file's data
	send "ip addr \| grep \'state UP\' -A2 \| tail -n1 \| awk \'\{print \$2\}\' \| awk -F\"/\" \'\{print \$1\}\' > $DB_IP\r"
	expect "#"
	send "scp $DB_IP $user_root@$EXEC_FILE_ADDR:/tmp\r"
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
	expect "#"

	# set variable LOGIN_IP 
	set LOGIN_IP [ exec cat $DB_IP | tail -n +1 | head -n 1 ]
	send "echo $LOGIN_IP\r"
	expect "#"

	# second: By ip address to determine the login status, decide whether you need to login through yourun users
	if { $LOGIN_IP !=$IP_ADDR } {

		# use yourun to login remote host			
		send "ssh $user_yourun@$IP_ADDR\r"
		expect {
			"*yes/no*" {
	        	send "yes\r"
	        	exp_continue
	    	}
	    	"*assword*" {
	        	send "$passwd_yourun\r"
				exp_continue
			}
		}
		expect "#"

		# modify the root passwd
		send "sudo passwd\r"
		expect "#"
		send "$passwd_yourun\r"
		expect "#"
		send "$passwd_root\r"
		expect "#"
		send "$passwd_root\r"
		expect "#"

		# switch to root
		send "su\r"
		expect "#"
		send "$passwd_root\r"
		expect "#"
		
		# modify /etc/ssh/sshd_config
		send "sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config -i\r"
		expect "#"
     	
		# service sshd restart
	    send "service sshd restart\r"
		expect "#"	
	}

	### 2. Processing apt get option

	# apt-get install service samba and nfs

	# delete the old sources.list and resolv.conf files.
	send "rm -rf $apt_path/$apt_list*\r"
	expect "#"
	send "rm -rf $dns_path/$dns_file\r"
	expect "#"
	send "sync;sync;\r"
	expect "#"

	# scp the new sources.list file
	send "scp $user_root@$EXEC_FILE_ADDR:$replace_file_path/$apt_list $apt_path/\r"
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
	expect "#"
		
	# scp the new resolv.conf file
	send "scp $user_root@$EXEC_FILE_ADDR:$replace_file_path/$dns_file $dns_path/\r"
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
	expect "#"
		
	# operate the update and apt install command.
	set timeout 70
	send "apt update\r"
	expect "#"
	#set timeout 70
	send "apt-get install -y nfs-kernel-server samba libaio-dev sysstat ssh python fio smartmontools ntp\r"
	expect "#"
	#set timeout 70
	send "apt -y install nfs-common cifs-utils\r"
	expect "#"

	# restore the timeout value to '1', improve the next step's operate exec speed.
	set timeout 1
		
	# restart the services.
	send "/etc/init.d/samba start\r"
	expect "#"
	send "/etc/init.d/nfs-kernel-server start\r"
	expect "#"
}

# clean remote db file
send "rm -rf $DB_IP\r"
expect "*#"

# exit the remote host
send "exit\r"
expect "*#"


