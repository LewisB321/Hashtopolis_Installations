#! /bin/sh

##The purpose of this script is to install an agent on an Ubuntu machine.

##Check that user is root, script will end if not

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

##Asking the user where the script needs to look for the zip file, useful for later
echo "What is the IP address of the hashtopolis server? (IPv4)"
read serversource

apt upgrade -y
apt update -y

##Prerequisite installation

apt install -y python3-pip zip curl
pip3 install requests psutil

##Getting zip file from the server
curl http://"$serversource"/agents.php?download=1 -so agent.zip

##Cleaning up
rm Hashtopolis_Agent_Install.sh

echo " "
echo "############################################################################################"
echo "    Installation is now complete! Run python3 agent.zip to finish the configuration       "
echo "############################################################################################"
echo " "


