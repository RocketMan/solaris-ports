#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL)". You may
# only use this file in accordance with the terms of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright (c) 2014 Alexander Pyhalov
# Copyright (c) 2018 Michal Nowak
# Copyright (c) 2020 Jim Mason
#

BUILD_BITS=	32
COMPILER=	studio

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		compiz
COMPONENT_VERSION=	0.8.4
IPS_COMPONENT_VERSION=	0.8.4.1
COMPONENT_FMRI=		desktop/compiz
COMPONENT_PROJECT_URL=	http://www.northfield.ws/
COMPONENT_SRC=		compiz-core-$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
	sha256:bf35169d31164aa40d2c49d7ddce6abfc37388286507e675a1015152a2881acc
COMPONENT_ARCHIVE_URL=	https://gitlab.com/compiz/compiz-core/-/archive/$(COMPONENT_NAME)-$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)

TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

PATH=$(GNUBIN):$(USRBINDIR)

LDFLAGS += -lXext -lX11

# system aclocal macros include '-z defs' on studio compiler to trap
# undefined externals.  We don't want this, as the plugins contain
# references to compiz core.
COMPONENT_PREP_ACTION =        ( cd $(@D) && \
					aclocal -I. && \
				        autoheader && \
			                libtoolize --automake --copy --force && \
					automake -a -f -c &&\
					autoconf &&\
                                        intltoolize && \
					$(GSED) -i "/no_undefined_flag=' -z defs'/d" configure )

CONFIGURE_ENV+=	INTLTOOL_PERL=$(PERL)

CONFIGURE_OPTIONS+=	--sysconfdir=/etc
CONFIGURE_OPTIONS+=	--enable-gconf
CONFIGURE_OPTIONS+=	--enable-gnome
CONFIGURE_OPTIONS+=	--enable-metacity
CONFIGURE_OPTIONS+=	--disable-static
CONFIGURE_OPTIONS+=	--with-default-plugins=animation,core,ccp,dbus,decoration,fade,gnomecompat,imgjpeg,move,place,png,regex,resize,resizeinfo,session,svg,switcher,wall,workarounds

# Auto-generated dependencies
REQUIRED_PACKAGES += gnome/config/gconf
REQUIRED_PACKAGES += gnome/gnome-panel
REQUIRED_PACKAGES += gnome/preferences/control-center
REQUIRED_PACKAGES += gnome/window-manager/metacity
REQUIRED_PACKAGES += image/library/libpng
REQUIRED_PACKAGES += image/library/libpng16
REQUIRED_PACKAGES += image/library/librsvg
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/desktop/startup-notification
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gnome/gnome-libs
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/python/pygobject-27
REQUIRED_PACKAGES += library/python/pygtk2-27
REQUIRED_PACKAGES += runtime/perl-512
REQUIRED_PACKAGES += runtime/python-27
REQUIRED_PACKAGES += shell/bash
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/libdbus
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libice
REQUIRED_PACKAGES += x11/library/libsm
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxcomposite
REQUIRED_PACKAGES += x11/library/libxcursor
REQUIRED_PACKAGES += x11/library/libxdamage
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxfixes
REQUIRED_PACKAGES += x11/library/libxinerama
REQUIRED_PACKAGES += x11/library/libxrandr
REQUIRED_PACKAGES += x11/library/libxrender
REQUIRED_PACKAGES += x11/library/mesa
