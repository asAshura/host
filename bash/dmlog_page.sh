#!/bin/bash - 
#===============================================================================
#
#          FILE: dmlog_page.sh
# 
#         USAGE: ./dmlog_page.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2016年09月30日 16时52分29秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

source="log-testing"

#!/bin/bash

if [ ! -d /var/log/$source/`date +%Y`/`date +%m` ]; then
	mkdir -p /var/log/$source/`date +%Y`/`date +%m`
fi

mv /var/log/$source.log /var/log/$source/`date +%Y`/`date +%m`/$source.log-`date +%F`

service $source restart
