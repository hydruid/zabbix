#!/bin/bash

#Variables
ZVERshort="4.4"
ZVERlong="4.4-1+bionic_all.deb"
UD="YES"

#Update OS before Install
if [ $UD == "YES" ]
then
	echo "Starting OS update..." && bash update.sh
fi

#Download and Install the Zabbix Deb
wget -nc https://repo.zabbix.com/zabbix/$ZVERshort/ubuntu/pool/main/z/zabbix-release/zabbix-release_$ZVERlong
sudo dpkg -i zabbix-release_$ZVERlong
rm -fr zabbix-release_$ZVERlong

#Stop script
exit 0
