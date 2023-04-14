#!/bin/sh
# Toggle the state of identify LED Group

echo "OFF Service Called"
#set gpio value to 1
gpioset 0 8=0
echo "LED OFF"