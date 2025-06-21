HEADSET="alsa_output.usb-HP__Inc_HyperX_Cloud_Alpha_Wireless_00000001-00.analog-stereo"
SPEAKERS="alsa_output.pci-0000_03_00.1.hdmi-stereo-extra4"

current_output=$(pactl get-default-sink)

if [[ "$current_output" == "$HEADSET" ]]; then
    echo "Switching to speaker."
    pactl set-default-sink $SPEAKERS
elif [[ "$current_output" == "$SPEAKERS" ]]; then 
    echo "Switching to headset."
    pactl set-default-sink $HEADSET
else
    echo "Unknown output, switching to headset"
    pactl set-default-sink $HEADSET
fi
