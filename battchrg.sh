#!/bin/bash

#
# https://github.com/solvskogen-frostlands/battchrg
# 

text_style="${esc}${n_bo}"

#defining colors
esc='\033['
cn0="${esc}0m"

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

#text style
n_bl="5;" #blinking
n_bo="1;" #bold

remaining=0
currcap=0
fullcap=0

battery_data=$NULL
get_battery_data() {
    re=''
    #storing system_profiler output:
    battery_data=$(system_profiler SPPowerDataType\
                |grep -A3 'Charge Remaining'
                )

    re="Full( )([[:alpha:]_]+( )){2}(\(mAh\)):( )[0-9]{1,4}"
    if [[ $battery_data =~ $re ]]; then
        fullcap=${BASH_REMATCH[0]}

        if [[ $fullcap =~ [0-9]{1,4} ]]; then
            fullcap=${BASH_REMATCH[0]}
        fi
    fi
    
    re="Remaining( )(\(mAh\)):( )[0-9]{1,4}"
    if [[ $test =~ $re ]]; then
        currcap=${BASH_REMATCH[0]}

        if [[ $currcap =~ [0-9]{1,4} ]]; then
           currcap=${BASH_REMATCH[0]} 
        fi
    fi

    #echo remaining 10.0 format 
}

#function set_color
# put switch-cases here from below
# text_style variable is already declared above

function display_battery {
    #set_color
    echo -e "${text_style}m$1${cn0}"
}

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

