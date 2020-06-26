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

import json
import requests
import argparse
from bs4 import BeautifulSoup


def results(file):
    content = open(file, 'r').readlines()
    for line in content:
        data = json.loads(line.strip())
        urls = []
        for url in data['results']:
            urls.append(url['url'])
        return urls


def crawl(url):
    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'lxml')
    links = soup.findAll('a', href=True)
    for link in links:
        link = link['href']
        if link and link != '#':
            print('[+] {} : {}'.format(url, link))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("file", help="ffuf results")
    args = parser.parse_args()
    urls = results(args.file)
    for url in urls:
        crawl(url)
