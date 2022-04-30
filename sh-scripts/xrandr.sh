if [ "$HOSTNAME" = myh2910 ]; then
	xrandr --output "eDP1" --primary \
		--output "HDMI1" --right-of "eDP1"
fi
