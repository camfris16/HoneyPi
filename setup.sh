#!/bin/bash

# check root
if [ $UID -ne 0 ]
then
 echo "Please run this script as root: sudo setup.sh"
 exit 1
fi

if (whiptail --yesno "Welcome to the HoneyPi Installer! This program will make some changes to the Raspberry Pi (Changing MAC Address etc.) so enter 'no' now to exit or 'yes' to continue" 20 60); then
    echo "continue"
else
    exit 1
fi

# updating OS
echo "Just updating the OS if it needs to be"
sudo apt-get update && sudo apt-get upgrade -y