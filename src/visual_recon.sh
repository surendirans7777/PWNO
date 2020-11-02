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

if [ -d ~/Desktop/Project/PWN0/recon/$DOM/Visual_Recon ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon/$DOM/Visual_Recon

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
echo "${blue} [+] Starting Visual Recon ${reset}"
echo " "

#screenshotting
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
mkdir ~/Desktop/Project/PWN0/recon/$DOM/Visual_Recon
if [ -f ~/go/bin/aquatone ]
then
  echo "${magenta} [+] Screenshotting Alive subs ${reset}"
  cat ~/Desktop/Project/PWN0/recon/$DOM/Subenum/all-alive-subs.txt | aquatone -out ~/Desktop/Project/PWN0/recon/$DOM/Visual_Recon
else
  echo "${blue} [+] Installing Aquatone ${reset}"
  go get github.com/michenriksen/aquatone
  echo "${magenta} [+] Screenshotting Alive subs ${reset}"
  cat ~/Desktop/Project/PWN0/recon/$DOM/Subenum/all-alive-subs.txt | aquatone -out ~/Desktop/Project/PWN0/recon/$DOM/Visual_Recon
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved to screenshots"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
