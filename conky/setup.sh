#/bin/bash

sleep 5
if [ "$(hostname)" = ArchDiamond ]; then
	conky -c ~/dotfiles/conky/thin-bar.conf
	if [ "$(date +'%Z')" = "EDT" ]; then
		conky -c ~/dotfiles/conky/large-calendar.conf
	else
		conky -c ~/dotfiles/conky/huge-calendar.conf
	fi
fi

if [ "$(hostname)" = ArchMajestic ]; then
	conky -c ~/dotfiles/conky/shifted-bar.conf
	conky -c ~/dotfiles/conky/huge-calendar.conf
fi
