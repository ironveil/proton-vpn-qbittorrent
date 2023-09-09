#!/bin/bash

# Get current IP
CURRENT_IP="$(curl -s ip.me)"

# VPN IP
VPN_IP="146.70.179.21"

# Check if running
QBITTORRENT_RUNNING="$(pgrep qbittorrent-nox)"

# Check if running & connected to server
if [ $CURRENT_IP == $VPN_IP ] && [ ! $QBITTORRENT_RUNNING ]; then

	# Get open port
	OPEN_PORT="$(/usr/bin/python3 /usr/bin/natpmp-client.py -g 10.2.0.1 0 0 | grep -Eo '[0-9]{5}' | tail -1)"

	# Run desired program
	qbittorrent-nox --torrenting-port=$OPEN_PORT &>/dev/null & disown

elif [ $CURRENT_IP != $VPN_IP ] && [ $QBITTORRENT_RUNNING ]; then

	# Kill desired program >:)
	killall qbittorrent-nox

fi
