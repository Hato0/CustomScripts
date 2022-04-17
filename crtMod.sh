#!/bin/bash
parametersList=($1)
domains=""
certificates=""
for element in "${parametersList[@]}"
do
    echo "[+] Getting results for $element"
    url="https://crt.sh/?q="$element
    wget $url -q -O crtOut.html
    domains=$domains'@@@'`awk -F'</*TD>' '{print $2}' crtOut.html | grep -v -e '<A' | tr '<BR>' '\n'`
    certificates=$certificates'@@@'`awk -F'</*TD>' '{print $2}' crtOut.html | grep -e "<A" | grep -o -P '(?<=>).*(?=<)'` 
    rm crtOut.html
done
domains=`echo "$domains" | tr "@@@" "\n" | sort | uniq | grep -v -e '^[[:space:]]*$' -e '^#'`
certificates=`echo "$certificates" | tr "@@@" "\n" | sort | uniq | grep -v -e  '^[[:space:]]*$' -e '^#'`
echo "[+] Diplaying results"
echo "  [*] Domains (do not foget to GD)"
echo "$domains"
echo "  [*] Certificate authorities"
echo "$certificates"
