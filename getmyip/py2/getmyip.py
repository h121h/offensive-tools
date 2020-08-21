#!/usr/bin/env python2
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

import urllib
import urllib.request
import socket
import re


url = 'http://example.com/'


def get_external_ip():
    site = urllib.urlopen("http://meuip.com.br/").read()
    grab = re.findall('([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)', site)
    address = grab[0]
    return address


if __name__ == '__main__':
    myip = get_external_ip()
    myhost = socket.gethostname()
    print('client: ', myhost, 'ip: ', myip)
