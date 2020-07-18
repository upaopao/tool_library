#!/bin/bash

# build date:  2018-03-01 10:00
# modify date: 2018-03-23 17:45
# time format: date "+%Y-%m-%d %H:%M"

# define common data
LINE_A="———————————————————————————————————————————————————————————————————————"
SUB_FUNC_COUNT=0
MAIN_FUNC_COUNT=0
SUM_COUNT=0

# keep a blank line
echo " "

# echo begin line
echo "$LINE_A";

# get main func file name
cd ../ >> /dev/null;
MAIN_FUNC_NAME=`ls -alF *.sh | awk {print'$9'}`

# echo all main function modify date's status info
echo "[main func date]:";
for main_var in ${MAIN_FUNC_NAME[@]}
do
	echo -n "	$main_var			";
	cat $main_var | grep '# modify date' | head -n 1;
	let MAIN_FUNC_COUNT++
	let SUM_COUNT++
done

# get sub func file name,return return catalog: 'cd -;'
#cd ./function/;
cd - >> /dev/null;
SUB_FUNC_NAME=`ls -alF *.sh | awk {print'$9'}`

# echo all sub  function modify date's status info
echo "[sub func date]:";
for sub_var in ${SUB_FUNC_NAME[@]}
do
	echo -n "	$sub_var			";
	cat $sub_var | grep '# modify date' | head -n 1;
	let SUB_FUNC_COUNT++
	let SUM_COUNT++
done

# echo end line
echo " "
echo "$LINE_A";

# echo status file count 
echo "status file count:"
echo "	main func file: $MAIN_FUNC_COUNT"
echo "	sub  func file: $SUB_FUNC_COUNT"
echo "	all  func file: $SUM_COUNT"

# **********************************************************
#
# cat the 'modify date' for each file
# catalog: ../
#cat ../0--run.sh         | grep 'modify date';
#cat ../6--packiso.sh     | grep 'modify date';
#cat ../7--service.sh     | grep 'modify date';
#cat ../9--ssh.sh         | grep 'modify date';
#cat ../xx--clean.sh      | grep 'modify date';

# catalog: ./
#cat ./10-sshFunc.sh      | grep 'modify date';
#cat ./11-unsshFunc.sh    | grep 'modify date';
#cat ./12-machine.sh      | grep 'modify date';
#cat ./1-buildall.sh      | grep 'modify date';
#cat ./2-commit.sh        | grep 'modify date';
#cat ./2-commit_origin.sh | grep 'modify date';
#cat ./3-getfile.sh       | grep 'modify date';
#cat ./4-releaseall.sh    | grep 'modify date';
#cat ./5-valuecheck.sh    | grep 'modify date';
#cat ./8-replaceFunc.sh   | grep 'modify date';
#cat ./test.sh            | grep 'modify date';
#cat ./status.sh          | grep 'modify date:';

# sed command modify file
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config -i
#sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config -i

# tips status to the screen
echo " "
echo "status ok..."
echo " "


