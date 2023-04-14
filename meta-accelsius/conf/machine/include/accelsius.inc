DISTROOVERRIDES .= ":accelsius"

MACHINE_FEATURES += "\
        obmc-bmc-state-mgmt \
        obmc-phosphor-fan-mgmt \
        obmc-phosphor-flash-mgmt \
        "

VIRTUAL-RUNTIME_skeleton_workbook = "${MACHINE}-config"

PREFERRED_PROVIDER_virtual/obmc-chassis-mgmt = "packagegroup-accelsius-apps"
PREFERRED_PROVIDER_virtual/obmc-fan-mgmt = "packagegroup-accelsius-apps"
PREFERRED_PROVIDER_virtual/obmc-flash-mgmt = "packagegroup-accelsius-apps"
PREFERRED_PROVIDER_virtual/obmc-inventory-data ?= "${VIRTUAL-RUNTIME_skeleton_workbook}"
PREFERRED_PROVIDER_virtual/obmc-system-mgmt = "packagegroup-accelsius-apps"

#IMAGE_FEATURES:remove = "obmc-ikvm"

SERIAL_CONSOLES:accelsius = "115200;ttyS4"
