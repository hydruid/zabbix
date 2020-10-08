#!/bin/bash

#Variables
ZVERshort="5.0"
ZVERlong="5.0-1+focal_all.deb"
UD="YES"

#Update OS before Install
if [ $UD == "YES" ]
then
	echo "Starting OS update..." && sudo bash update.sh
fi

#Download and Install the Zabbix Deb
wget -nc -4 https://repo.zabbix.com/zabbix/$ZVERshort/ubuntu/pool/main/z/zabbix-release/zabbix-release_$ZVERlong
sudo dpkg -i zabbix-release_$ZVERlong
rm -fr zabbix-release_$ZVERlong

#Install additional Zabbix packages
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent -y

#Reload service
sudo systemctl reload apache2

#Create MySQL Database and import Zabbix schema
sudo mysql -uroot -e "CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;"
sudo mysql -uroot -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabpass';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -uroot -e "FLUSH PRIVILEGES;"
clear && echo "Enter the password for the zabbix MySQL user:"
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix 

#Update Zabbix server config file with DBPassword
sudo sed -i 's/# DBPassword=/DBPassword=zabpass/g' /etc/zabbix/zabbix_server.conf 

#Backup Apache config file and Update Timezone
sudo cp /etc/zabbix/apache.conf /etc/zabbix/apache.conf.orig
sudo sed -i 's|# php_value date.timezone Europe/Riga|php_value date.timezone America/Chicago|g' /etc/zabbix/apache.conf

#Restart and enable services at boot
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

#Stop script
exit 0
