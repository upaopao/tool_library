#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-03-01 17:00
# time format: date "+%Y-%m-%d %H:%M"

# get each file name
#ls -alF | awk {print'$9'};

# cat the 'modify date' for each file
# catalog: ../
cat ../0--run.sh         | grep 'modify date';
cat ../6--packiso.sh     | grep 'modify date';
cat ../7--service.sh     | grep 'modify date';
cat ../9--ssh.sh         | grep 'modify date';
cat ../xx--clean.sh      | grep 'modify date';

# catalog: ./
cat ./10-sshFunc.sh      | grep 'modify date';
cat ./11-unsshFunc.sh    | grep 'modify date';
cat ./12-machine.sh      | grep 'modify date';
cat ./1-buildall.sh      | grep 'modify date';
cat ./2-commit.sh        | grep 'modify date';
cat ./2-commit.sh_origin | grep 'modify date';
cat ./3-getfile.sh       | grep 'modify date';
cat ./4-releaseall.sh    | grep 'modify date';
cat ./5-valuecheck.sh    | grep 'modify date';
cat ./8-replaceFunc.sh   | grep 'modify date';
#cat ./status.sh          | grep 'modify date:';
cat ./test.sh            | grep 'modify date';

# sed command modify file
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config -i
#sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config -i

# tips status to the screen
echo " "
echo " "
echo "status ok..."
echo " "


