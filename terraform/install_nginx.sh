#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
wget https://my-bucket-andersen-dev.s3.eu-central-1.amazonaws.com/index.html -P /var/www/html/
#sudo chmod 777 /var/www/html/index.html
echo $(hostname) >> /var/www/html/index.html