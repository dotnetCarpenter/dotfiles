#!/bin/bash

# can be run with:
# setsid alertmemory.sh >/dev/null 2>&1 < /dev/null &
# or
# alertmemory.sh >/dev/null 2>&1 </dev/null &

CHECK_FAST=2
CHECK_SLOW=20
CHECK_EVERY=$CHECK_FAST
THRESHOLD=4

checkRam () {
	free=$(free -mt | grep Total | awk '{print $4}')
	available=$(free -mt | grep Total | awk '{print $2}')
	available_in_percent=`echo "scale=2;$free / $available * 100" | bc`
	available_in_percent_rounded=${available_in_percent%.*}
	message="$available_in_percent% ($free MB) out of $available MB RAM left"

	if [[ "$available_in_percent_rounded" -le $THRESHOLD ]]; then
		notify-send --urgency=normal --expire-time=10000 "WARNING: $message"
		CHECK_EVERY=$CHECK_SLOW
	else
		CHECK_EVERY=$CHECK_FAST
	fi

#	echo "debug: free $free available $available available_in_percent $available_in_percent available_in_percent_rounded $available_in_percent_rounded"
	echo $message
}

while sleep $CHECK_EVERY; do checkRam; done
