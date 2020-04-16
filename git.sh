#!/bin/bash

#Set git user details
git config --global user.name "Hydruid"
git config --global user.email "trey.hunsucker@gmail.com"

#Pull updates from github
git pull

#Add all new local files
git add .

#Create commit note with today's date
git commit -m "`date`" .

#Push updates to github
git push

#Stop script
exit 0
