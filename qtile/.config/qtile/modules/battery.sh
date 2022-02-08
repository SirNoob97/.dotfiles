#!/bin/bash

CHARGING="charging"
FULL="full"
DISCHARGING="discharging"
UNKNOWN="unknown"

battery_status="$UNKNOWN"
battery_percentage=
battery_icon="?"
battery_output=

function __cmd_exist {
  unalias "$1" >/dev/null 2>&1
  command -v "$1" >/dev/null 2>&1
}

function __set_variables {
  case "$1" in
    acpi)
      battery_status=$(acpi | awk '{print $3}' | tr -d ',')
      battery_percentage=$(acpi | awk '{print $4}' | tr -d ',')
      ;;
    upower)
      battery_device=$(upower -e | grep BAT0)
      battery_status=$(upower -i "$battery_device" | grep 'state' | awk '{print $2}')
      battery_percentage=$(upower -i "$battery_device" | grep 'percentage' | awk '{print $2}')
      ;;
    *)
      exit 1
      ;;
  esac

  [ -n "$battery_status" ] && [ "${battery_status,,}" = "$CHARGING" ] && battery_output="${battery_percentage} "
  [ -n "$battery_status" ] && [ "${battery_status,,}" = "$FULL" ] && battery_output="${battery_percentage} "
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
  __set_variables acpi
  __output
fi

if __cmd_exist upower; then
  __set_variables upower
  __output
fi
