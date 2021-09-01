#!/bin/bash

echo Please enter the name of your drive
read drive
echo Copying files from /Volumes/$drive ...
cp /Volumes/$drive/.ssh ~/

echo Restricting permissions of ssh keys ...
chmod 600 id_rsa
chmod 644 id_rsa.pub
chmod 644 known_hosts
echo All set!