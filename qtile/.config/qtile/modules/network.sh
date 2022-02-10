#!/bin/bash

connection=$(nmcli --terse --fields='TYPE,STATE,CONNECTION' device status \
  | grep ':connected:')

device_type="${connection%%:*}"
connection_name="${connection##*:}"
output=

case $device_type in
  wifi) output='直';;
  ethernet) output='';;
  *);;
esac

echo $output
