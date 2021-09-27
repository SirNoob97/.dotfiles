#!/bin/bash

CHARGING="Charging"
FULL="Full"
DISCHARGING="Discharging"
UNKNOWN="Unknown"

battery_status="$UNKNOWN"
battery_percentage=
battery_icon="?"
battery_output=

function __cmd_exist {
    unalias "$1" >/dev/null 2>&1
    command -v "$1" >/dev/null 2>&1
}

function __set_variables {
    battery_status=$(acpi | awk '{print $3}' | tr -d ',')
    battery_percentage=$(acpi | awk '{print $4}' | tr -d ',')

    [ -n "$battery_status" ] && [ "$battery_status" = "$CHARGING" ] && battery_output="${battery_percentage} "
    [ -n "$battery_status" ] && [ "$battery_status" = "$FULL" ] && battery_output="${battery_percentage} "
}

function __output {
    if [ -n "$battery_status" ] && [ -n "$battery_percentage" ]; then
	percentage=${battery_percentage%%%}

	if [ "$battery_status" = "$DISCHARGING" ]; then
	    [ $percentage -gt 75 ] && [ $percentage -lt 97 ] && battery_icon=""
	    [ $percentage -gt 45 ] && [ $percentage -lt 75 ] && battery_icon=""
	    [ $percentage -gt 15 ] && [ $percentage -lt 45 ] && battery_icon=""
	    [ $percentage -lt 12 ] && battery_icon="" \
		&& dunstify -a "$0" -u "CRIT" -t "10000" "Low Battery" "Battery level below 12%"
	fi
    fi 

    [ -n "$battery_output" ] && echo $battery_output || echo "$battery_percentage $battery_icon"
}

if __cmd_exist acpi; then
    __set_variables
    __output
fi


