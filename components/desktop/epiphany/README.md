## GNOME Web (epiphany)

This is the GNOME Web browser, formerly known as 'epiphany'.

To build and run, you need the [webkitgtk4](../webkitgtk4/) package
from this repo, in place of webkitgtk4 from the Solaris userland gate,
as the webkitgtk4 in the userland gate has JIT disabled, while the
one here does not.  You need JIT for a reasonable browser experience.

By default, this package depends on the icu from the userland gate.
If you are running under 11.3 and have dependencies on the existing
icu, then build the [icu-gcc](../../icu-gcc) in this repo and uncomment
the relevant lines in the Makefile to use it.

Performance is decent relative to Firefox.  Compare the results of the
JetStream test:

### GNOME Web 3.30.2 powered by WebKitGTK+ 2.22.3 (64-bits)
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/epiphany/screenshot-epiphany.png "Epiphany/WebKitGTK+")
(Shown using the [nimbus-gtk3](../../look-and-feel/nimbus-gtk3/)
theme, available in this repo.)

### Firefox 68.3.0 ESR (64-bits)
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/epiphany/screenshot-firefox-68.3.0.png "Firefox 68.3.0esr")
(Shown using the [firefox-nimbus-theme](https://github.com/RocketMan/firefox-nimbus-theme).)
