FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit systemd
inherit obmc-phosphor-systemd

RDEPENDS:${PN}-monitor += "bash"
RDEPENDS:${PN} += "bash"

SRC_URI += " \
            file://phosphor-multi-gpio-monitor.json \
            file://led-flashingON.sh \
            file://led-flashingOFF.sh \
           "

SYSTEMD_SERVICE:${PN}-monitor += " \
                                  obmc-led-flashingON.service \
                                  obmc-led-flashingOFF.service \
                                 "

FILES:${PN}-monitor += " \
                        /usr/share/${PN}/phosphor-multi-gpio-monitor.json \
                        /usr/sbin/led-flashingON.sh \
                        /usr/sbin/led-flashingOFF.sh \
                       "

SYSTEMD_LINK:${PN}-monitor:append = " ../phosphor-multi-gpio-monitor.service:multi-user.target.requires/phosphor-multi-gpio-monitor.service"

do_install:append() {
    install -d ${D}${sbindir}
    install -m 0644 ${WORKDIR}/phosphor-multi-gpio-monitor.json ${D}${datadir}/${PN}/
    install -m 0755 ${WORKDIR}/led-flashingON.sh ${D}${sbindir}/
    install -m 0777 ${WORKDIR}/led-flashingOFF.sh ${D}${sbindir}/
}
