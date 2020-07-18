#!/bin/bash


# example: ./initkvm.sh add br0 eth0 10.0.0.1

# set default variable value.
OPERATE_TYPE=""
BRIDGE_NAME="br0"
GateWay_Addr=""
GateWay_NAME="default"

ETH_CARD_NAME="eth0"

NET_INFO=`ip addr | grep $ETH_CARD_NAME | grep inet | awk '{print $2}'`
IP_MASK=`ip addr | grep eth0 | grep inet | awk '{print $2}' | awk -F "/" '{print $2}'`
DEFAULT_GW=`route -n | grep eth0 | grep UG | awk '{print $2}'`

# set operate type: add/delete
if [ [ $1 == "" || $1 == "-" ] ];then
	OPERATE_TYPE="add"
else
  	case $1 in
	-h | --help | help )
		echo -e "\033[32m usage: \033[./$0 add gateway_addr gateway_name"
		echo -e "\033[32m eg: \033[./$0 add 10.0.0.1 "
		echo ""
		exit
		;;
  	add | Add | ADD )
  		OPERATE_TYPE="add"
  		;;
  	del | Del | DEL )
  		OPERATE_TYPE="delete"
  		;;
  	delete | Delete | DELETE )
  		OPERATE_TYPE="delete"
  		;;
  	esac

if [ $OPERATE_TYPE == "" ];then
	echo -e "\033[31m error: \033[0m operate type error..."
	echo ""
	exit
fi

# set gateway_addr and gateway_name
if [ $2 =="-" ];then
	# gateway_addr

fi

if [ $3 =="-" ];then
	# gateway_name
fi


# type=add 
if [ $OPERATE_TYPE == "add" ];then
	brctl addbr $BRIDGE_NAME
  	brctl addif $BRIDGE_NAME 

  	ifconfig $BRIDGE_NAME down
  	ifconfig $BRIDGE_NAME $NET_INFO up
  	route add default gw $DEFAULT_GW
fi

# type=delete
if [ $OPERATE_TYPE == "delete" ];then
	route delete default
	ifconfig $BRIDGE_NAME down
	brctl delif $BRIDGE_NAME 
fi

#echo -e "\033[31m error: \033[0m Suspension of execution..."

