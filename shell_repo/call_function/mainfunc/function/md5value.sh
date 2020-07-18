#!/bin/bash

# build date:  2018-03-27 09:15
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

# define the common data
LINE_A="————————————————————"
SUB_FUNC_COUNT=0
MAIN_FUNC_COUNT=0
SUM_COUNT=0

# initail the file count variable
COUNT_FILE_DB="/tmp/countfile.db"

# initial /mainfunc and /replace-file path
# according to $LINK_PATH's value is determine the $FUNC_PATH's value, the $FUNC_PATH represent the mainfunc's path
#FUNC_PATH="/root/mainfunc"
LINK_PATH=`pwd | awk 'BEGIN{FS="/"}{print $(NF-1)}'`
cd .. >> /dev/null;
FUNC_PATH="`pwd`"
REPLACE_PATH="/root/replace-file"

# restore to the initial path,the script($0) exec path.
cd - >> /dev/null;

# create dependent catalog for 'ln -s catalog'
mkdir -p $FUNC_PATH;
mkdir -p $REPLACE_PATH;

# set the initial path,when the script exec to the end,restore the initial 'path'
ENV_PATH=`pwd`

# go to the env_path
cd $ENV_PATH >> /dev/null;

# echo main func md5sum value
cd ../ >> /dev/null;
md5sum *.sh 2> /dev/null;
md5sum *.md 2> /dev/null;

# calculate the main_func numbers
MAIN_FUNC_NAME=`ls -alF *.sh | awk {print'$9'}`;
for main_var in ${MAIN_FUNC_NAME[@]}
do
	let MAIN_FUNC_COUNT++
	let SUM_COUNT++
done

# echo sub func md5sum value
cd - >> /dev/null;
md5sum *.sh;

# calculate the sub_func numbers
SUB_FUNC_NAME=`ls -alF *.sh | awk {print'$9'}`;
for sub_var in ${SUB_FUNC_NAME[@]}
do
	let SUB_FUNC_COUNT++
	let SUM_COUNT++
done

# add the file link to mainfunc/ and replace-file/
# add the replace-file/ to mainfunc/
if [ "$LINK_PATH" != "root" ];then
	cd $FUNC_PATH >> /dev/null;
	isREPLACE=`ls -alF . | grep 'replace-file' | awk {print'$9'}`

	if test -z $isREPLACE
	then
		# ln -s /root/replace-file /root/mainfunc
		ln -s $REPLACE_PATH $FUNC_PATH/
	fi
fi

# add the to mainfunc/ replace-file/,when the MAINFUNC LINK_PATH isn't /root catalog
if [ "$LINK_PATH" != "root" ];then
	cd $REPLACE_PATH >> /dev/null;
	#isMAINFUNC=`ls -alF . | grep 'mainfunc' | awk {print'$9'}`
	isMAINFUNC=`ls -alF . | grep $LINK_PATH | awk {print'$9'}`
	
	if test -z $isMAINFUNC
	then
		# ln -s /root/mainfunc /root/replace-file
		ln -s $FUNC_PATH $REPLACE_PATH/;
	fi
fi

# echo end line
echo " "
echo "$LINE_A";

# echo status file count 
echo "md5value file count:"
echo "	main func file: $MAIN_FUNC_COUNT"
echo "	sub  func file: $SUB_FUNC_COUNT"
echo "	all  func file: $SUM_COUNT"

# tips status to the screen
echo " "
echo "status ok..."
echo " "


