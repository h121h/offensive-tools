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

r=$(( $RANDOM % 4 ));

echo -e "[+] Changing MacAddr\n"
case $r in
	0)
		#MAC_CISCO_1
  		vend="70:b3:17"
	;;
	1)
		#MAC_CISCO_2
		vend="70:C9:C6"
	;;
	2)
		#MAC_CISCO_3
		vend="70:D3:79"
	;;
	3)
		#MAC_CISCO_4
		vend="F4:AC:C1"
	;;
esac

premac="$vend:11:22:33"

echo -e "\t[-] Setting wlan0 DOWN"
sudo ip link set wlan0 down
sleep 3

echo -e "\t[-] Using a CISCO MacAddr"
echo -e "\t[----------]" && macchanger -m $premac wlan0
sleep 1
echo -e "\t[----------]" && macchanger -ea wlan0
sleep 2

echo -e "\t[-] Setting wlan0 UP\n"
sudo ip link set wlan0 up
sleep 3

echo -e "[+] Changing TTL"
echo 129 > /proc/sys/net/ipv4/ip_default_ttl

