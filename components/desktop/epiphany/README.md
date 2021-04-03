## GNOME Web (epiphany)

This is the GNOME Web browser, formerly known as 'epiphany'.

To build and run, you need the [webkitgtk4](../webkitgtk4/) package
from this repo, in place of webkitgtk4 from the Solaris userland gate,
as the webkitgtk4 in the userland gate has JIT disabled, while the
one here does not.  You need JIT for a reasonable browser experience.

### GNOME Web 40.0 with WebKitGTK+ 2.33.0 (SVN r275202)
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/epiphany/screenshot-epiphany-40.png "GNOME Web 40.0")
