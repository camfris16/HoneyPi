# HoneyPi
Honey Pot made using a Raspberry Pi 4 model B
This has only been tested on the official Raspbian Operating System so there is no guarantee it will fully work on another operating system. This is only compatible with Linux based systems.

Installation:
1. Ensure you have downloaded setup.sh, HoneyPot.py and psad.conf.
2. Make setup.sh executable by running 'sudo chmod +x setup.sh'
3. Run setup.sh with root privilege (sudo ./setup.sh)
4. Follow any on screen prompts
5. The pi should automatically restart after setup is complete, if not, please reboot the pi to finish installation.
6. Everything should now run automatically on startup -> scan the pi or connect to one of the services and check the logs!

Changes after installation:
- SSH port has been changed to 9001, decoy service is now using port 22
- Hostname is now FILESERVER
- MAC Address has been changed, so IP address may be different (MAC Address may or may not be changed successfully)
- Ports 21, 22, 23 and 9001 are now open
- Port 9001 should be used to access the pi remotely using SSH

Logs:
- There are 2 log file associated with the Honey Pot.
- Logs for connection attempts to the decoy services can be found at /opt/HoneyPi/logs.txt
- Logs for the Port Scan Attack Detction service can be found in  /var/log/psad
- You can also run 'sudo service psad status' to get recent events relating to the Port Scan Attack Detction service
