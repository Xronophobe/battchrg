#!/bin/bash

#
# https://github.com/solvskogen-frostlands/battchrg
# 

function print_tens_color {
    echo "$1${remaining_tens}${cn0}"
}


#defining colors
c09='\033[0;32m'
c87='\033[0;36m'
c65='\033[1;33m'
c43='\033[0;33m'
c21='\033[0;31m'
cn0='\033[0m'

#ps -p $$

#storing system_profiler output:
sysprofiler="$(system_profiler SPPowerDataType|grep -A4 'Charge Information')"

#current capacity in mAh:
currcap=$(echo "${sysprofiler}"|grep 'Remaining'|awk '{print $4}')

#full capacity in mAh:
fullcap=$(echo "${sysprofiler}"|grep 'Full Charge'|awk '{print $5}')

remaining=$(awk "BEGIN {printf \"%.1f\", 10*${currcap}/${fullcap}}")
remaining=$1
remaining_tens=$(echo $remaining|awk -F'.' '{print $1}')
remaining_ones=$(echo $remaining|awk -F'.' '{print $2}')
      
#echo $remaining
#bgcolor=$(tput sgr 7)
#echo $bgcolor$remaining_tens-$remaining_ones


echo $remaining_tens-$remaining_ones

if [ $remaining_tens -gt 2 ]; then
    case $remaining_ones in
    #    9|0) echo -e "${c09}$remaining_tens${cn0}";;
        9|0) print_tens_color ${c09};;
        7|8) print_tens_color ${c87};;
        5|6) print_tens_color ${c65};;
        3|4) print_tens_color ${c43};;
        1|2) print_tens_color ${c21};;
    esac
else
    echo "29 and down"
fi
