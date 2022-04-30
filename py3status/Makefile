all: py3status.myh2910.conf

py3status.%.conf: main.conf order.%.conf tagline
	cat $^ > $@
