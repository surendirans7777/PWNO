#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

if [ -d ~/Desktop/Project/PWN0/recon/ ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon/ 

fi

if [ -d ~/Desktop/Project/PWN0/recon/$DOM ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon/$DOM

fi

if [ -d ~/Desktop/Project/PWN0/recon/$DOM/Subenum ]
then
  echo " "
else
  mkdir ~/Desktop/Project/PWN0/recon/$DOM/Subenum

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
echo "${blue} [+] Started Subdomain Discovery ${reset}"
echo " "

#assefinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/assetfinder ]
then
  echo "${magenta} [+] Finding Assets  ${reset}"
  assetfinder -subs-only $DOM  >> ~/Desktop/Project/PWN0/recon/$DOM/Subenum/assets.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  go get -u github.com/tomnomnom/assetfinder
  echo "${magenta} [+] Running Assetfinder ${reset}"
  assetfinder -subs-only $DOM  >> ~/Desktop/Project/PWN0/recon/$DOM/Subenum/assets.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to assets.txt  ${reset}"
echo " "


#subfinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/subfinder ]
then
  echo "${magenta} [+] Finding Subdomains ${reset}"
    subfinder -d $DOM -silent | tee -a ~/Desktop/Project/PWN0/recon/$DOM/Subenum/subdomains.txt > /dev/null 2>&1
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
  echo "${magenta} [+] Running Subfinder ${reset}"
  subfinder -d $DOM -silent | tee -a ~/Desktop/Project/PWN0/recon/$DOM/Subenum/subdomains.txt > /dev/null 2>&1
fi
echo " "
echo "${blue} [+] Succesfully saved to subdomains.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] fetching unique domains ${reset}"
echo " "
cat ~/Desktop/Project/PWN0/recon/$DOM/Subenum/assets.txt ~/Desktop/Project/PWN0/recon/$DOM/Subenum/subdomains.txt | sort -u >> ~/Desktop/Project/PWN0/recon/$DOM/Subenum/unique.txt
echo "${blue} [+] Succesfully saved to unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
  
 cat ~/Desktop/Project/PWN0/recon/$DOM/Subenum/unique.txt | httpx -silent | tee -a ~/Desktop/Project/PWN0/recon/$DOM/Subenum/all-alive-subs.txt > /dev/null 2>&1
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
  cat ~/Desktop/Project/PWN0/recon/$DOM/Subenum/unique.txt | httpx -silent | tee -a ~/Desktop/Project/PWN0/recon/$DOM/Subenum/all-alive-subs.txt > /dev/null 2>&1
fi
echo " "
echo "${blue} [+] Successfully saved to all-alive-subs.txt"
echo " "

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Done ${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
