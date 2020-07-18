#!/bin/bash

if [ $1 -eq 1 ];then
	virsh create cwin10.xml
fi

if [ $1 -eq 2 ];then
	virsh shutdown cwin10
fi

if [ $1 -eq 3 ];then
	virsh destroy cwin10
fi


