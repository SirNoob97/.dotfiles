#!/bin/bash

CHARGING="charging"
FULL="full"
DISCHARGING="discharging"
UNKNOWN="unknown"

battery_status="$UNKNOWN"
battery_percentage=
battery_icon="?"
battery_output=

notification_bin=
notification_level=

function __cmd_exist {
  unalias "$1" >/dev/null 2>&1
  command -v "$1" >/dev/null 2>&1
}

function __set_notification {
  case "$1" in
    dunstify)
      notification_bin="dunstify"
      notification_level="CRIT"
      ;;
    notify-send)
      notification_bin="notify-send"

      # this should be critical, but xfce4-notified can't stack notifications
      # so this is a hacked way to keep a clean screen
      notification_level="normal"
      ;;
    *)
      exit 1
      ;;
  esac
}

function __set_variables {
  case "$1" in
    acpi)
      battery_status=$(acpi | awk '{print $3}' | tr -d ',')
      battery_percentage=$(acpi | awk '{print $4}' | tr -d ',')
      ;;
    upower)
      awk_pattern='{if($2 ~ /fully-charged/) print "full"; else print $2}'
      battery_device=$(upower -e | grep BAT0)
      battery_status=$(upower -i "$battery_device" | grep 'state' | awk "$awk_pattern")
      battery_percentage=$(upower -i "$battery_device" | grep 'percentage' | awk '{print $2}')
      ;;
    *)
      exit 1
      ;;
  esac

  [ -n "$battery_status" ] && [ "${battery_status,,}" = "$CHARGING" ] \
    && battery_output="${battery_percentage} ﮣ"

  [ -n "$battery_status" ] && [ "${battery_status,,}" = "$FULL" ] \
    && battery_output="${battery_percentage} "
}

function __output {
  if [ -n "$battery_status" ] && [ -n "$battery_percentage" ]; then
	  percentage=${battery_percentage%%%}

	  if [ "$battery_status" = "$DISCHARGING" ]; then
	    [ $percentage -gt 89 ] && [ $percentage -lt 100 ] && battery_icon=""
	    [ $percentage -gt 79 ] && [ $percentage -lt 90 ] && battery_icon=""
	    [ $percentage -gt 69 ] && [ $percentage -lt 80 ] && battery_icon=""
	    [ $percentage -gt 59 ] && [ $percentage -lt 70 ] && battery_icon=""
	    [ $percentage -gt 49 ] && [ $percentage -lt 60 ] && battery_icon=""
	    [ $percentage -gt 39 ] && [ $percentage -lt 50 ] && battery_icon=""
	    [ $percentage -gt 29 ] && [ $percentage -lt 40 ] && battery_icon=""
	    [ $percentage -gt 19 ] && [ $percentage -lt 30 ] && battery_icon=""
	    [ $percentage -lt 12 ] && battery_icon="" \
		  && $notification_bin -a "$0" -u $notification_level -t "10000" \
      "Low Battery" "Battery level below 12%"
	  fi
  fi

  [ -n "$battery_output" ] && echo $battery_output || echo "$battery_percentage $battery_icon"
}

if __cmd_exist dunstify; then
  __set_notification dunstify
fi

if __cmd_exist notify-send; then
  __set_notification notify-send
fi

if __cmd_exist acpi; then
  __set_variables acpi
fi

if __cmd_exist upower; then
  __set_variables upower
fi

__output
