#!/bin/sh

IP=192.168.20.1
GADGET_BASE=/sys/kernel/config/usb_gadget
USB_UDC=/sys/bus/platform/devices/1e6a2000.usb
NAME=netusb

free_port() {
    local p
    p=$(basename $USB_UDC)
    if ! test -e $USB_UDC/gadget/suspended; then
        echo $p
        return
    fi
    echo "All ports taken" >&2
    exit 1
}


usb_net_create()
{
    if [ -d $GADGET_BASE/$NAME ]; then
        echo "device $NAME already exists" >&2
        return 1
    fi
    mkdir $GADGET_BASE/$NAME
    cd $GADGET_BASE/$NAME

    echo 0x1d6b > idVendor  # Linux Foundation
    echo 0x0105 > idProduct # FunctionFS Gadget
    mkdir strings/0x409
    local serial="OBMCNET001"
    echo $serial > strings/0x409/serialnumber
    echo OpenBMC > strings/0x409/manufacturer
    echo "OpenBMC Net" > strings/0x409/product

    mkdir configs/c.1
    mkdir functions/rndis.$NAME
    mkdir configs/c.1/strings/0x409

    echo "Config-1" > configs/c.1/strings/0x409/configuration
    echo 120 > configs/c.1/MaxPower
    ln -s functions/rndis.$NAME configs/c.1
    echo $(free_port) > UDC
}

if test "$1" = stop; then
    ifconfig usb0 down
    rm -f $GADGET_BASE/$NAME/configs/c.1/rndis.$NAME
    rmdir $GADGET_BASE/$NAME/configs/c.1/strings/0x409
    rmdir $GADGET_BASE/$NAME/configs/c.1
    rmdir $GADGET_BASE/$NAME/functions/rndis.$NAME
    rmdir $GADGET_BASE/$NAME/strings/0x409
    rmdir $GADGET_BASE/$NAME
else
    usb_net_create
    ifconfig usb0 $IP
fi

