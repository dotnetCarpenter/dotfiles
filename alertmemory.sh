#!/bin/bash

# can be run with:
# setsid alertmemory.sh >/dev/null 2>&1 < /dev/null &
# or
# alertmemory.sh >/dev/null 2>&1 </dev/null &

CHECK_FAST=2
CHECK_SLOW=20
CHECK_EVERY=$CHECK_FAST
THRESHOLD=2
CRITICAL_THRESHOLD=1

checkRam () {
	local free=$(free -mt | grep Total | awk '{print $4}')
	local available=$(free -mt | grep Total | awk '{print $2}')
	local available_in_percent=`echo "scale=2;$free / $available * 100" | bc`
	local available_in_percent_rounded=${available_in_percent%.*}
	local message="$available_in_percent% ($free MB) out of $available MB RAM left"
	local urgency="normal"
	local prefix="WARNING"

	if [[ "$available_in_percent_rounded" -le $THRESHOLD ]]; then
		CHECK_EVERY=$CHECK_SLOW

		if [[ "$available_in_percent_rounded" -le $CRITICAL_THRESHOLD ]]; then
			urgency="critical"
			prefix="CRITICAL"
		fi

		notify-send --urgency=$urgency "$prefix: $message"
	else
		CHECK_EVERY=$CHECK_FAST
	fi

#	echo "debug: free $free available $available available_in_percent $available_in_percent available_in_percent_rounded $available_in_percent_rounded"
	echo $message
}

while sleep $CHECK_EVERY;
do echo $CHECK_EVERY
checkRam;
done
