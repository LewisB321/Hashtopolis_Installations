#!/bin/sh

##Check that user is root, script will end if not

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

##Asking the user for 2 variables which will be used later in the script
echo "How much memory would you like hashtopolis to use (in MBs)? (i.e. 2048M, can be changed later) "
read memorylimit
echo "And what's the maximum filesize that you'd like to be uploadable to hashtopolis (in MBs)? (i.e. 1024M, can be changed later)"
read filesize 

##Upgrade the system before any installation occurs

apt update -y
apt upgrade -y

##Prerequisite installation and configuration

for software in mysql-server apache2 libapache2-mod-php php-mysql php php-gd php-pear php-curl git expect
do
	apt install -y $software
done

service mysql start
service apache2 start

##Use expect to interact with mysql_secure_installation
chmod a+x mysqlsecure_expect_script
./mysqlsecure_expect_script 


##Piping essential commands into mysql to make the database, the user and give them proper rights
echo "CREATE DATABASE hashtopolis" | mysql -uroot -pROOThashtopolisPASSWORD32!
echo "CREATE USER 'hashtopolis'@'localhost' IDENTIFIED BY 'HASHuserPASSWORD1!'" | mysql -uroot -pROOThashtopolisPASSWORD32!
echo "GRANT ALL PRIVILEGES ON hashtopolis.* TO 'hashtopolis'@'localhost'" | mysql -uroot -pROOThashtopolisPASSWORD32!
echo "FLUSH PRIVILEGES" | mysql -uroot -pROOThashtopolisPASSWORD32!

##Copy essential files from the official hashtopolis github repo and change ownership to all www data
cd /var/www
git clone https://github.com/s3inlc/hashtopolis.git
chown -R www-data:www-data /var/www/hashtopolis

##Appending important stuff to the apache2 configuration to point the default webpage to hashtopolis
sed -i 's_/var/www/html_/var/www/hashtopolis/src_' /etc/apache2/sites-available/000-default.conf | echo "editing apache file" #editing the text file to replace /html with /hashtopolis/src. -i is used to save the changes
echo "<Directory /var/www/hashtopolis/src>" >> /etc/apache2/sites-available/000-default.conf
echo "	AllowOverride All" >> /etc/apache2/sites-available/000-default.conf
echo "</Directory>" >> /etc/apache2/sites-available/000-default.conf #appending important stuff to the same file


##Using sed to alter a few entries in the php initialisation file to allow for larger file uploads and more memory usage
file="/etc/php/7.2/apache2/php.ini"
sed -i 's_limit = 128M_limit = '"$memorylimit"'_' "$file" 
sed -i 's_filesize = 2M_filesize = '"$filesize"'_' "$file" 
sed -i 's_size = 8M_size = '"$filesize"'_' "$file" 
##The syntax of these commands are a little awkward. Will not work if file no longer contains default values, but i'm assuming it will since it's a fresh install

service apache2 reload

##Not completely sure how this works but it's necessary to access the final web browser steps
chown -R www-data:www-data . 

##Just a temporary storage location for these 2 important passwords. Should be removed/protected afterwards
cd /
echo "root sql user pass = ROOThashtopolisPASSWORD32!" > passes.txt
echo "hashtopolis sql user pass = HASHuserPASSWORD1!" >> passes.txt

##Cleaning up
apt purge expect -y
rm Hashtopolis_Server_Install.sh
rm mysqlsecure_expect_script

echo " "
echo "############################################################################################"
echo "   Installation is now complete! Please finish the final steps in the web browser        "
echo "############################################################################################"
echo " "
