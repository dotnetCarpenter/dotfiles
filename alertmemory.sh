#!/bin/bash

# can be run with:
# setsid alertmemory.sh >/dev/null 2>&1 < /dev/null &
# or
# watch alertmemory.sh

free=$(free -mt | grep Total | awk '{print $4}')
available=$(free -mt | grep Total | awk '{print $2}')
available_in_percent=`echo "scale=1; $free / $available * 100" | bc`
message="$available_in_percent% ($free MB) out of $available MB"

if [[ "$free" -le 5  ]]; then
	notify-send --urgency=critical "WARNING: $message"
fi

echo $message
