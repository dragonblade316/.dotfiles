
# Replace these with your actual monitor's input values
DP_INPUT="x0f"
HDMI_INPUT="x12"

# Get the current input source (using --brief for easier parsing)
current_input=$(ddcutil getvcp 60 --brief --sleep-multiplier 0.01 | awk '{print $NF}')

if [[ "$current_input" == "$HDMI_INPUT" ]]; then
    # Currently on HDMI, switch to DisplayPort
    echo "Switching to DisplayPort..."
    ddcutil setvcp 60 "$DP_INPUT" --sleep-multiplier 0.01
elif [[ "$current_input" == "$DP_INPUT" ]]; then
    # Currently on DisplayPort, switch to HDMI
    echo "Switching to HDMI..."
    ddcutil setvcp 60 "$HDMI_INPUT" --sleep-multiplier 0.01
else
    echo "Unknown current input: $current_input. Please check your input values."
    echo "Attempting to switch to HDMI as a fallback..."
    ddcutil setvcp 60 "$DP_INPUT" --sleep-multiplier 0.01
fi

