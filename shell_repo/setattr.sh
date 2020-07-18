#!/bin/bash

# build date:  2018-03-16 11:45
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# initial common data
LINE_A="———————————————"
ENV_PATH=`pwd`
TMP_PATH=`pwd`
TMP_FILE="tmp_count.txt"
declare -i COUNT_MAIN=0
declare -i COUNT_SUB=0
declare -i COUNT_SUM=0

# input variable
echo " "
echo "setting mode( 1=set-dev , 2=list-attr 3=unset , 4=set-full )"
read -p "setting mode(default=1): "                    setting_mode

# setting_mode default value initial
if test -z $setting_mode
then
	setting_mode=1
fi

# set-dev attr mode
if [ $setting_mode -eq 1 ]; then
	# set main func attr mode
	cd $ENV_PATH;
	cd ../;
	#chattr +i ./0--run.sh
 	#chattr +i ./6--packiso.sh
	chattr +i ./13--sbnfs.sh
	chattr +i ./15--nethost.sh
  	chattr +i ./7--service.sh
  	chattr +i ./9--ssh.sh
  	chattr +i ./cleaner.sh
  	chattr +i ./*.md
  	#chattr +i ./编译部署文档(2018-03-16).md
  	#chattr +i ./脚本说明文档(2018-03-16).md
	
	# set sub func attr mode
	cd - >> /dev/null;
  	#chattr +i ./1-buildall.sh
  	#chattr +i ./3-getfile.sh
  	#chattr +i ./4-releaseall.sh
  	chattr +i ./10-sshFunc.sh
  	chattr +i ./11-unsshFunc.sh
  	chattr +i ./12-machine.sh
  	chattr +i ./14-sbnfsFunc.sh
  	chattr +i ./16-nhostFunc.sh
  	chattr +i ./2-commit_ori.sh
  	chattr +i ./2-commit.sh
  	chattr +i ./5-valuecheck.sh
  	chattr +i ./8-replaFunc.sh
  	chattr +i ./file_monitor.sh
  	chattr +i ./modify_time.sh
  	chattr +i ./setattr.sh
  	chattr +i ./status.sh
  	chattr +i ./test_func.sh
	
	# save the main func number
	cd $ENV_PATH;
	cd ../;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	ls -alF *.md | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_MAIN=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	
	# save the sub func number
	cd - >> /dev/null;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_SUM=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	COUNT_SUB=$COUNT_SUM-$COUNT_MAIN	

	# save the count number sum
	COUNT_SUM=$COUNT_MAIN+$COUNT_SUB;
fi

# list-attr mode
if [ $setting_mode -eq 2 ]; then
	cd $ENV_PATH;
	lsattr ../*.sh;lsattr ../*.md;lsattr *.sh;
	
	# save the main func number
	cd $ENV_PATH;
	cd ../;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	ls -alF *.md | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_MAIN=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	
	# save the sub func number
	cd - >> /dev/null;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_SUM=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	COUNT_SUB=$COUNT_SUM-$COUNT_MAIN	

	# save the count number sum
	COUNT_SUM=$COUNT_MAIN+$COUNT_SUB;
fi

# unset attr mode
if [ $setting_mode -eq 3 ]; then
	# set main func attr mode
	cd $ENV_PATH;
	cd ../;
	chattr -i ./0--run.sh
	chattr -i ./13--sbnfs.sh
	chattr -i ./15--nethost.sh
 	chattr -i ./6--packiso.sh
  	chattr -i ./7--service.sh
  	chattr -i ./9--ssh.sh
  	chattr -i ./cleaner.sh
  	chattr -i ./*.md
  	#chattr -i ./编译部署文档(2018-03-16).md
  	#chattr -i ./脚本说明文档(2018-03-16).md

	# set s-b func attr mode
	cd - >> /dev/null;
  	chattr -i ./10-sshFunc.sh
  	chattr -i ./11-unsshFunc.sh
  	chattr -i ./12-machine.sh
  	chattr -i ./14-sbnfsFunc.sh
  	chattr -i ./16-nhostFunc.sh
  	chattr -i ./1-buildall.sh
  	chattr -i ./2-commit_ori.sh
  	chattr -i ./2-commit.sh
  	chattr -i ./3-getfile.sh
  	chattr -i ./4-releaseall.sh
  	chattr -i ./5-valuecheck.sh
  	chattr -i ./8-replaFunc.sh
  	chattr -i ./file_monitor.sh
  	chattr -i ./modify_time.sh
  	chattr -i ./setattr.sh
  	chattr -i ./status.sh
  	chattr -i ./test_func.sh
	
	# save the main func number
	cd $ENV_PATH;
	cd ../;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	ls -alF *.md | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_MAIN=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	
	# save the sub func number
	cd - >> /dev/null;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_SUM=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	COUNT_SUB=$COUNT_SUM-$COUNT_MAIN	

	# save the count number sum
	COUNT_SUM=$COUNT_MAIN+$COUNT_SUB;
fi

# set-full attr mode
if [ $setting_mode -eq 4 ]; then
	# set main func attr mode
	cd $ENV_PATH;
	cd ../;
	chattr +i ./0--run.sh
	chattr +i ./13--sbnfs.sh
	chattr +i ./15--nethost.sh
 	chattr +i ./6--packiso.sh
  	chattr +i ./7--service.sh
  	chattr +i ./9--ssh.sh
  	chattr +i ./cleaner.sh
  	chattr +i ./*.md
  	#chattr +i ./编译部署文档(2018-03-16).md
  	#chattr +i ./脚本说明文档(2018-03-16).md

	# set sub func attr mode
	cd - >> /dev/null;
  	chattr +i ./10-sshFunc.sh
  	chattr +i ./11-unsshFunc.sh
  	chattr +i ./12-machine.sh
  	chattr +i ./14-sbnfsFunc.sh
  	chattr +i ./16-nhostFunc.sh
  	chattr +i ./1-buildall.sh
  	chattr +i ./2-commit_ori.sh
  	chattr +i ./2-commit.sh
  	chattr +i ./3-getfile.sh
  	chattr +i ./4-releaseall.sh
  	chattr +i ./5-valuecheck.sh
  	chattr +i ./8-replaFunc.sh
  	chattr +i ./file_monitor.sh
  	chattr +i ./modify_time.sh
  	chattr +i ./setattr.sh
  	chattr +i ./status.sh
  	chattr +i ./test_func.sh
	
	# save the main func number
	cd $ENV_PATH;
	cd ../;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	ls -alF *.md | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_MAIN=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	
	# save the sub func number
	cd - >> /dev/null;
	ls -alF *.sh | awk {print'$9'} >> $TMP_PATH/$TMP_FILE;
	COUNT_SUM=`wc -l $TMP_PATH/$TMP_FILE | awk \{print'$1'\}`
	COUNT_SUB=$COUNT_SUM-$COUNT_MAIN	

	# save the count number sum
	COUNT_SUM=$COUNT_MAIN+$COUNT_SUB;
fi

# echo tips line to the screen
echo " "
echo "$LINE_A"

# echo file count
echo "the file count:"
echo "	main func file: $COUNT_MAIN"
echo "	sub  func file: $COUNT_SUB"
echo "	all  func file: $COUNT_SUM"

# delete the $TMP_FILE
rm -f $TMP_PATH/$TMP_FILE;

# tips status to the screen
echo " "
echo " "
echo "status ok..."
echo " "


