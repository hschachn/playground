import socket
import sys
# This is an example of a UDP client - it creates
# a socket and sends data through it

# create the UDP socket
UDPSock = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)


try:
    data = sys.argv[1]
except IndexError:    
    data = "DISCOVER"


# Simply set up a target address and port ...
addr = ("localhost",21567)
UDPSock.connect(addr)
# ... and send data out to it!
UDPSock.send(data.encode('utf-8'))
