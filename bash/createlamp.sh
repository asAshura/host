#!/bin/bash
# This script create lamp on CentOS 7

if [ $UID -nq 0 ]; then
	echo "need root"
	exit 1
fi

yum install -y httpd
systemctl start httpd
systemctl enable httpd
firewall-cmd --permanent --add-service=http
systemctl restart firewalld

curl `ifconfig | awk -F'[ :]+' 'NR==2{print $3}'` 2>&1 > /dev/null

if [ $? -ne 0 ]; then
	echo "httpd problem"
	exit 2
else
	echo "process 1/3"
fi
echo "-------------------------------------"

yum install mariadb-server mariadb -y
systemctl start mariadb
systemctl enable mariadb
mysql_secure_installation

if [ $? -ne 0 ]; then
	echo "mariadb problem"
	exit 3
else
	echo "process 2/3"
fi
echo "-------------------------------------"

yum install php php-mysql php-gd php-pear -y
systemctl restart httpd

if [ $? -ne 0 ]; then
	echo "php problem"
	exit 4
else
	echo "process 3/3"
fi
echo "-------------------------------------"
