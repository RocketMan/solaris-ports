## glib2-extras

Older versions of library/glib2 did not include the SMF services:

    * svc:/application/desktop-cache/gio-module-cache
    * svc:/application/desktop-cache/glib-compile-schemas

In particular, glib-compile-schemas is needed before you install
gnome-mplayer.

If you are planning to install gnome-mplayer, install this package
first, or check to see that glib-compile-schemas already exists on
your system.

If these services have already been installed by glib2, then
installation of this package will fail.
