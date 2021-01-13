#!/bin/bash
yum install httpd -y
myip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<h2>Webserver with IP: $myip</h2><br>Terraform the best</br>" > /var/www/html/index.html
sudo service httpd start
