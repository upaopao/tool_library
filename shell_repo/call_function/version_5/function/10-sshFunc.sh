#!/usr/bin/expect -f

# build date:  2018-01-30 14:10
# modify date: 2018-03-01 17:00
# time format: date "+%Y-%m-%d %H:%M"

# user name and passwd
set user_yourun              yourun 
set passwd_yourun            yourun
set user_root                root
set passwd_root              root

# current script exec path depend file initial
set SSH_RUNNING_PATH         "/tmp/ssh_running_path.db"
set DB_FILE_SWAP             [ exec cat $SSH_RUNNING_PATH ]

# database file catalog
set DB_FILE_1                "/database"
set DB_FILE_2                "/function/database"
#set DB_FILE_FULL             "`pwd`$DB_FILE_FULL/$SSH_DB_1"
set DB_FILE_FULL             "$DB_FILE_SWAP$DB_FILE_2"

# database file name initial                                                                                                                                                                                                                                              
set SSH_DB                   "ssh.db"

# set variable from file $DB_FILE_FULL/$SSH_DB
set IP_COUNT  [ exec cat $DB_FILE_FULL/$SSH_DB | tail -n +1 | head -n 1 ]

# in address in the file $DB_FILE_FULL/$SSH_DB start line is 5
set ip_line 2

# set timeout value
set timeout 1

# external environment: main bash environment
spawn bash
expect "*#"

# main function  
for {set i 1} {$i <= $IP_COUNT} {incr i} {
	
	# get ip_addr from $DB_FILE_FULL/$SSH_DB,ip_line default value is 2
	# incr ip_line means $ip_line++
	set IP_ADDR [ exec cat $DB_FILE_FULL/$SSH_DB | tail -n +$ip_line | head -n 1 ]
	incr ip_line

	# 1. login remote host, use $user user_yourun.
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

	# 2. modify the root passwd
		send "sudo passwd\r"
		expect "#"
		send "$passwd_yourun\r"
		expect "#"
		send "$passwd_root\r"
		expect "#"
		send "$passwd_root\r"
		expect "#"
																																					
	# 3. switch to root
		send "su\r"
		expect "#"
		send "$passwd_root\r"
		expect "#"
		
	# 4. modify /etc/ssh/sshd_config
		send "sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config -i\r"
		expect "#"
     	
	# 5. service sshd restart
	    send "service sshd restart\r"
		expect "#"	
}

# clean remote db file

# exit the remote host
send "exit\r"
expect "*#"


