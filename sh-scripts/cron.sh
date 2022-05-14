#!/bin/bash

# This piece of software is not written by me.
# It's a program that'll read the next 14 days of my calendar
# and output the results under ~/.cache/agenda.json
# where it can be consumed by e.g. conky
if command -v gcalendar > /dev/null
then
	~/dotfiles/sh-scripts/get-cal.sh
fi

## SYNC TASKWARRIOR
if command -v task > /dev/null
then
	task rc.gc=on sync
fi
# bugwarrior-pull
task sync

## PACMAN SNAPSHOTS
if [ -f /bin/pacman ]; then
	pacman -Qqtten > ~/Sync/pacman/$(hostname).pacman.paclist
	pacman -Qqttem > ~/Sync/pacman/$(hostname).aur.paclist
	if [ "$(hostname)" = "ArchDiamond" -a "$(whoami)" = "evan" ]; then
		cd ~/Sync/pacman/
		if ! git diff --exit-code; then
			git commit -a -m "$(hostname) $(date)"
		fi
	fi
fi
