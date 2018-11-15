## GNOME Web (epiphany)

This is the GNOME Web browser, formerly known as 'epiphany'.

To build and run, you need the [webkitgtk4](../webkitgtk4/) package
from this repo, in place of webkitgtk4 from the Solaris userland gate.
In addition, you will need `libdazzle`, also found in this repo.

Performance is decent relative to Firefox.  Compare the results of the
JetStream test:

### GNOME Web 3.30.2 powered by WebKitGTK+ 2.22.3 (64-bits)
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/epiphany/screenshot-epiphany.png "Epiphany/WebKitGTK+")
(Shown using the [nimbus-gtk3](../../look-and-feel/nimbus-gtk3/)
theme, available in this repo.)

### Firefox 52.9.0 ESR (32-bits)
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/epiphany/screenshot-firefox.png "Firefox")

