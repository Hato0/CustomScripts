#!/bin/bash
parametersList=($1)
domains=""
for element in "${parametersList[@]}"
do
    echo "[+] Getting results for $element"
    url="https://web.archive.org/cdx/search/cdx?url=*."$element"/*&output=json&collapse=urlkey"
    wget $url -q -O wayBack.url
    domains=`cat wayBack.url | grep -oP 'https?:\/\/([a-z0-9]+\.)*example\.com'`
    rm wayBack.url
done
domains=`echo "$domains" | tr " " "\n" | sort | uniq | grep -v -e '^[[:space:]]*$' -e '^#'`
echo "[+] Diplaying results"
echo "  [*] Domains"
echo "$domains"