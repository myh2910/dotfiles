#!/bin/bash

if pgrep -U $(whoami) i3lock > /dev/null
then
	echo "Already running"
	exit
fi

if pgrep -U $(whoami) stepmania > /dev/null
then
	echo "Stepmania running"
	# xset s off -dpms # don't blank screen if stepmania is running
	exit
fi

if pgrep -U $(whoami) zoom > /dev/null
then
	echo "Zoom running"
	exit
fi

if [ -f "$HOME/.cache/ctwenty.lock" ]; then
	echo "ctwenty.lock running"
	exit
fi

# mute microphone so I'm not recorded while afk
ponymix -t source mute > /dev/null

if pacman -Q --quiet i3lock-color; then
	export LANG=ko_KR.UTF-8
	i3lock \
		--insidever-color=0a220a66     \
		--ringver-color=0a550aee       \
		--insidewrong-color=efaaaabb   \
		--ringwrong-color=ef0a0aff     \
		--inside-color=00000000        \
		--ring-color=dd0add66          \
		--line-color=0a0a0aff          \
		--separator-color=ff66ff44     \
		--verif-color=efefef77         \
		--wrong-color=efefefff         \
		--modif-color=efefef99         \
		--time-color=aa33aabb          \
		--date-color=aa33aabb          \
		--layout-color=dededebb        \
		--keyhl-color=dd888899         \
		--bshl-color=dd888899          \
		--keylayout 2                  \
		--radius 180                   \
		--ring-width 20                \
		--date-str="%Y년 %m윌 %d일 %A" \
		--time-size=35                 \
		--date-size=24                 \
		--layout-size=30               \
		--verif-size=35                \
		--wrong-size=35                \
		--modif-size=32                \
		--time-str="%p %I:%M:%S %Z"    \
		--date-pos="ix:iy-0.22*r"      \
		--wrong-pos="ix:iy-0.1*r"      \
		--verif-pos="ix:iy-0.1*r"      \
		--modif-pos="ix:iy+0.1*r"      \
		--time-pos="ix:iy+0.1*r"       \
		--layout-pos="ix:iy+0.5*r"     \
		--color 111117dd               \
		--show-failed-attempts         \
		--ignore-empty-password        \
		--nofork                       \
		--indicator
else
	i3lock \
		--beep \
		--ignore-empty-password \
		--show-failed-attempts \
		--nofork \
		--color=d33529 \
		--pointer=win
fi

if pgrep -U $(whoami) py3status > /dev/null
then
	killall -s USR1 py3status
fi
