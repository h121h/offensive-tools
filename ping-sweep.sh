#!/bin/bash

for ip in $(seq 248 254); do
	ping -c 1 172.16.227.$ip | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 ;
done
