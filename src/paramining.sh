#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/Desktop/Project/PWN0/recon/ ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon

fi

if [ -d ~/Desktop/Project/PWN0/recon/$DOM ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon/$DOM

fi

if [ -d ~/Desktop/Project/PWN0/recon/$DOM/Param_mining ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon/$DOM/Param_mining

fi


echo "${red}
 ===============================
| 		 		|
| ______ _    _ _   _ _____ 	|
| | ___ \ |  | | \ | |  _  |	|
| | |_/ / |  | |  \| | |/| |	|
| |  __/| |/\| | . | | | | |	|
| | |   \  /\  | |\  \ |_/ /	|
| \_|    \/  \/\_| \_/\___/ 	|
|                               |
 ===============================
${reset}"
echo "${blue} [+] Started Param Mining ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/tools/ParamSpider/ ]
then
  echo "${magenta} [+] Finding Parameters ${reset}"
    python3 ~/tools/ParamSpider/paramspider.py -d $DOM --subs False --exclude woff,css,js,png,svg,php,jpg | tee -a ~/Desktop/Project/PWN0/recon/$DOM/Param_mining/parameters.txt > /dev/null 2>&1  
else
  echo "${blue} [+] Installing ParamSpider ${reset}"
  echo "${magenta} [+] Finding Parameters ${reset}"
  sudo git clone https://github.com/devanshbatham/ParamSpider ~/tools/ParamSpider/
  python3 ~/tools/ParamSpider/paramspider.py -d $DOM --subs False --exclude woff,css,js,png,svg,php,jpg | tee -a ~/Desktop/Project/PWN0/recon/$DOM/Param_mining/parameters.txt > /dev/null 2>&1 


fi
echo " "
echo "${blue} [+] Succesfully saved to parameters.txt  ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
