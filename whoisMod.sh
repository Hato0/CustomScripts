#!/bin/bash

#si printfile=1 écrire également les domaines non libres? :  0 = non 1 = oui
printnonfree=1

tab_tld=( 
    '.com' 
    '.net' 
    '.org' 
    '.info'
    '.biz'
    '.edu'
    '.mobi'
    '.name'
    '.eu'
    '.fr' 
    '.be'
    '.ca'
    )

tab_msg=(
    'No match for'                      #.com
    'No match for'                      #.net
    'NOT FOUND'                         #.org
    'Domain not found.'                 #.info
    'No Data Found'                     #.biz
    'NO MATCH'                          #.edu
    'Domain not found.'                 #.mobi
    'No match.'                         #.name
    'Status:    AVAILABLE'              #.eu 
    'No entries found'                  #.fr
    'Status:	AVAILABLE'              #.be
    'Not found:'                        #.ca
    )

let "n=${#tab_tld[*]} -1"
parametersList=($1)
for element in "${parametersList[@]}"
do
    tld="${element##*.}"
    domaineName="${element%.*}"
    if ! [[ ${tab_tld[*]} =~ ${tld} ]]; then
        echo "[+] Executing in availability mode"
        for i in `seq 0 $n`
        do
            tld_name="$element${tab_tld[$i]}"
            if [ -z "`whois -H $tld_name | grep "${tab_msg[$i]}"`" ]; then
                echo -e "$tld_name is already registered"
            else
                echo -e "$tld_name is free"
            fi
        done
    else
        echo "[+] Executing in whois mode"
        whoisDatas="`whois -H $element | sed -n '/^Domain Name/,/^>>> Last update/p'`"
        whoisDatas="`echo "$whoisDatas"| grep 'Name Server\|Registrar URL\|Creation Date\|Updated Date\|Registar Expiry Date\|Registrant Country\|DNSSEC'|uniq`"
        if ! [ -z "$whoisDatas" ]; then
            echo -e "   [*] Result for : $element"
            echo "$whoisDatas"
        else
            echo -e "$element is not registered" 
        fi
    fi
done