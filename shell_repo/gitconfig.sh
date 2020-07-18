#!/bin/bash

#git config user.name "your_name"
#git config user.email "your_email"

# initial prompt color
#echo -e "\033[31mgit config: \033[0m"

# screen prompt
echo " "
echo "[ options ] : 1=github 2=gitlab 3=company 4=list"

# input variable
echo " "
read -p "Please input [1-4]: "     input_option

# set option value
if [[ "$input_option" == "" || "$input_option" == "1"  ]];then
	input_option="github"
fi

if [ "$input_option" == "2" ];then
	input_option="gitlab"
fi

if [ "$input_option" == "3" ];then
	input_option="company"
fi

if [ "$input_option" == "4" ];then
	input_option="list"
fi

#test
echo " "
echo "Your choose option:" $input_option 
echo " "

# check the .git status.
GIT_STATUS=`find -name .git`
if [ "$GIT_STATUS" == "" ];then
  mkdir -p .git;
fi

# set personal GitHub account.
if [ "$input_option" == "github" ];then
  git config user.name  "lovfer"
  git config user.email "aromaticpf1@gmail.com"
fi

# set personal GitLab account.
if [ "$input_option" == "gitlab" ];then
  git config user.name  "AidenTech"
  git config user.email "aromaticpf1@gmail.com"
fi

# set personal Company account.
if [ "$input_option" == "company" ];then
  git config user.name  "yuan"
  git config user.email "yuan@ismart-bot.com"
fi

# get config list.
if [ "$input_option" == "list" ];then
  echo -e "\033[31mgit config: \033[0m"
  git config --list
  echo " "
  exit
fi

# set output echo -e "\033[31m error: \033[0m param '$input_option' error"
echo -e "\033[31mgit config: \033[0m"
git config --list
echo " "


