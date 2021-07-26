#!/bin/bash

default="--------------------"
lines="${default}\n$(task next rc.verbose=nothing rc.defaultwidth=200)"
chosen=$(echo -e "$lines" | rofi -dmenu -i -p "taskwarrior")

if [ -z "$chosen" ]; then
	echo "Empty"
elif [ "$chosen" = "$default" ]; then
	echo "Default"
elif [[ "$lines" = *"$chosen"* ]]; then
	taskid=$(echo $chosen | awk '{print $1}')
	echo $taskid
	task $taskid done
else
	task add $chosen
fi

killall -s USR1 py3status
task sync
