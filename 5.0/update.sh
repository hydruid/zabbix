#!/bin/bash

#Refresh repos, Install Updates, and Remove stale packages without prompting
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

#Refresh repos one last time
sudo apt-get update

#Stop script
exit 0
