#!/bin/bash

#Pull updates from github
git pull

#Add all new local files
git add .

#Create commit note with today's date
git commit -m "'date'" .

#Push updates to github
git push

#Stop script
exit 0
