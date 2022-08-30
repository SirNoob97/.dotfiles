#!/bin/env bash

set -u -o pipefail

# the 'brightness' file belongs to root, so keep that in mind

basedir="/sys/class/backlight"
handler="$basedir/$(ls $basedir)"

old_brightness=$(cat "$handler/brightness")
max_brightness=$(cat "$handler/max_brightness")

# get current brightness %
old_brightness_p=$(( 100 * $old_brightness / $max_brightness ))

# calculate new brightness %
new_brightness_p=$(($old_brightness_p $1))

[ 100 -lt $new_brightness_p ] && new_brightness_p=100
[ 0 -ge $new_brightness_p ] && new_brightness_p=10

# calculate new brightness value
new_brightness=$(( $max_brightness * $new_brightness_p / 100 ))

echo $new_brightness > "$handler/brightness"
