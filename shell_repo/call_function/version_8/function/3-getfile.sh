#!/usr/bin/expect -f 

# build date:  2018-01-13 10:00
# modify date: 2018-03-23 17:45
# time format: date "+%Y-%m-%d %H:%M"

# dst:14.250 src:14.64
set dst_host                    192.168.14.250
set dst_passwd                  123456
set src_host                    192.168.14.64
set src_passwd                  root

set dst_costor_path             /home/vespace_release5.4/costor/costor
set src_costor_path             /root/develop/Costor/bin/costor

set dst_libtarget_path          /home/vespace_release5.4/costor/libtarget.so
set src_libtarget_path          /root/replace-file

set dst_target_path             /home/vespace_release5.3/costor/target*
set src_target_path_host        /root/release/release-image/release-service/host/vemerge/usr/local/bin
set src_target_path_manager     /root/release/release-image/release-service/manager/vemerge/usr/local/bin

#set src_etcd_path_strategy      /root/release/release-image/release-service/strategy/vemerge/usr/local/bin
#set src_etcd_path_manager       /root/release/release-image/release-service/manager/vemerge/usr/local/bin
#set src_etcd_single_path        /root/replace-file

# database file catalog
set DB_FILE_1                   "/database"
set DB_FILE_2                   "/function/database"
set DB_FILE_FULL                "`pwd`$DB_FILE_1"

# database file name initial
set TIME_DB                     "time.db"
set REMOTE_DB                   "remote.db"

# define local file save path and the remote file_md5 path for the scp option
set SCP_DATA_SWAP_PATH          "/tmp/function"
set remote_host_file_md5        "/root/$REMOTE_DB"

# other variable initial
set file_name                   "getfile.sh"
set success                     "Get the file successfully, Please continue..."

# set timeout 1/s
set timeout 1 

# create a new bash environment
spawn bash
expect "*#"

# create new db depend catalog for all data
send "mkdir -p $DB_FILE_FULL\r"
expect "*#"
send "mkdir -p $SCP_DATA_SWAP_PATH\r"
expect "*#"

# delete old database file and keep the time stamp to the file
send "rm -f $DB_FILE_FULL/$TIME_DB\r"
expect "*#"
send "echo -n \"start: \" >> $DB_FILE_FULL/$TIME_DB\r"
expect "*#"
send "date \"+%H:%M:%S\" >> $DB_FILE_FULL/$TIME_DB\r"
expect "*#"

send "rm -f $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "rm -f $src_costor_path\r"
expect "*#"
send "rm -f $src_target_path_host/target*\r"
expect "*#"
send "rm -f $src_target_path_manager/target*\r"
expect "*#"
#send "rm -f $src_etcd_path_strategy/etcd*\r"
#expect "*#"
#send "rm -f $src_etcd_path_manager/etcd*\r"
#expect "*#"
send "rm -f $src_libtarget_path/libtarget.so\r"
expect "*#"

# login remote host
spawn ssh root@$dst_host
expect {
	"*yes/no*" {
		send "yes\r"
		exp_continue
		}
	"*assword*" {
		send "$dst_passwd\r"
		exp_continue
		}
}
expect "*#"

# scp costor
send "scp $dst_costor_path root@$src_host:$src_costor_path\r"
expect {
	"*yes/no*" {
		send "yes\r"
		exp_continue
		}
	"*assword*" {
		send "$src_passwd\r"
		exp_continue
		}
}
expect "*#"

# scp libtarget.so
send "scp $dst_libtarget_path root@$src_host:$src_libtarget_path\r"
expect {
	"*yes/no*" {
		send "yes\r"
		exp_continue
		}
	"*assword*" {
		send "$src_passwd\r"
		exp_continue
		}
}
expect "*#"

# scp target to host
send "scp $dst_target_path root@$src_host:$src_target_path_host\r"
expect {
	"*yes/no*" {
		send "yes\r"
		exp_continue
		}
	"*assword*" {
		send "$src_passwd\r"
		exp_continue
		}
}
expect "*#"

# scp target to manager
send "scp $dst_target_path root@$src_host:$src_target_path_manager\r"
expect {
	"*yes/no*" {
		send "yes\r"
		exp_continue
		}
	"*assword*" {
		send "$src_passwd\r"
		exp_continue
		}
}
expect "*#"

# remote md5 value check
send "echo \"**********************remote md5 value**********************\" >> $remote_host_file_md5\r"
expect "*#"
send "echo \"IP:   $dst_host\" >> $remote_host_file_md5\r"
expect "*#"
send "echo -n \"date: \" >> $remote_host_file_md5\r"
expect "*#"
send "date \"+%Y-%m-%d %H:%M\" >> $remote_host_file_md5\r"
expect "*#"
send "echo \"  \" >> $remote_host_file_md5\r"
expect "*#"

send "md5sum $dst_libtarget_path >> $remote_host_file_md5\r"
expect "*#"
send "md5sum $dst_costor_path >> $remote_host_file_md5\r"
expect "*#"
send "md5sum $dst_target_path >> $remote_host_file_md5\r"
expect "*#"

# scp remote.db to $DB_FILE_FULL/$REMOTE_DB
send "scp $remote_host_file_md5 root@$src_host:$SCP_DATA_SWAP_PATH\r"
expect {
	"*yes/no*" {
		send "yes\r"
		exp_continue
		}
	"*assword*" {
		send "$src_passwd\r"
		exp_continue
		}
}
expect "*#"

# remove the remote host's remote.db file
send "rm $remote_host_file_md5\r"
expect "*#"

# exit the ssh remote host
send "logout\r"
expect "*#"

# create a new bash environment for local option
spawn bash
expect "*#"

# local option: cp etcd file
#send "cp -f $src_etcd_single_path/etcd* $src_etcd_path_strategy\r"
#expect "*#"
#send "cp -f $src_etcd_single_path/etcd* $src_etcd_path_manager\r"
#expect "*#"

# move the 'scp_data_swap_path' to the 'db_file_full path' /tmp/function/remote.db -> ./database/remote.db
send "mv $SCP_DATA_SWAP_PATH/$REMOTE_DB $DB_FILE_FULL\r"
expect "*#"

send "echo \" \" >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "echo \"—————————————————————\" >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "echo \"\($file_name\) runtime:\" >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "cat $DB_FILE_FULL/$TIME_DB >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "echo -n \"end:   \" >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "date \"+%H:%M:%S\" >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"
send "echo \" \" >> $DB_FILE_FULL/$REMOTE_DB\r"
expect "*#"

# rm temp db file and the depend catalog
send "rm -f $DB_FILE_FULL/$TIME_DB\r"
expect "*#"
send "rm -rf $SCP_DATA_SWAP_PATH\r"
expect "*#"

# tips success info to the screen
send "echo \"$success\" >> /dev/null\r"
expect "*#"

# quit the newly created bash
send "exit\r"
expect "*#"


