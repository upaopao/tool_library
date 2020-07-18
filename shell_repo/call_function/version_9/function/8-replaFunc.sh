#!/usr/bin/expect -f

# build date:  2018-01-18 09:00
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# user name and passwd
set user_yourun              yourun
set passwd_yourun            yourun
set user_root                root
set passwd_root              root

# src & dst file path
set binary_file_src_path     /root/replace-file

# fixed service's name
set service_manager          manager
set service_nginx            nginx

# current script exec path depend file initial
set SRV_RUNNING_PATH         "/tmp/srv_running_path.db" 
set DB_FILE_SWAP             [ exec cat $SRV_RUNNING_PATH ]

# get the function scripts's directory
set FIND_FUNCTION_CATALOG    [ exec find -name 1-buildall.sh | awk "BEGIN{FS=\"/\"}{print \$(NF-1)}" ]

# database file catalog
#set DB_FILE_2                "/function/database"
#set DB_FILE_FULL             "`pwd`$DB_FILE_1"
set DB_FILE_1                "/database"
set DB_FILE_2                "/$FIND_FUNCTION_CATALOG/database"
set DB_FILE_FULL             "$DB_FILE_SWAP$DB_FILE_2"

# database file name initial                                                                                                     
set DATA_DB                  "data.db"
set DB_IP                    "/tmp/ip.data"

# set variable from file $DB_FILE
set EXEC_FILE_ADDR [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +1 | head -n 1 ]
set FILE_NAME [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +2 | head -n 1 ]
set SRV_NAME  [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +3 | head -n 1 ]
set FILE_TYPE [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +4 | head -n 1 ]
set FILE_PATH [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +5 | head -n 1 ]
set IP_COUNT  [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +6 | head -n 1 ]
#set IP_ADDR_A [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +7 | head -n 1 ]

# in address in the file $DB_FILE start line is 7
set ip_line 7

# initial exec path,get the path value from file $DATA_DB(data.db)
set binary_file_exec_path   $FILE_PATH
set catalog_file_exec_path  $FILE_PATH

# external environment: main bash environment
spawn bash
expect "*#"

# main function
for {set i 1} {$i <= $IP_COUNT} {incr i} {
	
	# get ip_addr from $DB_FILE,ip_line default value is 5
	# incr ip_line means $ip_line++
	set IP_ADDR [ exec cat  $DB_FILE_FULL/$DATA_DB | tail -n +$ip_line | head -n 1 ]
	incr ip_line

	### 1. login remote host, Ensure root user status.

	# set timeout=3,Make sure you enter the password 3 times
	set timeout 3
	#set timeout 4

	# first: user root login host
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
	
	# scp ip_address file to local host,use file /ip.data to set variable LOGIN_IP
	# 1 scp ip.data files from $IP_ADDR
	# 2 scp ip.data files from local_host
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

	### 2. Processing services options

	# processing type binary
	if { $FILE_TYPE == "binary" || $FILE_TYPE == "profile" } {
	
		# 1.set the true file path
		if { $FILE_NAME == "app.conf" || $FILE_NAME == "error.conf"} {
			set binary_file_exec_path   "/usr/local/bin/conf"
		}

		if { $FILE_NAME == "vespace.conf" } {
			set binary_file_exec_path   "/var/lib/vespace"
		}
	
		# 2.cd the catalog to delete the old file and scp the new file to here.
		# cd /usr/local/bin
		# rm origin $FILE_NAME
		send "cd $binary_file_exec_path\r"
		expect "#"
		send "rm -fv bak-$FILE_NAME\r"
		expect "#"
		send "mv $FILE_NAME bak-$FILE_NAME\r"
		expect "#"
		#send "rm $FILE_NAME\r"
		#expect "#"

		# scp $FILE_NAME to .
		send "scp $user_root@$EXEC_FILE_ADDR:$binary_file_src_path/$FILE_NAME  .\r"
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
	
		# 3.restart the service	

		# srv_name = "-" means no service will restart.
		if { $SRV_NAME !="-" } {

			# restart service $FILE_NAME
			if { $FILE_NAME == "costor" } {
				# restart service costor*
				send "service costor-controller restart\r"
				expect "#"
				send "service costor-engine restart\r"
				expect "#"
			} elseif { $FILE_NAME == "app.conf" || $FILE_NAME == "error.conf" } {
				# restart service manager
				send "service $service_manager restart\r"
				expect "#"		
			} else {
				# restart service $srv_name
				send "service $SRV_NAME restart\r"
				expect "#"
			}
		}
	}

	### 3. processing type directory
	if { $FILE_TYPE == "directory" } {
	
		# 1.set the true file path
		if { $FILE_NAME == "dist" } {
			set catalog_file_exec_path   "/etc/nginx"
		}

		if { $FILE_NAME == "swagger" } {
			set catalog_file_exec_path   "/usr/local/bin"
		}

		# 2.cd the catalog to delete the old file and scp the new file to here.
	
		# cd /etc/nginx
		# rm -r origin $FILE_NAME
		send "cd $catalog_file_exec_path\r"
		expect "#"
		send "rm -rfv bak-$FILE_NAME\r"
		expect "#"
		send "mv $FILE_NAME bak-$FILE_NAME\r"
		expect "#"
		#send "rm -rfv $FILE_NAME\r"
		#expect "#"
		
		# scp $FILE_NAME to .
		send "scp -r $user_root@$EXEC_FILE_ADDR:$binary_file_src_path/$FILE_NAME .\r"
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

		# 3.restart the service	
		
		# srv_name = "-" means no service will restart.
		if { $SRV_NAME !="-" } {
		
			if { $FILE_NAME == "dist" } {
				# restart service nginx
				send "service $service_nginx restart\r"
				expect "#"		
			} elseif { $FILE_NAME == "swagger" } {	
				# restart service manager
				#send "service $service_manager restart\r"
				#expect "#"		
			} else {
				# restart service $srv_name
				send "service $SRV_NAME restart\r"
				expect "#"
			}
		}
	}

}

# clean remote db file
send "rm -rf $DB_IP\r"
expect "*#"

# exit the remote host
send "exit\r"
expect "*#"


