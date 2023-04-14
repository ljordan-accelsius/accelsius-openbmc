FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

OVERRIDES:append = "${@bb.utils.contains('VIRTUAL-RUNTIME_obmc-host-state-manager', 'phosphor-state-manager-host', ':phosphor-fan-with-psm', ':phosphor-fan-without-psm', d)}"

PHOSPHOR_FAN_EXTRA_SERVICES = "obmc-poweroff.service"
PHOSPHOR_FAN_EXTRA_SERVICES:append:phosphor-fan-without-psm = " \
    obmc-chassis-hard-poweroff@.target \
    obmc-chassis-poweroff@.target \
    "

SRC_URI:append = " file://obmc-chassis-hard-poweroff@.target \
                               file://obmc-chassis-poweroff@0.target \
                               file://obmc-poweroff.service \
                               file://host-poweroff"

PACKAGECONFIG:append = " json sensor-monitor"

EXTRA_OEMESON = "-Duse-host-power-state=enabled"

RDEPENDS:sensor-monitor = " bash"
RDEPENDS:phosphor-fan = " bash"

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    for svc in ${PHOSPHOR_FAN_EXTRA_SERVCIES}; do
        install -m 0644 ${WORKDIR}/${svc} ${D}${systemd_system_unitdir}
    done

    install -m 0755 -d ${D}/var/lib/phosphor-fan-presence/sensor-monitor

    install -d ${D}/usr/libexec/phosphor-fan-sensor-monitor
    install -m 0777 ${WORKDIR}/host-poweroff ${D}/usr/libexec/phosphor-fan-sensor-monitor/
}

pkg_postinst:${PN}() {
    mkdir -p $D$systemd_system_unitdir/obmc-chassis-hard-poweroff@0.target.requires
    mkdir -p $D$systemd_system_unitdir/obmc-chassis-hard-poweroff@0.target.requires/obmc-chassis-poweroff@0.target.requires

    LINK="$D$systemd_system_unitdir/obmc-chassis-hard-poweroff@0.target.requires/obmc-chassis-poweroff@0.target"
    TARGET="../obmc-chassis-poweroff@0.target"
    ln -s $TARGET $LINK

    LINK="$D$systemd_system_unitdir/obmc-chassis-poweroff@0.target.requires/obmc-poweroff.service"
    TARGET="../../obmc-poweroff.service"
    ln -s $TARGET $LINK
}

FILES:sensor-monitor += "/usr/libexec/phosphor-fan-sensor-monitor/host-poweroff"
FILES:${PN} += "/lib/systemd/system/sensor-monitor.service"
FILES:sensor-monitor += "${systemd_system_unitdir}"
