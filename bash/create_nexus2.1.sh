#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "this performance need root privileges to excute"
	exit 1
fi

if [ -e /etc/redhat-release ]; then
	yum install maven -y	
else
	apt install maven -y
fi

useradd -m nexus

java -version
if [ $? -ne 0 ]; then
	wget http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz
	tar xf jdk-8u101-linux-x64 -C /usr/local/src
	ln -s /usr/local/src

	cat >> /etc/profile << EOF
        export JAVA_HOME=/usr/local/jdk
        export JRE_HOME=/usr/local/jdk/jre
        export PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin
EOF
	source /etc/profile
fi

wget http://download.sonatype.com/nexus/oss/nexus-2.13.0-01-bundle.tar.gz
tar xf nexus-2.13.0-01-bundle.tar.gz -C /usr/local/src
ln -s /usr/local/src/nexus-2.13.0-01 /usr/local/nexus

chown -R nexus:nexus /usr/local/src/nexus-2.13.0-01
chown -R nexus:nexus /usr/local/src/sonatype-work
su - nexus -c "/usr/local/nexus/bin/nexus start"

