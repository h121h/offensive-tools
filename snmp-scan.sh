#!/bin/bash
# snmp_scan.sh
# Author: Marcos Azevedo
# Date: 30-10-2018

## Setting the community file
echo -e "public\nprivate\nmanager" > community.txt

## Generating the snmp_scan_range.txt
# for ip in $(seq 1 254)
#do 
#	echo <192.168.1>.$ip >> snmp_scan_range.txt
#done 

## Scanning the snmp_scan_range.txt for open SNMP port
onesixtyone -c community.txt -i snmp_scan_range.txt -o snmp_scan_vulns.txt
cat snmp_scan_vulns.txt | cut -d " " -f1 > snmp_scan_uphost.txt

## Using snmpwalk
for ip in $(cat snmp_scan_uphost.txt)
do 
	echo -e "========== SnmpWalk - Fetching $ip ==========\n"
	snmpwalk -c public -v1 $ip | tee snmp_scan_walk_$ip.txt
done

## Using snmp-check
for ip in $(cat snmp_scan_uphost.txt)
do 
	echo -e "========== SnmpCheck - Fetching $ip ==========\n"
	snmp-check $ip | tee snmp_scan_check_$ip.txt
done

