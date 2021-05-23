#!/bin/bash

wget $1 -O /home/HH/Documents/Web_IP_HOST_OUTPUT/$1


for url in /home/HH/Documents/Web_IP_HOST_$1 ;do
	host $url |grep "has address" |cut -d " " -f4
done