#!/bin/bash
if [ $# -ge 2 ]; then
	local_file=$1
	dest_server=$2
else
	echo "invalid argument"
	echo "usage:$0 local_file_location destination_server"
	exit 1
fi

fqdn=$dest_server.huairuisheng.com


if [ ! -e ~/.ssh/id_rsa.pub ]; then
	ssh-keygen -t rsa
fi

temp=`ssh ppm@$fqdn "mktemp"`

if [ ! -n $temp ]; then
	echo "trust had built"
	ssh ppm@$fqdn "rm -f $temp"	
else
	ssh-copy-id -i ~/.ssh/id_rsa.pub ppm@$fqdn
fi

dest_dir=${local_file%-*}
scp $local_file ppm@$fqdn:/usr/share/nginx/html/ppm/$dest_dir

if [ $? -eq 0 ]; then
	echo "transfer succeed"
fi
