#!/usr/bin/env bash

# Get connected bluetooth device
DEVICE=$(bluetoothctl info | grep "Device" | awk '{print $2}')

if [ -z "$DEVICE" ]; then
  echo ""
  exit 0
fi

# Query battery via upower
BATTERY=$(upower -i /org/freedesktop/UPower/devices/headset_dev_${DEVICE//:/_} 2>/dev/null \
  | grep percentage | awk '{print $2}')

if [ -n "$BATTERY" ]; then
  echo "$BATTERY"
else
  echo "?"
fi
