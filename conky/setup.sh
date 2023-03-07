#/bin/bash

sleep 5
if [ "$(hostname)" = myh2910 ]; then
	conky -c ~/dotfiles/conky/thin-bar-1366x768.conf
	# conky -c ~/dotfiles/conky/cal2.conf
fi
