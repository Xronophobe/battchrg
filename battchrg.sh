#!/bin/bash

#
# https://github.com/solvskogen-frostlands/battchrg
# 


#defining colors
esc='\033['
cn0="${esc}0m"

#text style
n_bl="5;" #blinking
n_bo="1;" #bold

#text background
t7_9="40;"
t3_6="40;"
t0_2="41;"

#text foreground
oHI="32;"
oMH="34;"
oMI="37;"
oML="33;"
oLO="31;"

oLMH="36;"
oLLO="37;"


function get_battery_data {
    #storing system_profiler output:
    battery_data=$(system_profiler SPPowerDataType\
                |grep -A4 'Charge Information'\
                )
    re="(Remaining \(mAh\): )[1-9]{1,4}"
    if [[ $battery_data =~ $re ]]; then
        remaining=${BASH_REMATCH[0]:17}
    fi
    echo $remaining
}

get_battery_data

get_current_capacity(){
    #current capacity in mAh:
    currcap=$(echo "${sysprofiler}"\
            |grep 'Remaining'\
            |awk '{print $4}'\
            )

    return $currcap
}

get_full_capacity(){
    #full capacity in mAh:
    fullcap=$(echo "${sysprofiler}"\
            |grep 'Full Charge'\
            |awk '{print $5}'\
            )

    return $fullcap
}

function get_remaining {
    remaining=$(awk "BEGIN {printf \"%.1f\", 10*${currcap}/${fullcap}}")

    echo "$remaining"
}

function display_battery {
    echo -e "${text_style}m${remaining_tens}${cn0}"
}

get_battery_data
remaining=$?
remaining_tens=$(echo $remaining|awk -F'.' '{print $1}')
remaining_ones=$(echo $remaining|awk -F'.' '{print $2}')

text_style="${esc}${n_bo}"

if [ $remaining_tens -gt 2 ]; then 
#    if [ $remaining_tens -ge 7 ]; then
#        text_style="${text_style}${t7_9}"
#    else
#        text_style="${text_style}${t3_6}"
#    fi

    case $remaining_ones in
        8|9) text_style="${text_style}${oHI}";;
        6|7) text_style="${text_style}${oMH}";;
        4|5) text_style="${text_style}${oMI}";;
        2|3) text_style="${text_style}${oML}";;
        0|1) text_style="${text_style}${oLO}";;
    esac

    display_battery $text_style
else
    text_style="${text_style}${t0_2}"
    if [ $remaining_tens -lt 2 ]; then
        text_style="${text_style}${n_bl}"
    fi
    
    case $remaining_ones in
        8|9) text_style="${text_style}${oHI}";;
        6|7) text_style="${text_style}${oLMH}";;
        4|5) text_style="${text_style}${oMI}";;
        2|3) text_style="${text_style}${oML}";;
        0|1) text_style="${text_style}${oLLO}";;
    esac

    display_battery $text_style
fi

