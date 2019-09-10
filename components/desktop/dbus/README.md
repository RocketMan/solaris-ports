## dbus

This is a replacement for the packages `system/library/dbus`,
`system/library/libdbus`, and `system/library/dbus/dbus-x11` found in
the Solaris userland gate.

Unlike the Solaris packages, with these packages, system dbus services
are enabled under a new, dedicated user 'dbus'.  As a result, they are
unprivileged.  Access to privileged operations is mediated through
`dbus-daemon-launch-helper`.  See
https://dbus.freedesktop.org/doc/system-activation.txt for more
information.

System services are required for, among other things, geolocation/geoclue.

As system services introduce additional vectors to access privileged
information, you should review carefully your requirements and use
this package only as needed.
