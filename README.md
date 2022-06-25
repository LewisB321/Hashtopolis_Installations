# Hashtopolis_Installations

The scripts in this repository are for the installation and configuration of a Hashtopolis server as well as 
Agents used for the password cracking process. All credit for this application go to S3inlc and others
who worked on the project alongside him. I take no credit for any development, this is simply a collection
of scripts written by me to make the process simpler. The official Github for Hashtopolis is https://github.com/hashtopolis

# Prerequisites to running the scripts

I highly recommend using devices running Ubuntu, preferrably 18.04. I recommend this because this is what I used
The server installation must be first, otherwise the agent/client will not be able to download what it needs
You must be root user. I recommend running Server_Install.sh in the root directory also
This machine must not have any prior instance of mysql, php or apache2. I recommend using a fresh Ubuntu instance to avoid conflicts
Server_Install.sh (or Server_Install_With_Input.sh) must be in the same directory as mysql_secure_install
Server and Agent(s) should reside on the same network. If you wish to place onto different networks, further work must be done

# mysqlsecure_expect_script

If you are familiar with expect, you will understand how this works. If not, this script, when called by the main install
script, will interact with the mysql_secure_installation script to make sql more 'secure'. This is obviously optional if
you prefer to create your own custom mysql instance. Feel free to remove if required.

# Server_Install.sh & Server_Install_With_Input.sh

You need only use one of these scripts. If you are deploying this just for recreation, I recommend Server_Install. This
script provides pre-made passwords for mysql users. In any other circumstance, With_Input would probably be better.
This script will run through the installation procedure of Hashtopolis and run right up until you must finalise the
configuration in your web browser.

Depending on the script, you will be asked 2/4 things. Please note that if these passwords are too weak they may not
be accepted and the final configuration may fail. The reason for this is that mysqlsecure_expect_script sets the default
password strength policy to max. If you wish for a weak password, I would remove this and run mysql_secure_installation
manually.

The other 2 things concern Hashtopolis interactions with PHP. Memory size is the maximum amount of memory that the browser
is permitted to use and filesize is the maximum permitted size of a file which you may upload to Hashtopolis. If you would
like to upload large dictionaries, you must specify. Please note that these can be altered later.

The script outputs a text file called passes.txt which contain the pre-determined passwords. I recommend 
removing this file or password protecting it, the choice is yours.

The final steps to installation are in the web browser. Just type in localhost into the browser to get started. After that 
the server installation should be comnplete and you will be able to log into the web interface.

# Agent

By comparison this script is much smaller and doesn't really save you a lot of time, but is useful nonetheless if you
plan on having multiple agents. Agents can be ran on the same device as the server but I do not recommend this. You may
also have >1 agent on a single device, as long as the .zip activation files are in seperate directories

You will need the IP of the hashtopolis server (if you are running this on the same device as the server, 'localhost' should also work.
When the script is finished running, the command 'python3 agent.zip' should be ran to finish agent configuration. You will need the url of the
Hashtopolis API running on your server (you can view this on the server, on the 'new agent' tab) and the voucher code, which is a randomly generated
string used for agent activation. 
The good news is that you need only do this once. After this, the agent will start recursively querying the server for tasks until manually stopped. You
may use the same command again to open the agent, which will begin querying straight away.

here are some useful links for other Hashtopolis resources. I highly recommend viewing these beforehand
to get a better understanding of what the scripts do:
https://hackingvision.com/2020/03/30/distributed-hash-cracking-hashcat-hashtopolis-tutorial/ - Comprehensive Tutorial
https://www.youtube.com/watch?v=O08gddjVbfc&t=5s - Server installation guide (by creator)
https://hashtopolis.org/ - Hashtopolis forum with FAQs, HowTos and Issues

If you would like to use the 'reset password' email feature, https://kenfavors.com/code/how-to-install-and-configure-sendmail-on-ubuntu/
is a brief but useful guide to do so. Please note that many larger mail clients such as Gmail and Outlook will disregard these emails unless
the server has a legitimate PTR record in your dns (if you are using this as part of a domain)
