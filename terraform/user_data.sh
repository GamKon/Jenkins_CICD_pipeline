#!/bin/bash
yum -y update
yum -y install httpd
ip_private=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
ip_public=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo "This server's <br>Public IP: $ip_public <br>Local  IP: $ip_private" > /var/www/html/index.html
service httpd start
chkconfig httpd on

yum -y install docker
systemctl start docker
usermod -aG docker ec2-user

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/bin/docker-compose
