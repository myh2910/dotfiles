#!/bin/bash

# Supports desktop files, so handled by systemd or dex:
# * xfce power manager
# * nm applet
# * copyq
# * flameshot
# * syncthing-gtk? unclear
#
# dropbox no longer, started manually

xss-lock -n ~/dotfiles/sh-scripts/lock-warning.sh -- ~/dotfiles/sh-scripts/fuzzy-lock.sh &

if [ "$(hostname)" = myh2910 ]; then
	picom -C -G -b --no-fading-openclose
	redshift-gtk &
	systemctl --user start evansync.timer
	dunst &
	source ~/dotfiles/conky/setup.sh &
	ibus-daemon -d -r &
fi
