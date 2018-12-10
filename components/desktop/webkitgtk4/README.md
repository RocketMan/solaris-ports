## WebKitGTK+

This is a replacement for the `library/desktop/webkitgtk4` package found
in the Solaris userland gate.

Differences between this package and the userland gate are as follows:

  1. This package provides the latest stable webkitgtk4, which is needed
to build the epiphany browser (available in this repo).

  2. The userland gate builds webkitgtk4 with JIT disabled.  This
package delivers webkitgtk4 with JIT enabled.  JIT is essential for
reasonable performance when using webkit in a general purpose browser.

  3. Under GTK, webkit always warps the scrollbar when clicking in the
trough.  Some themes such as nimbus-gtk3 (found in this repo) follow
the legacy GTK behaviour to paginate rather than warp when clicking in
the scroll trough.
  This package fixes webkit to follow the `gtk-primary-button-warps-slider`
preference with respect to button clicks in the scrollbar trough.  Thus,
for themes such as Adwaita, the scrollbar will warp as usual, whereas for
nimbus-gtk3, it will paginate as expected.

## Requirements

To build WebKitGTK+, you will need [GStreamer 1.14.4](../gstreamer/),
available in this repo.  Specifically, version 1.14.4 of `gstreamer`,
`gst-plugins-base`, and `gst-plugins-good` are required.  (It is no
longer necessary to have `gst-plugins-bad` for GL support in WebKit.)

By default, this package depends on the icu from the userland gate.
If you are running under 11.3 and have dependencies on the existing
icu, then build the [icu-gcc](../../icu-gcc) in this repo and uncomment
the relevant lines in the Makefile to use it.

## Screenshot
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/webkitgtk4/screenshot.png "Epiphany/WebKitGTK+")
