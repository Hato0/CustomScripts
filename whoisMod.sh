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
    '.ch' 
    '.be'
    '.ca'
    )

tab_msg=(
    'No match for'                      #.com
    'No match for'                      #.net
    'NOT FOUND'                         #.org
    'NOT FOUND'                         #.info
    'Not found'                         #.biz
    'No Match'                          #.edu
    'NOT FOUND'                         #.mobi
    'No match.'                         #.name
    'Status:    AVAILABLE'              #.eu 
    'No entries found'                  #.fr
    'We do not have an entry'           #.ch
    'Status:    AVAILABLE'              #.be
    'Domain status:         available'  #.ca
    )

let "n=${#tab_tld[*]} -1"

dnWithExt=`echo $1 | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_'`
tld=`echo $dnWithExt | awk -F. '{print $NF}'`
domaineName=`echo $dnWithExt | awk -F. '{ for (i=1;i<NF;i++) { print $i } }'`
domaineName=`echo $domaineName | tr ' ' '\.'`
echo $tld
echo $domaineName
if [[ " ${tab_tld[*]} " =~ " ${tld} " ]]; then
    echo "[+] Executing in availability mode"
    for i in `seq 0 $n`
    do
        tld_name="$1${tab_tld[$i]}"
        if [ -z "`whois $tld_name | grep "${tab_msg[$i]}"`" ]; then
            echo -e "$tld_name is already registered"
        else
            echo -e "$tld_name is free"
        fi
    done
else
    ext=".$tld"
    id="not"
    echo "[+] Executing in whois mode"
    for i in `seq 0 $n`
    do
        if [ ${tab_tld[$i]} == $ext ];then
            id=$i
        fi
    done
    if [ $id == "not" ];then
        echo -e "\"$ext\" is not supported"
    else
        if [ -z "`whois $1 | grep "${tab_msg[$id]}"`" ]; then
            echo -e "$1 is already registered"
        else
            echo -e "$1 is free" 
        fi
    fi
fi