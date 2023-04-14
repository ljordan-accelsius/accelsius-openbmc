#!/bin/sh
# Toggle the state of identify LED Group

echo "ON Service Called"

#set gpio value to 1
gpioset 0 8=1
echo "LED ON"

