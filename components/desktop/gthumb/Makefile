#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2020 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk
GCC_ROOT=/usr/gcc/10

COMPONENT_NAME=		gthumb
COMPONENT_VERSION=	3.12.6
COMPONENT_ARCHIVE_URL=	https://gitlab.gnome.org/GNOME/gthumb/-/archive/$(COMPONENT_VERSION)/$(COMPONENT_SRC).tar.gz
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Gthumb
COMPONENT_ARCHIVE_HASH= \
    sha256:73a3f20af9b79a7b7dea809dd4308a0a3c98b30f51eba1147e0a0c3102f7d643
COMPONENT_ANITYA_ID=	1270

PATH=$(GNUBIN):$(USRBINDIR)

CFLAGS += -D__EXTENSIONS__ -D_XOPEN_SOURCE=600 -D_XPG6
CPPFLAGS += -I/usr/include/lcms2
CXXFLAGS += -std=c++17
CXXFLAGS += -DEXIV2API=

BUILD_STYLE = meson
include $(WS_MAKE_RULES)/common.mk

COMPONENT_BUILD_ENV += VERBOSE=1
CONFIGURE_OPTIONS += -Dlibchamplain=true

REQUIRED_PACKAGES += desktop/cd-burning/brasero
REQUIRED_PACKAGES += image/library/exiv2
REQUIRED_PACKAGES += image/library/libjpeg
REQUIRED_PACKAGES += image/library/libpng
REQUIRED_PACKAGES += image/library/libpng14
REQUIRED_PACKAGES += image/library/librsvg
REQUIRED_PACKAGES += image/library/libtiff
REQUIRED_PACKAGES += image/library/libwebp
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/clutter
REQUIRED_PACKAGES += library/desktop/clutter/clutter-gtk
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-base
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/libchamplain
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/desktop/webkitgtk4
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += library/lcms2
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/media/libheif
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/gcc/gcc-c++-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
