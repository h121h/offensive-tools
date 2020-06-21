#!/bin/bash
#
# Copyright 2020 Marcos Azevedo (aka pylinux) : psylinux[at]gmail.com
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

echo -e "1 - DNS for Internet Connection"
echo -e "2 - DNS for Ethernet"
echo -e "3 - DNS for WiFi"
echo -n ">>> "
read option

if [ "$option" == 1 ];then
    echo -e "nameserver 8.8.8.8\nnameserver 4.4.2.2" > /etc/resolv.conf
    route del default
	route del default
	route add default gw 10.107.48.1
	echo [+] Setting DNS for Internet Connection!
    elif [ "$option" == 2 ];then
        route del default
    	route del default
    	route add default gw 10.125.14.1
        echo -e "search rootbrasil.intranet\nnameserver 10.100.0.200\nnameserver 10.100.0.10\nnameserver 10.100.0.2\nnameserver 10.100.8.144\nnameserver 10.100.8.155" > /etc/resolv.conf
        echo [+] Setting DNS for Ethernet Connection!
        elif [ "$option" == 3 ];then
            route del default
        	route del default
        	route add default gw 10.125.14.1
            echo -e "search rootbrasil.intranet\nnameserver 10.100.0.200\nnameserver 10.100.0.10\nnameserver 10.100.0.2\nnameserver 10.100.8.144\nnameserver 10.100.8.155" > /etc/resolv.conf
            echo [+] Setting DNS for Wi-Fi Connection!
            else echo "!!! Wrong option !!!"
fi

