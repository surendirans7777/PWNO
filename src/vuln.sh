#!/bin/bash

printf "\t\e[1;33m    PWN      \e[0m\n"
                                    


    if [[ "$(id -u)" -ne 0 ]]; then
        printf "\e[1;91m Run this program as root!\n\e[0m"
        exit 1
    fi
    source ~/.bash_profile
    check_requirement () {
			command -v python > /dev/null 2>&1 || { echo >&2 "Python is not installed yet | Run ./install.sh. exit."; exit 1; }
			command -v go > /dev/null 2>&1 || { echo >&2 "go is not installed yet. | Run ./install.sh. exit."; exit 1; }
			command -v curl > /dev/null 2>&1 || { echo >&2 "curl is not installed yet. | Run ./install.sh. exit."; exit 1; }
			command -v jq > /dev/null 2>&1 || { echo >&2 "jq is not installed yet. | Run ./install.sh. exit."; exit 1; }
			command -v sed > /dev/null 2>&1 || { echo >&2 "sed is not installed yet. | Run ./install.sh. exit."; exit 1; }
			command -v waybackurls > /dev/null 2>&1 || { echo >&2 "waybackurls is not installed yet. | Run ./install.sh. exit."; exit 1; }
			command -v nmap > /dev/null 2>&1 || { echo >&2 "nmap is not installed yet. | Run ./install.sh. exit."; exit 1; }

}
check_requirement



read -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Enter The Domain: \e[0m' domain

mkdir -p ./Recon
        cd ./Recon
        mkdir -p ./$domain
        cd ./$domain



#waybackurl
        printf "\e[1;91m \n[+] Finding Waybackurls\e[0m\n"
        mkdir -p ./waybackurl
        waybackurls -no-subs -dates $domain | tee -a ./waybackurl/waybackurls.txt > /dev/null 2>&1        
        

#finding missing parameter
        printf "\e[1;91m \n[+] Finding Missing Headers\e[0m\n"
        mkdir -p "missing-headers"
        curl "https://securityheaders.com/?q=$domain&followRedirects=on" -s |grep "https://scotthelme.co.uk/" | cut -d$'\n' -f1 |sed 's/<[^>]*>/\n/g' | uniq| sort -b | grep "-" | sed '/"/d' | uniq | nl | tee -a ./missing-headers/headers.txt > /dev/null 2>&1




        printf "\e[1;91m \n[+] Creating HTML\e[0m\n"

# Creating HTML
echo  '<!DOCTYPE html><html>
<meta name="viewport" content="width=device-width, initial-scale=1">' >> output.html
echo '<head>' >> output.html
echo '<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-lite/1.1.0/material.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/dataTables.material.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/dataTables.material.min.js"></script>' >> output.html



echo  '<script>$(document).ready( function () {
    $("#myTable").DataTable({
        "paging":   true,
        "ordering": true,
        "info":     true,
	    "autoWidth": true,
       "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50,100, "All"]],
    });
} );
</script>' >> output.html
echo  '
<script>$(document).ready( function () {
    $("#example1").DataTable({
        "paging":   true,
        "ordering": true,
        "info":     true,
	    "autoWidth": true,
        "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50,100, "All"]],
    });
} );
</script>' >> output.html
echo  '
<script>$(document).ready( function () {
    $("#example2").DataTable({
        "paging":   true,
        "ordering": true,
        "info":     true,
	    "autoWidth": true,
        "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50,100, "All"]],
    });
} );
</script>' >> output.html
echo  '
<script>$(document).ready( function () {
    $("#history").DataTable({
        "paging":   true,
        "ordering": true,
        "info":     true,
	    "autoWidth": true,
        "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50,100, "All"]],
    });
} );</script>' >> output.html
echo  '<style>' >> output.html
echo '* {box-sizing: border-box;} div.container {width: 80%;}body {font-family: Arial;background: #f1f1f1;}.row1{display:flex}.column1{flex:100%}.header {padding: 10px;font-size: 30px;text-align: center;margin: 0;}.post-header{border-bottom:1px;solid #333;margin:0 0 50px;padding:0}.leftcolumn {float: left;width: 50%;}.rightcolumn {float: left;width: 50%;padding-left: 20px;}.rightimg {float: left;width: 50%;padding-left: 20px;}.leftimg {float: left;width: 50%;padding-left: 20px;}.row:after {content: "";display: table;clear: both;}.post-container-right{width:49%;float:right;margin:auto}.navbar {overflow: hidden;background-color: black;/*#333;*/}.navbar a {float: left;display: block;color: white;text-align: center;padding: 14px 20px;text-decoration: none;}.navbar a.right {float: right;}.navbar a:hover {background-color: #ddd;color: black;}img {display: block;margin-left: auto;margin-right: auto;}.footer {padding: 20px;text-align: center;background: #ddd;/* margin-top: 20px;*/}' >> output.html


