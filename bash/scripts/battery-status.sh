#!/bin/bash

function output {
  if (($battery_level < 20)); then
    echo "  $1$battery_level%"
    if [ $battery_status != 'Charging' ]; then
      dunstify --appname="battery" --urgency="critical" "Low Battery" "Battery below to 20%"
    fi
  fi
  if (($battery_level < 50 && $battery_level >= 20)); then echo "  $1$battery_level%"; fi
  if (($battery_level < 80 && $battery_level >= 50)); then echo "  $1$battery_level%"; fi
  if (($battery_level < 99 && $battery_level >= 80)); then echo "  $1$battery_level%"; fi
}

battery_level=$(acpi --battery | grep -o -P '.{0,3}%' | sed 's/.$//')
battery_status=$(acpi --battery | grep -o -P '\s\w{4,},' | sed 's/.$//' | tr --delete ' ')

case "$battery_status" in
  "Charging") output "ﮣ";;
  "Discharging") output;;
  "Full") echo "  100%";;
  "Unknow") echo " Unknown Status";;
  *) echo "Info Not Available";;
esac
