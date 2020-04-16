#!/bin/bash

#Refresh repo's, Install Updates, and Remove stale packages without prompting
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

#Stop script
exit 0
