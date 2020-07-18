#!/usr/bin/expect -f 

# build date:  2018-01-13 10:00
# modify date: 2018-02-27 17:50
# time format: date "+%Y-%m-%d %H:%M"

# src:14.64 dst:14.250
set src_host 192.168.14.64
set src_passwd root

set dst_host 192.168.14.250
set dst_passwd 123456

set src_costor_path /root/develop/Costor/bin/costor
set dst_costor_path /home/vespace_release5.4/costor/costor

set src_libtarget_path /root/replace-file
set dst_libtarget_path /home/vespace_release5.4/costor/libtarget.so

set src_target_path_host /root/release/release-image/release-service/host/vemerge/usr/local/bin
set src_target_path_manager /root/release/release-image/release-service/manager/vemerge/usr/local/bin
set dst_target_path /home/vespace_release5.3/costor/target*

#set src_etcd_path_strategy /root/release/release-image/release-service/strategy/vemerge/usr/local/bin
#set src_etcd_path_manager /root/release/release-image/release-service/manager/vemerge/usr/local/bin
#set src_etcd_single_path /root/replace-file

# db_file path /root/function/dbfile
set file_name        "getfile.sh"
set dst_md5_path     /root/remote.db
set local_md5_path   /root/function/dbfile/remote.db
set time_db          /root/function/dbfile/time.db
set DB_FILE          /root/function/dbfile
set success          "获取文件成功,请继续操作！"

set timeout 1 

# delete src's old file
spawn bash
expect "*#"

# create new db depend catalog for all data
send "mkdir -p $DB_FILE\r"
expect "*#"

send "rm -f $time_db\r"
expect "*#"
send "echo -n \"start: \" >> $time_db\r"
expect "*#"
send "date \"+%H:%M:%S\" >> $time_db\r"
expect "*#"

send "rm -f $local_md5_path\r"
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

# login remote
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

#scp target to manager
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
send "echo \"**********************remote md5 value**********************\" >> $dst_md5_path\r"
expect "*#"
send "echo \"IP:   $dst_host\" >> $dst_md5_path\r"
expect "*#"
send "echo -n \"date: \" >> $dst_md5_path\r"
expect "*#"
send "date \"+%Y-%m-%d %H:%M\" >> $dst_md5_path\r"
expect "*#"
send "echo \"  \" >> $dst_md5_path\r"
expect "*#"

send "md5sum $dst_libtarget_path >> $dst_md5_path\r"
expect "*#"
send "md5sum $dst_costor_path >> $dst_md5_path\r"
expect "*#"
send "md5sum $dst_target_path >> $dst_md5_path\r"
expect "*#"

# scp remote.db to $local_md5_path
send "scp $dst_md5_path root@$src_host:$local_md5_path\r"
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

# remove the remote.db
send "rm $dst_md5_path\r"
expect "*#"

# exit the ssh remote host
send "logout\r"
expect "*#"

# local option
spawn bash
expect "*#"

# local option: cp etcd file
#send "cp -f $src_etcd_single_path/etcd* $src_etcd_path_strategy\r"
#expect "*#"
#send "cp -f $src_etcd_single_path/etcd* $src_etcd_path_manager\r"
#expect "*#"

# local option: Tips for success
send "echo \" \" >> $local_md5_path\r"
expect "*#"
send "echo \"——————————————————————————\" >> $local_md5_path\r"
expect "*#"
send "echo \"\($file_name\)脚本运行时间\" >> $local_md5_path\r"
expect "*#"
send "cat $time_db >> $local_md5_path\r"
expect "*#"
send "echo -n \"end:   \" >> $local_md5_path\r"
expect "*#"
send "date \"+%H:%M:%S\" >> $local_md5_path\r"
expect "*#"
send "echo \" \" >> $local_md5_path\r"
expect "*#"
send "rm -f $time_db\r"
expect "*#"
send "echo \"$success\" >> /dev/null\r"
expect "*#"

send "exit\r"
expect "*#"


