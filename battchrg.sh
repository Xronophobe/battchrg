#!/bin/bash


# https://github.com/solvskogen-frostlands/battchrg
#
# This script provides information about your remaining battery capacity while 
# not consuming too much space. It has been designed for being included in your
# shell prompt.
# The point is, using only one character for this purpose. So I ended up with
# this solution: the only number provided is going to be the number
# representing the tenths of the remaining battery capacity percentage. Its
# colors' purpose is to help you determine this percentage slightly more
# accurately as explained below:
#
#                                   LEGEND
#  SYMBOL   |   MEANING
#  -------------------- 
#
#  CHARACTERS:
#        F  | Battery is fully charged, or above 95%
#    0 - 9  | This number represent tenths of the remaining capacity (in %)
#    green  | Remaining capacity ends in either 0, 9, 8 or 7
#   yellow  | Remaining capacity ends in either 6, 5 or 4
#      red  | Remaining capacity ends in either 3, 2, or 1
#        E  | Battery has dropped below 20%. Becomes black if remaining
#             capacity percentage ends in 2, 1 or 0. Blinking at and below 10%
#
# BACKGROUND:
#     blue  | Battery is charging
#    white  | Battery is discharging
#      red  | Battery level dropped to or below 20%. Blinking at and below 10%
#
# I hope you will find this tool useful. Comments, bugreports are welcome at
#
#          https://github.com/solvskogen-frostlands/battchrg
# 


#storing system_profiler output:
sysprofiler="$(system_profiler SPPowerDataType | grep -A4 'Charge Information')"

#current capacity in mAh:
currcap=$(echo "${sysprofiler}" | grep 'Remaining' | awk '{print $4}')

#full capacity in mAh:
fullcap=$(echo "${sysprofiler}" | grep 'Full Charge' | awk '{print $5}')

remaining=$(awk "BEGIN {printf \"%.1f\", 10*${currcap}/${fullcap}}")
remaining_tens=$(echo $remaining | awk -F'.' '{print $1}')
echo "remainig tenths are: $remaining_tens"

#if [[ remaining > 9.5 ]]; then
#    remaining_tens='F'
#else
#    remaining_tens=$()
#    remaining_ones=$(echo $remaining | grep )

bgcolor=$(tput sgr 7)
echo $bgcolor$remaining

#echo $currcap
echo $fullcap
#echo $remaining
