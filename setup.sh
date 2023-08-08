#!/bin/bash

# check root
if [ $UID -ne 0 ]
then
 echo "Please run this script as root: sudo setup.sh"
 exit 1
fi

if (whiptail --yesno "Welcome to the HoneyPi Installer! This program will make some changes to the Raspberry Pi (Changing MAC Address etc.) so enter 'no' now to exit or 'yes' to continue. An email address will also be needed to send notifications to, so have one ready!" 20 60); then
    echo "continue"
else
    exit 1
fi

# updating OS
echo "----Just updating the OS if it needs to be----"
sudo apt-get update && sudo apt-get upgrade -y

# Changing MAC address to windows machine
echo "----Now changing the MAC Address to disguise the pi as a Windows machine. WARRNING: Config files will start being edited now----"
sed -i 's/$/ smsc95xx.macaddr=F0:6E:0B:A7:53:D5/' /boot/cmdline.txt

# Changing Hostname 
echo "----Updating hostname to reflect the MAC Address and disguise the pi----"
sed -i 's/.*127.0.0.1.*/127.0.0.1       FILESERVER /' /etc/hosts
echo "FILESERVER" > /etc/hostname

echo "----DEVICE HIDDEN----"

# Enabling SSH
echo "----Enabling SSH if it isn't already----"
touch /boot/ssh

# Changing default SSH port
echo "----Changing default SSH port to 9001 for remote access (Default port will be a target!)----"
echo "----Port numbers can be found on README.md----"
sed -i 's/#Port 22/Port 9001/' /etc/ssh/sshd_config

# Software installation
echo "----Now installing the required software, such as port scan detection etc. Full list can be found in README.md----"
apt-get -y install psad iptables-persistent fwsnort iptables-persistent libnotify-bin
sudo pip3 install Twisted
sudo pip install cryptography==38.0.4
sudo pip install pyopenssl==22.0.0

# Email input
email=$(whiptail --inputbox "Please provide the email address you wish notifications to be sent to: " 20 60 3>&1 1>&2 2>&3)

# Coniguring psad
echo "----Now configuring psad with the email you have provided using the psad.conf file----"
sed -i "s/__emailaddress__/$email/g" psad.conf
cp psad.conf /etc/psad/psad.conf # replace current config file with updated one
# Configuring ip logging
echo "----Updating the ip tables to enable logging.----"
sudo iptables -A INPUT -i lo -j ACCEPT # allow internal services to communicate
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT # allow traffic for existing connections
sudo iptables -A INPUT -p tcp --dport 9001 -j ACCEPT # allow ssh on alternate port that was configured
sudo iptables -A INPUT -j LOG # enable logging
sudo iptables -A FORWARD -j LOG # forward traffic
sudo iptables -A INPUT -j DROP # drop all other traffic
# sudo service iptables-persistent start # keep after reboot uncomment once tested
# enable psad
sudo psad --sig-update
sudo service psad restart
echo "----Port scanning attacks should now be monitored----"

# directory to store everything
mkdir /bin/HoneyPi
echo "---The running script can be found in /bin/HoneyPi----"
cp HoneyPot.py /bin/HoneyPi


