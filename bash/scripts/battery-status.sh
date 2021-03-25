#!/bin/bash

function output {
  if (($battery_level < 20)); then echo "  $1 $battery_level%"; fi
  if (($battery_level < 50 && $battery_level >= 20)); then echo "  $1 $battery_level%"; fi
  if (($battery_level < 80 && $battery_level >= 50)); then echo "  $1 $battery_level%"; fi
  if (($battery_level < 99 && $battery_level >= 80)); then echo "  $1 $battery_level%"; fi
}

battery_level=$(acpi --battery | awk --field-separator=', ' '{ print $2 }' | tr --delete '%')
battery_status=$(acpi --battery | awk --field-separator=' ' '{ print $3 }' | tr --delete ',')

case "$battery_status" in
  "Charging") output "ﮣ";;
  "Discharging") output;;
  "Full") echo "  100%";;
  "Unknow") echo " Unknown Status";;
esac
