#!/bin/bash

#
# https://github.com/solvskogen-frostlands/battchrg
# 

function get_battery_data {
    #TODO
    echo ''
}

function print_tens_color {
    #echo -e "${esc}$2$3$4m${remaining_tens}${cn0}"
    echo -e "${text_style}m${remaining_tens}${cn0}"
}

function display_battery {
    echo -e "${text_style}m pina ${cn0}"
}

#defining colors
esc='\033['
cn0="${esc}0m"
#general styling patterns
#autocolor="${esc}${styl}${fg}${bg}"

#text style
n_bl="5;" #blinking
n_bo="1;" #bold

#text background
t7_9="47;"
t3_6="46;"
t0_2="41;"

#text foreground
o12="31;"
o34="35;"
o56="33;"
o78="34;"
o90="32;"

#storing system_profiler output:
sysprofiler=$(system_profiler SPPowerDataType\
            |grep -A4 'Charge Information'\
            )

#current capacity in mAh:
currcap=$(echo "${sysprofiler}"\
        |grep 'Remaining'\
        |awk '{print $4}'\
        )

#full capacity in mAh:
fullcap=$(echo "${sysprofiler}"\
        |grep 'Full Charge'\
        |awk '{print $5}'\
        )

remaining=$(awk "BEGIN {printf \"%.1f\", 10*${currcap}/${fullcap}}")
remaining=$1
remaining_tens=$(echo $remaining|awk -F'.' '{print $1}')
remaining_ones=$(echo $remaining|awk -F'.' '{print $2}')
      
echo $remaining_tens-$remaining_ones

text_style="${esc}${n_bo}"

if [ $remaining_tens -ge 7 ]; then
    text_style="${text_style}${t7_9}"
    case $remaining_ones in
    #    9|0) echo -e "${c09}$remaining_tens${cn0}";;
        9|0) print_tens_color ${c09};;
        7|8) print_tens_color ${c87};;
        5|6) print_tens_color ${c65};;
        3|4) print_tens_color ${c43};;
        1|2) print_tens_color ${c21};;
    esac
elif [ $remaining_tens -gt 2 ]; then 
    echo "greater than 29 but less than 70"
    text_style="${text_style}${t3_6}"
elif [ $remaining_tens -eq 2 ]; then
    echo "29 and down"
    text_style="${text_style}${t0_2}"
else
    text_style="${text_style}${t0_2}${n_bl}"
    display_battery $text_style
fi

