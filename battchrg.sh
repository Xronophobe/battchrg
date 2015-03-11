#!/bin/bash

sysprofiler="$(system_profiler SPPowerDataType | grep -A4 'Charge Information')"
echo "${sysprofiler}"

#currcap=$($sysprofiler | grep "Charge Remaining" | awk '{print$4}')
echo ""
#currcap="${sysprofiler})"

currcap=`awk 'BEGIN{print "'$sysprofiler'"}'`

#fullcap=$($sysprofiler | grep "Full Charge Capacity" | awk '{print$5}')
#fullcap=$($sysprofiler | grep "Full Charge Capacity" )


echo "${currcap}"

echo $fullcap
