#!/bin/bash - 
#===============================================================================
#
#          FILE: log-analysis.sh
# 
#         USAGE: ./log-analysis.sh 
# 
#   DESCRIPTION: judge pv of nginx
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2016年09月09日 19时17分37秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/bin/bash
read -p "enter day you want: default is *: " day
read -p "enter month you wnat: such as Dec,Oct. default is *: " month
read -p "enter year you want: default is *:" year
read -p "enter log location: " location

tmp=*
lct=./access.log

d=${day:-*}
m=${month:-*}
y=${year:-*}
l=${location:-./access.log}

grep "\[$d\/$m\/$y" $l| awk '{print $1}' | sort | wc -l
