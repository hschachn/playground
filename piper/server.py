import time
import os

pi = os.pipe()

def start():

    while(True):
        with pi.open(r'\\.\pipe\piper', 'r+b', 0) as (r,w):
            data = r.read()
            r.seek(0)
            print(data)



if __name__ == '__main__':
    start()