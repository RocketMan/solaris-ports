## APC UPS Power Monitor

This package allows the computer to interact with APC uninterruptible
power supplies (UPS) from Schneider Electric.

Edit the configuration file /etc/apcupsd/apcupsd.conf to suit your
setup, then enable the service with `svcadm enable apcupsd`.

See apcupsd.conf(5) for configuration file customization options.

### Important note for USB cabling

If you are using a USB connection to the UPS, the device must attach
to the ugen(7D) driver rather than hid(7D), which it does by default.

Assuming the UPS has device id `usb51d,2`, run (as root):

    add_drv -n -m '* 644 root sys' -i '"usb51d,2"' ugen

If this fails with a message like *("usb51d,2") already in use as a
driver or alias*, run:

    update_drv -a -m '* 644 root sys' -i '"usb51d,2"' ugen

In /var/adm/messages, if you see (bad):

    Oct 15 14:22:45 m5a97 usba: [ID 912658 kern.info] USB 1.10 device (usb51d,2) operating at low speed (USB 1.x) on USB 1.10 root hub: input@1, hid7 at bus address 2

it has bound to the hid driver.  You want to see (good):

    Oct 15 14:59:36 m5a97 usba: [ID 912658 kern.info] USB 1.10 device (usb51d,2) operating at low speed (USB 1.x) on USB 1.10 root hub: input@1, ugen0 at bus address 2
