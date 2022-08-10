#!/bin/bash
dorksResultMax=$1
parametersList=($2)
domains=""
for element in "${parametersList[@]}"
do
    echo "[+] Getting results for $element"
    for i in $(seq 0 10 $dorksResultMax)
    do
        url="https://www.google.com/search?client=firefox-b-d&q=site%3A*.$element&start=$i"
        curl -k -sA "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1" \
        -L $url -o dorks.url
        domains=$domains" "`cat dorks.url | grep -o 'href="[^"]*' | grep '/url' | grep -v 'google' | grep -oP 'https?:\/\/([a-z0-9]+\.)*example\.com' | grep -v -e '^[[:space:]]*$' -e '^#'`
        sleep 2
    done
    rm dorks.url
done
domains=`echo "$domains" | tr " " "\n" | sort | uniq | grep -v -e '^[[:space:]]*$' -e '^#'`
echo "[+] Diplaying results"
echo "  [*] Domains"
echo "$domains"