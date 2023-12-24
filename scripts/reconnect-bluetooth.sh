#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
    pre)
            #code execution BEFORE sleeping/hibernating/suspending (test)
            sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-mute alsa_output.pci-0000_04_00.6.HiFi__hw_Generic_1__sink 1 
	    /usr/bin/bluetoothctl disconnect 94:DB:56:84:F7:76; 
    ;;
    post)
            #code execution AFTER resuming
	    /usr/bin/bluetoothctl connect 94:DB:56:84:F7:76; 
    ;;
esac

exit 0

