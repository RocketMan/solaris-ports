## x264

x264 is a free software library and application for encoding video
streams into the H.264/MPEG-4 AVC compression format.

This component builds two packages, libx264, which contains the
library, and x264-utils, which contains the command-line utility.

## Build notes

The shared library version number of this package changes frequently.
When this happens, you must rebuild the following dependent packages:

* media/ffmpeg
* media/mplayer
* desktop/gstreamer-1/gst-plugins-ugly
