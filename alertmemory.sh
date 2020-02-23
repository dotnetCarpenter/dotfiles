#!/bin/bash

# can be run with:
# setsid watch alertmemory.sh >/dev/null 2>&1 < /dev/null &
# or
# watch alertmemory.sh >/dev/null 2>&1 </dev/null &

free=$(free -mt | grep Total | awk '{print $4}')
available=$(free -mt | grep Total | awk '{print $2}')
available_in_percent=`echo "scale=1;$free / $available * 100" | bc`
available_in_percent_rounded=${available_in_percent%.*}
message="$available_in_percent% ($free MB) out of $available MB RAM left"

if [[ "$available_in_percent_rounded" -le 50 ]]; then
	notify-send --urgency=critical "WARNING: $message"
fi

echo $message