echo 'esponsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other 
@media screen and (max-width: 800px) {
  .leftcolumn, .rightcolumn {   
    width: 100%;
    padding: 0;
  }
}' >> output.html
echo  '</style></head><body>' >> output.html
echo  '<div class="navbar">
  <a href="#">Home</a>
</div>' >> output.html

echo "<div class='header'>
  <h2>Report for $domain</h2>
</div>" >> output.html


echo '<div class="row">
<div class="leftcolumn">
<h3>WayBack URL</h3>
<table id="myTable" class="stripe">' >> output.html

echo '<thead>
            <tr>
                <th>Date</th>
                <th>Time</th>
                <th>URL</th>
            </tr>
        </thead> <trbody>' >> output.html

cat ./waybackurl/waybackurls.txt | while read line; do
  date=$(echo "$line" |  awk '{print $1}'| tr "T" "," | cut -d "Z" -f 1 | cut -d "," -f 1)
  Time=$(echo "$line" |  awk '{print $1}'| tr "T" "," | cut -d "Z" -f 1 | cut -d "," -f 2 )
  URL=$( echo "$line" |  awk '{print $2}')
  echo "<tr>"  >> output.html
  echo "<td>$date</td><td>$Time</td><td>$URL</td>"  >> output.html
  echo "</tr>"  >> output.html
done









echo -e '</tbody>
</table><h3>Subdomains</h3>
<table id="example1" class="display" style="width:100%">
    
        <thead>
            <tr>
                <th>Subdomains</th>
            </tr>
</thead>
<trbody>' >> output.html

cd ../../recon/$domain/

for line in $(cat ./Subenum/unique.txt );
do
    echo -e '<tr><td>' >> output.html
    echo "<a href="$line">"$line"</a>" >> output.html
    echo '</td></tr>' >> output.html
done 




echo -e '</tbody>
</table><h3>Parameters</h3>
<table id="example2" class="display" style="width:100%">
    
        <thead>
            <tr>
                <th>URL</th>
            </tr>
</thead>
<trbody>' >> output.html


for line in $(cat ./Param_mining/parameters.txt);
do
    echo -e '<tr><td>' >> output.html
    echo "$line" >> output.html
    echo '</td></tr>' >> output.html
done  

cd ../../Recon/$domain/

echo -e "</tbody> </table><h3>Missing Headers</h3><pre>$(cat ./missing-headers/headers.txt)</pre>"  >> output.html   
 printf "\e[1;91m \n[+] Using HOST \e[0m\n"
echo -e '<div class="post-content clearfix" itemprop="articleBody">' >> output.html
echo -e "<h3>Host</h3>
<pre>$(host $domain)
</pre>"  >> output.html
        printf "\e[1;91m \n[+] Using NMAP\e[0m\n"

echo -e "<h3>Nmap</h3>
<pre>
$(nmap -sV -T3 -Pn -p80,443,8080 $domain  |  grep -E 'open|filtered|closed')
</pre>"  >> output.html
echo "<h3>Shodan</h3> "  >> output.html
    printf "\e[1;91m \n[+] Using Shodan\e[0m\n"

for ip in $(host $domain | grep "has address" | cut -d " " -f 4);
    do
        echo -e '<pre>'  >> output.html
        shodan host $ip  >> output.html
        echo -e '</pre>'  >> output.html
    done 

echo -e '</div></div></div></body></html>'  >> output.html    
        echo -e "\e[1;92m \n[-] Done Please check the $(pwd)/output.html \e[0m\n"
