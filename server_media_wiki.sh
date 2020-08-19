#!/bin/bash
# This script will help you to setup Media wiki package on the server
# Installing the required packages.
dnf install httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json wget -y

# Enable database and the httpd server
systemctl enable mariadb
systemctl enable httpd

# Download the mediawiki package 
cd /home/ec2-user
wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz.sig
gpg --verify mediawiki-1.34.2.tar.gz.sig mediawiki-1.34.2.tar.gz

# Untar the file and create a soft link
cd /var/www
tar -zxf /home/ec2-user/mediawiki-1.34.2.tar.gz
ln -s mediawiki-1.34.2/ mediawiki

# Find and replace strings in httpd.conf file
cd /etc/httpd/conf/
sed -i 's:/var/www/html:/var/www:g' httpd.conf
sed -i 's:DirectoryIndex index.html:DirectoryIndex index.html index.html.var index.php:g' httpd.conf
export password=wiki

# Get the database endpoint from RDS server.
aws rds describe-db-instances --region=us-east-1 --query "DBInstances[*].Endpoint.Address" >> /opt/rds
echo "export database=$(cat /opt/rds | grep rds* | tr -d '"' | tr -d ' ')" > ~/database.sh
echo "export password=wikipass" >> ~/database.sh
chmod +x ~/database.sh
sudo cp ~/database.sh /etc/profile.d/database.sh
source /etc/profile

# Change the ownership
chown -R apache:apache /var/www/mediawiki-1.34.2

# Restart the httpd service
service httpd restart

# Allow selinux if it is enabled
restorecon -FR /var/www/mediawiki-1.34.2/
restorecon -FR /var/www/mediawiki
setenforce 0
getenforce


