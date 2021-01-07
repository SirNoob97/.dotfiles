#!/bin/bash

bStatus=$(acpi | awk -F ': ' '{print $2}' | awk -F ', ' '{print $1}')
bPercentage=$(acpi | awk -F ', ' '{print $2}' | awk -F '%' '{print $1}')

if [[ $bStatus -eq 'Full' ]] && [[ $bPercentage -gt 95 ]]; then
  echo ""
fi

if [[ $bStatus -eq 'Discharging' ]] && [[ $bPercentage -lt 80 ]]; then
  echo ""
fi

if [[ $bStatus -eq 'Discharging' ]] && [[ $bPercentage -le 50 ]]; then
  echo ""
fi

if [[ $bStatus -eq 'Discharging' ]] && [[ $bPercentage -le 25 ]]; then
  echo ""
fi

if [[ $bStatus -eq 'Discharging' ]] && [[ $bPercentage -le 10 ]]; then
  echo ""
fi
