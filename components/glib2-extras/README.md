## glib2-extras

Older versions of library/glib2 did not include the SMF services:

    * svc:/application/desktop-cache/gio-module-cache
    * svc:/application/desktop-cache/glib-compile-schemas

If these services have already been installed by glib2, then
installation of this package will fail.
