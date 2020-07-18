#!/bin/bash

# build date:  2018-01-13 10:00
# modify date: 2018-04-10 19:00
# time format: date "+%Y-%m-%d %H:%M"

echo " "
echo "That's OK , Test Success..."
echo " "
echo " "

echo $0 | awk 'BEGIN{FS="/"}{print $(NF-1)}'

