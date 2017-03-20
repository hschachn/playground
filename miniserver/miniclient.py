__author__ = 'Hermann Schachner'

import logging
import random
import http.client
import threading

from tornado.escape import *

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)


def thread_runner(i,n, lg):
    def req():
        print("[%04d] STARTED F(%d)" % (i,n))
        uri = "/fib/%d" % n
        connection = http.client.HTTPConnection('localhost', 45678)
        connection.request('GET', uri)

        response = connection.getresponse()
        if response.status == http.client.OK:
            dd = json.loads(response.read().decode())
            print("FINISHED       F(%d) = %s" % (n, dd['result']))
        else:
            print("Error: %s" % response.read())
        connection.close()

    return req


def start():
    for i in range(10):
        n = random.randint(20000, 200000)
        th = threading.Thread(target=thread_runner(i, n, logger))
        th.start()


if __name__ == "__main__":
    start()
