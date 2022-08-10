#!/bin/bash
parametersList=($1)
domains=""
certificates=""
for element in "${parametersList[@]}"
do
    echo "[+] Getting results for $element"
    url="https://crt.sh/?q="$element
    wget $url -q -O crtOut.url
    domains=$domains'@@@'`awk -F'</*TD>' '{print $2}' crtOut.url | grep -v -e '<A' | tr '<BR>' '\n'`
    certificates=$certificates'@@@'`awk -F'</*TD>' '{print $2}' crtOut.url | grep -e "<A" | grep -oP '(?<=>).*(?=<)'` 
    rm crtOut.url
done
domains=`echo "$domains" | tr "@@@" "\n" | sort | uniq | grep -v -e '^[[:space:]]*$' -e '^#'`
certificates=`echo "$certificates" | tr "@@@" "\n" | sort | uniq | grep -v -e  '^[[:space:]]*$' -e '^#'`
echo "[+] Diplaying results"
echo "  [*] Domains"
echo "$domains"
echo "  [*] Certificate authorities"
echo "$certificates"
