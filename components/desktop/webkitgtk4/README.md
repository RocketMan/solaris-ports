## WebKitGTK

This is a replacement for the `library/desktop/webkitgtk4` package found
in the Solaris userland gate.

This package provides the latest stable WebKitGTK with JIT (Just-In-Time)
JavaScript compiler, which is needed if you want to run with the
epiphany browser (available in this repo).

In addition, as of WebKitGTK 2.40.0, there is support for WebGL2!

**IMPORTANT:** This package provides webkitgtk4 built with libsoup2
for use with legacy applications.  For epiphany, use
[webkitgtk41](../webkitgtk/webkitgtk41) (gtk3 + libsoup3) or for gtk4
applications, use [webkitgtk60](../webkitgtk/webkitgtk60) (gtk4 + libsoup3).


## Screenshots
![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/webkitgtk4/screenshot.png "Epiphany/WebKitGTK")

![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/webkitgtk4/screenshot2.png "Epiphany/WebKitGTK")

![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/webkitgtk4/screenshot3.png "Epiphany/WebKitGTK")

![screenshot](https://raw.githubusercontent.com/RocketMan/solaris-ports/master/components/desktop/webkitgtk4/screenshot4.png "Epiphany/WebKitGTK")
