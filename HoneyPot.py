from twisted.internet.protocol import Protocol, Factory
from twisted.internet import reactor
import time, binascii

#all interfaces
interface = '0.0.0.0'
f = open("/opt/HoneyPi/logs.txt", "a")

ftpResponse = binascii.unhexlify("3232302050726f4654504420312e332e306120536572766572202850726f4654504420416e6f6e796d6f75732053657276657229205b3139322e3136382e312e3233315d0d0a")
sshResponse = binascii.unhexlify("5353482d322e302d436973636f2d312e32350a")
telnetResponse = binascii.unhexlify("fffb01fffb03fffd18fffd1f")

def printable(stringToPrint):
    currentTime = time.strftime("%Y-%m-%d %H:%M:%S: ")
    f.write(currentTime + stringToPrint)

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

FTPService = Factory()
FTPService.protocol = FTPClass

SSHService = Factory()
SSHService.protocol = SSHClass

TELNETService = Factory()
TELNETService.protocol = TELNETClass

print("Starting HoneyPot...")
reactor.listenTCP(21, FTPService, interface = interface)
reactor.listenTCP(23, TELNETService, interface = interface)
reactor.listenTCP(22, SSHService, interface = interface)
reactor.run()
f.close()
