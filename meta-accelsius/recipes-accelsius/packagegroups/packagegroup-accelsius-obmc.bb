SUMMARY = "OpenBMC for Accelsius - Applications"
PR = "r1"
inherit packagegroup

PROVIDES = "${PACKAGES}"
RPROVIDES:${PN} = "${PACKAGES}"

PACKAGES:append = " \
    ${PN}-chassis \
    ${PN}-extras \
    ${PN}-fans \
    ${PN}-flash \
    ${PN}-system \
    ${PN}-inband \
    ${PN}-apps \
    "

PROVIDES:append = " virtual/obmc-chassis-mgmt"
PROVIDES:append = " virtual/obmc-fan-mgmt"
PROVIDES:append = " virtual/obmc-flash-mgmt"
PROVIDES:append = " virtual/obmc-system-mgmt"
#PROVIDES:append = " virtual/obmc-gpio-monitor"

RPROVIDES:${PN}-chassis = " virtual-obmc-chassis-mgmt"
RPROVIDES:${PN}-fans = " virtual-obmc-fan-mgmt"
RPROVIDES:${PN}-flash = " virtual-obmc-flash-mgmt"
RPROVIDES:${PN}-system = " virtual-obmc-system-mgmt"
RPROVIDES:${PN}-monitor = " virtual-obmc-gpio-monitor"

RDEPENDS:${PN}-fan-control = " \
        ${VIRTUAL-RUNTIME_obmc-fan-control} \
        phosphor-fan-monitor \
	"

SUMMARY:${PN}-chassis = "Accelsius Chassis"
RDEPENDS:${PN}-chassis = " \
    x86-power-control \
    "

SUMMARY:${PN}-fans = "Accelsius Fans"
RDEPENDS:${PN}-fans = " \
    phosphor-pid-control \
    "

SUMMARY:${PN}-flash = "Accelsius Flash"
RDEPENDS:${PN}-flash = " \
    phosphor-software-manager \
    "

SUMMARY:${PN}-system = "Accelsius System"
RDEPENDS:${PN}-system = " \
    phosphor-ipmi-ipmb \
    phosphor-hostlogger \
    phosphor-sel-logger \
    phosphor-post-code-manager \
    phosphor-host-postd \
    phosphor-gpio-monitor-monitor \
    phosphor-led-manager \
    phosphor-fan-sensor-monitor \
    "

SUMMARY:${PN}-inband = "Accelsius Inband Test"
RDEPENDS:${PN}-inband = " \
    phosphor-ipmi-ipmb \
    phosphor-ipmi-ssif \
    phosphor-ipmi-bt \
    phosphor-ipmi-kcs \
    "

SUMMARY:${PN}-apps = "Open Source Applications for OpenBMC Image"
RDEPENDS:${PN}-apps = " \
    ipmitool \
    at-scale-debug \
    "
