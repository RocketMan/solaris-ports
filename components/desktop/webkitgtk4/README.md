## WebKitGTK+

This is a replacement for the `library/desktop/webkitgtk4` package found
in the Solaris userland gate.

This package provides the latest stable webkitgtk4 with Just-In-Time
JavaScript compiler, which is needed if you want to run with the
epiphany browser (available in this repo).

RocketMan's patches to fix JIT for Solaris, as well as fixes for the
gtk3 scroll bar warp have landed upstream.  As of WebKitGTK+ 2.24.0,
they are included in the upstream release!

## Requirements

To build WebKitGTK+, you will need GStreamer 1.14.4 or later.
Specifically, the packages `gstreamer`, `gst-plugins-base`, and
`gst-plugins-good` are required.  (It is no longer necessary to have
`gst-plugins-bad` for GL support in WebKit.)

## Screenshot
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/webkitgtk4/screenshot.png "Epiphany/WebKitGTK+")
