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
# Acknowledgment:
# Thank you Thiago Ribeiro for all the improvements!
#

import os
import json
import uuid
import argparse
import requests
import sqlite3
import hashlib
import tempfile


def set_table(con):
    cursor = con.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='images'")
    tn = cursor.fetchone()

    if tn is None:
        cursor.execute("CREATE TABLE images(id int PRIMARY KEY, name varchar(10), hash varchar(32))")
        cursor.execute("CREATE INDEX index_part_name ON images(name)")
        cursor.execute("CREATE INDEX index_part_hash ON images(hash)")
        con.commit()


def results(file):
    urls = []
    with open(file, 'r') as content:
        results = json.load(content)

        for _k, data in results['data'].items():
            for key, _d in data.items():
                if key == 'url':
                    urls.append(_d)
    return urls


def set_image_path(img_path):
    if not os.path.isdir(img_path):
        try:
            os.mkdir(img_path)
        except OSError:
            print("Was not possible to create the image path: %s", img_path)


def download_image(img_path, url, con):
    mtypes = {'image/jpeg': 'jpg', 'image/png': 'png', 'image/gif': 'gif'}

    h = requests.head(url)
    header = h.headers
    content_type = header.get('content-type')

    if content_type in mtypes.keys():
        name = uuid.uuid4()
        fullname = "%s/%d.%s" % (img_path, name, mtypes[content_type])
        print('[+] Downloading: %s' % fullname)

        r = requests.get(url, stream=True)
        if r.status_code == 200:
            cursor = con.cursor()
            check_hash = None
            # save as temp file to checksum
            with tempfile.TemporaryFile() as fp:
                fp.write(r.raw.data)
                fp.seek(0)
                hash = hashlib.md5(fp.read()).hexdigest()
                cursor.execute("SELECT hash, name from images WHERE hash='%s'" % hash)
                con.commit()
                check_hash = cursor.fetchone()

            if check_hash is None:
                with open(fullname, 'wb') as f:
                    f.write(r.raw.data)
                    cursor.execute("INSERT INTO images(name, hash) VALUES ('%s','%s')" % (fullname, hash))
                    con.commit()
            else:
                print("Image already exists and it's name is: %s" % check_hash[1])
    else:
        print("Invalid mimetype")


if __name__ == "__main__":
    IMG_PATH = './img'
    DB_NAME = 'imagesdb'
    set_image_path(IMG_PATH)

    parser = argparse.ArgumentParser()
    parser.add_argument("file", help="Your JSON File!")
    args = parser.parse_args()
    urls = results(args.file)

    if len(urls) > 0:
        con = sqlite3.connect(DB_NAME)
        set_table(con)
        for url in urls:
            download_image(IMG_PATH, url, con)
    else:
        print("Empty image list")
