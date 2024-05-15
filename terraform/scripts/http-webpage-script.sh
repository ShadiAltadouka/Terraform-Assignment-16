#!/bin/bash

sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo vi /var/www/html/index.html
sudo echo this is $HOSTNAME > /var/www/html/index.html 