#!/bin/bash

./kasrapars.sh > tmp.txt
TIME=$(grep '1 passing' tmp.txt | awk '{print $7}' | tr -d '()s' | sed 's/[^0-9.]//g' | sed 's/..$//')
grep '1 passing' tmp.txt
if [ $? -eq 0 ]
then
	zabbix_sender -z 192.168.212.3 -p 10051 -s "kasrapars" -k time -o $TIME
	zabbix_sender -z 192.168.212.3 -p 10051 -s "kasrapars" -k log -o 'login successful'
else
	zabbix_sender -z 192.168.212.3 -p 10051 -s "kasrapars" -k time -o 0
	zabbix_sender -z 192.168.212.3 -p 10051 -s "kasrapars" -k log -o 'login unsuccessful'
fi
rm tmp.txt
