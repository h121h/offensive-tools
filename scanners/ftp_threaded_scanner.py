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
#
# Requires:     Python 2.x installed
# Description:  This tool is a multi-threaded FTP scanner
#               It is use to list a content of a given ftp server
# Usage:        python ftp_threaded_scanner.py <num of threads> <list of ftp servers>
# Example:      python ftp_threaded_scanner.py 10 ftp4.FreeBSD.org ftp.crans.org ftp.debian.org
#

import threading
import Queue
import sys
from ftplib import FTP


class WorkerThread(threading.Thread):
    def __init__(self, queue, tid):
        threading.Thread.__init__(self)
        self.queue = queue
        self.tid = tid

    def run(self):
        while True:
            host = None

            # Get lock to synchronize threads
            threadLock.acquire()

            try:
                host = self.queue.get(timeout=1)

            except Queue.Empty:
                print "Worker %d exiting..." % self.tid
                return

            # login to ftp host anonymously and list the dirs
            try:
                conn = FTP(host)
                conn.login()
                print 'Host: ' + host
                print conn.retrlines('LIST')
            except:
                print "Error in listing " + host
                raise

            # Free lock to release next thread
            threadLock.release()
            self.queue.task_done()


if len(sys.argv) < 3:
    print   '''
            [+] Usage: %s <number of threads> <list of ftp hosts>
            [+] Example: %s 10 ftp4.FreeBSD.org ftp.crans.org ftp.debian.org
            ''' % (sys.argv[0], sys.argv[0])
    quit()

ftpList = sys.argv
queue = Queue.Queue()
threadLock = threading.Lock()
threads = []

tcount = int(ftpList.pop(1)) + 1
for i in range(1, tcount):
    print "Creating WorkerThread : %d" % i
    worker = WorkerThread(queue, i)
    worker.setDaemon(True)
    worker.start()
    threads.append(worker)

ftpList.pop(0)
for host in ftpList:
    queue.put(host)

queue.join()

# wait for all threads to exit
for item in threads:
    item.join()

print "[+] FTP Scanner Complete!"
