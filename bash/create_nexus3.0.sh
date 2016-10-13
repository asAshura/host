#!/bin/bash

apt install maven

if [ $? -ne 0 ]; then
	exit 1
fi
useradd -m nexus

tar xf jdk1.8.tar.gz -C /usr/local/src
ln -s /usr/local/src/jdk1.8.0_101 /usr/local/jdk

cat >> /etc/profile << EOF
        export JAVA_HOME=/usr/local/jdk
        export JRE_HOME=/usr/local/jdk/jre
        export PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin
EOF

source /etc/profile

tar xf nexus-3.0.1-01-unix.tar.gz -C /usr/local/src
ln -s /usr/local/src/nexus-3.0.1-01 /usr/local/nexus

mkdir /usr/local/nexus/data/log
chown -R nexus:nexus /usr/local/src/nexus-3.0.1-01
su - nexus -c "/usr/local/nexus/bin/nexus run &"

