#!/bin/bash
# Record NOAA APT / ISS audio via rtl_fm
# Usage: record_noaa.sh [FREQUENCY_MHZ]
# Example: record_noaa.sh 137.100

FREQ=${1:-137.620}   # Default: NOAA 15
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin

# Reset dongle before recording
/usr/local/bin/rtl_test -t 2>/dev/null || true
sleep 2

/usr/local/bin/rtl_fm -f "${FREQ}M" -s 60000 -g 49 -p 0 - | \
  /opt/homebrew/bin/sox -t raw -r 60000 -e s -b 16 -c 1 - \
  ~/noaa_$(date +%Y%m%d_%H%M).wav rate 11025
