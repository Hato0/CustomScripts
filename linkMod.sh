#!/bin/bash

function usage(){
	echo "USAGE: script.sh -P '(proto1|proto2|...)' -e '(ext1|ext2|...)' -s -l -u 'URL'"
	echo "-s: Silent wget mode"
	echo "-l: Search for local files"
	echo "-P: default => http|https, passing option will ADD your optional proto"
	echo "-e: Will only search for the entered extension, carefull using it with -P flag"
	echo "	Default : html, php, js, env, DS_Store, log, py, json, properties, pem, xml, yml, yaml, ts" 
	exit 1;
}
protoDefault="(http|https)"
SEC=0
LOCAL=0
extension="(\.html|\.php|\.js|\.env|\.DS_Store|\.log|\.py|\.json|\.properties|\.pem|\.xml|\.yml|\.yaml|\.ts)"
modifExt=0
while getopts "e:P:lsu:h" flag
do	
	case "$flag" in
		P) proto="${OPTARG}";; 
		s) SEC=1 ;;
		u) url="${OPTARG}" ;;
		e) extension="${OPTARG}" 
		   modifExt=1;;
		l) LOCAL=1;;
		h) usage;;
	esac
done 

if [ $SEC = 0 ]; then
	wget $url -q -O analyze.html
else 
	wget $url -q -O analyze.html --no-check-certificate
fi

#grep "<a href=" analyze.html  | tr '"' '\n' | tr "'" '\n' | grep -e '^https://' -e '^http://' -e'^//' | sort | uniq 
grep -Eo "$protoDefault://[^ >]+$extension" analyze.html |sort |uniq
if [ ! -z $proto ] && [ $modifExt -ne 1 ];then
	grep -Eo "$proto://[^ >]+(\"|\'|<)" analyze.html |rev |cut -c 2-| sort |uniq |rev
elif [ ! -z $proto ] && [ $modifExt -ne 0 ];then
	grep -Eo "$proto://[^ >]+$extension" analyze.html |sort |uniq
fi

if [ $LOCAL -eq 1 ]; then
	grep -Eo "(\"|\'|<|>)/[^ >]+$extension" analyze.html |cut -c 2-| sort |uniq 
fi
rm analyze.html
