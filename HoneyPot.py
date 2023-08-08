from twisted.internet.protocol import Protocol, Factory
from twisted.internet import reactor
import time, binascii

#all interfaces
interface = '0.0.0.0'

ftpResponse = binascii.unhexlify("3232302050726f4654504420312e332e306120536572766572202850726f4654504420416e6f6e796d6f75732053657276657229205b3139322e3136382e312e3233315d0d0a")
sshResponse = binascii.unhexlify("5353482d322e302d436973636f2d312e32350a")
telnetResponse = binascii.unhexlify("fffb01fffb03fffd18fffd1f")

def printable(stringToPrint):
    currentTime = time.strftime("%Y-%m-%d %H:%M:%S: ")
    print(currentTime + stringToPrint)

class FTPClass(Protocol):
    def connectionMade(self):
        printable("Incoming FTP connection from %s port %s/TCP"% (self.transport.getPeer().host, self.transport.getPeer().port))
        self.transport.write(ftpResponse)
        printable("Response sent")

class SSHClass(Protocol):
    def connectionMade(self):
        printable("Incoming SSH connection from %s port %s/TCP"% (self.transport.getPeer().host, self.transport.getPeer().port))
        self.transport.write(sshResponse)
        printable("Response sent")

class TELNETClass(Protocol):
    def connectionMade(self):
        printable("Incoming TELNET connection from %s port %s"% (self.transport.getPeer().host, self.transport.getPeer().port))
        self.transport.write(telnetResponse)
        printable("Response sent") 