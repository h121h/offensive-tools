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
# Generate entropy for GPG keygen
#

# Installing required package
apt-get install -y corosync rng-tools

# Showing system entorpy
rngd -r /dev/urandom
Echo "Entorpy: "; cat /proc/sys/kernel/random/entropy_avail

# Generating entropy
while true; do
	dd if=/dev/urandom;
	of=/tmp/100 bs=1024 count=100000;
	for i in {1..10}; do
		cp /tmp/100 /tmp/tmp_$i_$RANDOM;
	done;
	rm -f /tmp/tmp_* /tmp/100;
done & /usr/sbin/corosync-keygen
