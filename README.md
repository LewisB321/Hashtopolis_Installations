# Hashtopolis_Installations

These 2 scripts are for the installation and configuration of both a server and a client for the Hashtopolis web application for
password cracking. The server should be configured first.

#Server

This is a bash script which should be deployed on a fresh instance of ubuntu (tested with 18.04,
no idea about other vers)

You should run this script as root user, preferably in the root directory because this is where 
the temporary password file will be stored

You will need the expect script too inside of the same location. This will communicate with the
mysql_secure_installation on your behalf with the safest answers. Naturally, if you wish to do this yourself,
you can remove this from the script and run it yourself. Up to you

The script will ask you to input 2 things- the amount of memory you want hashtopolis to use and the
maximum file upload size. You can input whatever value you like, but please bear in mind it's in MB's only
i.e. 2048M = 2G

Passwords have been predetermind by me to be simple yet satisfy the sql password policy. These can be altered
in the scripts prior to execution but not after (I think sql root user can be changed, not user hashtopolis 
though). This can also be done via variables but I have not done this.

The script outputs a text file called passes.txt which contain the pre-determined passwords. I recommend 
removing this file or password protecting it at the minimum (which at the time I don't know how to do) 

The final steps to installation are in the web browser. Just type in localhost into the browser to get started

#Agent

This is a bash script which should be deployed on an ubuntu machine (tested with 18.04,
desktop ideal but server should work also). This script should be ran as root but it
matters not the location, just that it's a reasonable location

You will need the IP of the hashtopolis server and the 'voucher' code to activate the agent. After
the initial activation you must only run 'python3 agent.zip' for it to begin immediately

This script assumes that you are on the same network as the server. If this is not the case, 
the script will most likely fail. You would most likely need to edit /etc/hosts so the client 
can see the server. You can use host the server and an agent on the same machine, and you can also have
multiple agents for larger tasks. You may also have more than 1 agent on a single device but I would
not recommend to do so. You will have to run these agents in seperate directories

here are some useful links for other Hashtopolis resources. I highly recommend viewing these beforehand
to get a better understanding of what the scripts do:
https://hackingvision.com/2020/03/30/distributed-hash-cracking-hashcat-hashtopolis-tutorial/ - Comprehensive Tutorial
https://www.youtube.com/watch?v=O08gddjVbfc&t=5s - Server installation guide (by creator)
https://github.com/hashtopolis - Github repo
Good luck
