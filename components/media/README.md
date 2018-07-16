## Media collection

This is a collection of components for media manipulation and presentation.

## Prerequisites

Before building, you will need to install bison and flex (from the OS
distro or userland), as well as nasm and yasm (from this repo).  These
components are needed to build, but not to run the build targets.

## Building

Build and install components in the following order.  **It is necessary
to install the components from each numbered step before proceeding to
the next step.**

All of the components listed below may be obtained from this repo.

1.
    * **fribidi**
    * **lame**
    * **libcdio**
    * **libdvdcss**
    * **libfdk-aac**
    * **libid3tag**
    * **libopus**
    * **libvpx**
    * **libx264** (**see note)
    * **lzo**

    (**Note: libx264 builds two packages, libx264 and x264-utils.  At
    this point, it is necessary to install only libx264.  x264-utils has
    optional dependencies on ffmpeg; we will pick these up by rebuilding
    in a subsequent step below).


2.
    * **libass** _(needs fribidi)_
    * **libcdio-paranoia** _(needs libcdio)_
    * **libdvdread** _(needs libdvdcss (optional))_


3.
    * **dvdbackup** _(needs libdvdread)_
    * **libdvdnav** _(needs libdvdread)_


4.
    * **ffmpeg** _(needs libass, libcdio-paranoia, libfdk-aac, libopus,
      libx264, lame, lzo)_


5.
    * **libx264** _(rebuild to pick up ffmpeg dependencies)_


6.
    * **minidlna** _(needs libid3tag, ffmpeg)_
    * **mplayer** _(needs libass, libcdio-paranoia, libcdio, libdvdnav,
      libdvdread, libx264, ffmpeg, lame)_


7.
    * **gnome-mplayer** _(needs mplayer)_

