#!/bin/bash

sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo vi /var/www/html/index.html
sudo echo this is $HOSTNAME > /var/www/html/index.html