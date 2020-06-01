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
# Description:  This tool is a multi-threaded TCP scanner
#               It is use to list all open port from a given host
# Usage:        python tcp_threaded_scanner.py <host ip>
# Example:      python tcp_threaded_scanner.py 192.168.1.1
#

import threading
import Queue
import sys
from scapy.all import *


class WorkerThread(threading.Thread):
    def __init__(self, queue, tid):
        threading.Thread.__init__(self)
        self.queue = queue
        self.tid = tid

    def run(self):
        total_ports = 0
        while True:
            port = 0
            try:
                port = self.queue.get(timeout=1)
            except Queue.Empty:
                print "Worker %d exiting. Scanned %d ports ..." % (self.tid, total_ports)
                return

            ip = sys.argv[1]
            response = sr1(IP(dst=ip) / TCP(dport=port, flags="S"), verbose=False, timeout=.2)

            # only checking for SYN-ACK == flags = 18
            if response:
                if response[TCP].flags == 18:
                    print "ThreadId %d: Received port number %d Status: OPEN" % (self.tid, port)

            self.queue.task_done()
            total_ports += 1


queue = Queue.Queue()
threads = []
for i in range(1, 10):
    print "Creating WorkerThread : %d" % i
    worker = WorkerThread(queue, i)
    worker.setDaemon(True)
    worker.start()
    threads.append(worker)

for j in range(1, 1000):
    queue.put(j)

queue.join()

# wait for all threads to exit 
for item in threads:
    item.join()

print "[+] TCP Scanner Complete!"

