#! /bin/bash
NETWORK="xfinitywifi"
#NETWORK="#SFWiFi"

while true; do
	sleep 1
	STRINGQUALITY=$(iwconfig wlan0 | grep  Quality)
	QUALITY=${STRINGQUALITY:23:2}
	echo "Quality: $QUALITY"
	SIZE=${#QUALITY} 
	if [ "$SIZE" = "0" ]; then
		## If there is no connection, attempt to connect to xfinity
		echo "Connection lost, trying to reconnect..."
		echo "Disconnecting from $NETWORK"
		
		##TODO: pick one of the three alternatives! (or a better one)

		#nmcli c down id $NETWORK

		#nmcli d disconnect iface wlan0 

		nmcli nm wifi off
		nmcli nm wifi on

		echo "Attempting to reconnect to $NETWORK"
		nmcli c up id $NETWORK --timeout 5
	else
		if [ "$QUALITY" -lt "20" ]; then
			## If you have a poor quality connection attempt to connect again 
			echo "Attempting reconnection for poor quality"
			echo "Disconnecting from $NETWORK"

			##TODO: pick one of the three alternatives! (or a better one)

			nmcli c down id $NETWORK

			#nmcli d disconnect iface wlan0

			nmcli nm wifi off
			nmcli nm wifi on

			echo "Attempting to reconnect to $NETWORK"
			nmcli c up id $NETWORK --timeout 5
		fi
	fi
done

