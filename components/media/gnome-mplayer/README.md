## Gnome MPlayer

Gnome-MPlayer is a GTK2/GTK3 interface for MPlayer.  See

    https://code.google.com/archive/p/gnome-mplayer/

for more information.

## Prerequisites

The SMF service `svc:/application/desktop-cache/glib-compile-schemas` is
needed before you install gnome-mplayer.

Normally, library/glib2 provides the above SMF service.  However,
older versions of library/glib2 did not include it.

**IMPORTANT:** Before you install gnome-mplayer, check to see that the
above referenced SMF service exists on your system.  If not, you can
install the package:

    library/glib2-extras

from the https://github.com/RinTinCan/solaris-ports collection.  This
package provides the necessary SMF service.
