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

tar xf nexus-2.13.0-01-bundle.tar.gz -C /usr/local/src
ln -s /usr/local/src/nexus-2.13.0-01 /usr/local/nexus

chown -R nexus:nexus /usr/local/src/nexus-2.13.0-01
chown -R nexus:nexus /usr/local/src/sonatype-work
su - nexus -c "/usr/local/nexus/bin/nexus start"

