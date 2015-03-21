#!/bin/bash

#
# https://github.com/solvskogen-frostlands/battchrg
# 

#storing system_profiler output:
sysprofiler="$(system_profiler SPPowerDataType|grep -A4 'Charge Information')"

#current capacity in mAh:
currcap=$(echo "${sysprofiler}"|grep 'Remaining'|awk '{print $4}')

#full capacity in mAh:
fullcap=$(echo "${sysprofiler}"|grep 'Full Charge'|awk '{print $5}')

remaining=$(awk "BEGIN {printf \"%.1f\", 10*${currcap}/${fullcap}}")
remaining_tens=$(echo $remaining|awk -F'.' '{print $1}')
remaining_ones=$(echo $remaining|awk -F'.' '{print $2}')
      
echo $remaining
bgcolor=$(tput sgr 7)
echo $bgcolor$remaining_tens-$remaining_ones

if  [ $remaining_tens -ge 9 ] ; then
    echo greaterthanorequalto
fi

