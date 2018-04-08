#!/bin/sh

# Disable the infrared receiver (IR) on a macbook with libinput
# Find the IR and its id on the device list:
# xinput list

# The id in this case is 13, so:
# xinput list-props 13
# One line from that command shows:
# Device Enabled (141) = 1

# This means, the option 141 has value 1 (meaning the IR is active),
# to disable it:
# xinput set-prop 13 141 0
