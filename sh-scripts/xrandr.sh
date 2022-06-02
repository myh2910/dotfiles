if [ "$HOSTNAME" = myh2910 ]; then
	xrandr --output "eDP1" --primary \
		--output "HDMI1" --auto --right-of "eDP1"
fi
