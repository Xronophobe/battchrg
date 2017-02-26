#!/bin/bash
#

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

#text style
n_bl="5;" #blinking
n_bo="1;" #bold

#script-wide variables
batt_tens=0
batt_ones=0
is_charging=0


get_battery_data() {
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
    if [[ $battery_data =~ $re ]]; then
        currcap=${BASH_REMATCH[0]}
        if [[ $currcap =~ [0-9]{1,4} ]]; then
           currcap=${BASH_REMATCH[0]} 
        fi
    fi
    
    remaining=$(awk "BEGIN {printf \"%.1f\", 10*${currcap}/${fullcap}}")
    echo $remaining 
}


function set_text_color {
    text_style="${esc}${n_bo}"

    if [ $1 -le 2 ]; then 
        text_style="${text_style}${t0_2}"
        oMH="36;"
        oLO="30;"
        if [ $1 -lt 2 ]; then
            text_style="${text_style}${n_bl}"
        fi
    fi

    case $2 in
        8|9) text_style="${text_style}${oHI}";;
        6|7) text_style="${text_style}${oMH}";;
        4|5) text_style="${text_style}${oMI}";;
        2|3) text_style="${text_style}${oML}";;
        0|1) text_style="${text_style}${oLO}";;
    esac
}


function display_battery {
    batt_tens=$(echo $1|cut -f1 -d. )
    batt_ones=$(echo $1|cut -f2 -d. )

    set_text_color $batt_tens $batt_ones
    echo -e "${text_style}m$batt_tens${cn0}"
}

display_battery $( get_battery_data )
#display_battery $1
