#!/bin/bash

if [ $# -lt 1 ]; then
        echo -e "Usage: $0 <IP|HOSTNAME>"
        exit 1
fi
HOST=$1

ports=$(nmap -Pn -p- --min-rate=1000 -T4 $HOST | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
if [ -z $ports ]; then
        echo -e "All ports are closed"
        exit 1
else 
        nmap -Pn -sC -sV -p$ports $HOST -webxml -oA $HOST-fulltcp
fi
