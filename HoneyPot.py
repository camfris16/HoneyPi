from twisted.internet.protocol import Protocol, Factory
from twisted.internet import reactor
import time

#all interfaces
interface = '0.0.0.0'

def printable(stringToPrint):
    currentTime = time.strftime("%Y-%m-%d %H:%M:%S: ")
    print(currentTime + stringToPrint)

