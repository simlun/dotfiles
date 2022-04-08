#!/bin/bash -e
export LC_ALL=en_US.utf-8

DATE_SYMBOL=$(echo -e '\U0001F4C5')
DATE=$(date +'%Y-%m-%d %H:%M')

BATTERY_SYMBOL=$(echo -e '\U0001F50B')
BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

if [ "$BATTERY_STATUS" = "Discharging" ]; then
    BATTERY_TIME_TO=", $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'time to empty' | cut -d : -f 2 | xargs | sed 's/hours/h/g')"
elif [ "$BATTERY_STATUS" = "Charging" ]; then
    BATTERY_TIME_TO=", $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'time to full' | cut -d : -f 2 | xargs | sed 's/hours/h/g' | sed 's/minutes/min/g')"
else
    BATTERY_TIME_TO=""
fi
BATTERY="${BATTERY_SYMBOL} ${BATTERY_STATUS} [${BATTERY_CAPACITY}%${BATTERY_TIME_TO}]"

#WIFI_SYMBOL=$(echo -e '\U0001F4F6')
#WIFI_ESSID=$(iwgetid -r)
#WIFI_ESSID=$(iwconfig wlo1 | grep -oE "ESSID:\".+\"" | cut -d : -f 2 | tr -d \")
#WIFI_QUALITY=$(iwconfig wlo1 | grep -oE "Link Quality=([0-9]+)/([0-9]+)" | cut -d = -f 2)
#WIFI_SIGNAL=$(iwconfig wlo1 | grep -oE "Signal level=.+ dBm" | cut -d = -f 2 | cut -d ' ' -f 1)
#WIFI="${WIFI_SYMBOL} ${WIFI_ESSID} [${WIFI_QUALITY}, ${WIFI_SIGNAL_LEVEL}]"

if route -n | grep gpd0 2>&1 > /dev/null; then
    VPN_SYMBOL=$(echo -e '\U0001F512')
    #VPN_DESCRIPTION=$(globalprotect show --details | grep -oE "Gateway Description:.+" | cut -d : -f 2 | xargs)
    VPN_DESCRIPTION="VPN"
    VPN=" ${VPN_SYMBOL} ${VPN_DESCRIPTION}"
else
    VPN=""
fi

S=$WIFI_SIGNAL
WIFI_SIGNAL_LEVEL=$(if [ $S -lt -90 ]; then echo Worst; elif [ $S -lt -70 ]; then echo Bad; elif [ $S -lt -67 ]; then echo OK; elif [ $S -lt -50 ]; then echo Good; elif [ $S -lt 0 ]; then echo Excellent; fi)

LOAD_SYMBOL=$(echo -e '\U0001F525')
LOAD=$(uptime | grep -oE "load average: .+" | cut -d : -f 2 | xargs)

echo -e "${WIFI}${VPN} ${BATTERY} ${LOAD_SYMBOL} ${LOAD} ${DATE_SYMBOL} ${DATE}"
