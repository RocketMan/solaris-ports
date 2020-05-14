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
# Copyright (c) 2018-2020 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS =            64
COMPILER =		gcc
include ../../../make-rules/shared-macros.mk
GCC_ROOT = 		/usr/gcc/9

COMPONENT_NAME=		epiphany
COMPONENT_VERSION=	3.30.5
IPS_COMPONENT_VERSION=	3.30.5.3
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE_URL=	$(GIT_REPO)/archive/$(COMPONENT_VERSION).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:12d4d7f6bf1b320995d218126ac1021d064554f279be62df61fb19cc75dee1ed
GIT_REPO=		https://github.com/GNOME/epiphany
GIT_COMMIT_ID=		3.30.5
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Apps/Web
COMPONENT_ANITYA_ID=	10903

COMPONENT_NAME_1=	pdfjs
COMPONENT_VERSION_1=	2.3.200
COMPONENT_ARCHIVE_1=	pdfjs-$(COMPONENT_VERSION_1)-dist.zip
COMPONENT_ARCHIVE_URL_1= https://github.com/mozilla/pdf.js/releases/download/v$(COMPONENT_VERSION_1)/$(COMPONENT_ARCHIVE_1)
COMPONENT_ARCHIVE_HASH_1= \
	sha256:f1577e373efc8b9143744bc07caf7085ff27a1a496da8e2890db9de5917e4f3b

COMPONENT_NAME_2=	highlightjs
COMPONENT_VERSION_2=	10.0.3
COMPONENT_SRC_2=	highlight.js-$(COMPONENT_VERSION_2)
COMPONENT_ARCHIVE_2=	highlight.js-$(COMPONENT_VERSION_2).tar.gz
COMPONENT_ARCHIVE_URL_2= https://github.com/highlightjs/highlight.js/archive/$(COMPONENT_ARCHIVE_2)
COMPONENT_ARCHIVE_HASH_2= \
	sha256:cb9b83c97d8f7fccdc819ea86ac9f03f28aca12a15ac11d15b8782414da1cd86

COMPONENT_NAME_3=	highlightjs_line_numbers
COMPONENT_VERSION_3=	2.7.0
COMPONENT_SRC_3=	highlightjs-line-numbers.js-$(COMPONENT_VERSION_3)
COMPONENT_ARCHIVE_3=	$(COMPONENT_SRC_3).tar.gz
COMPONENT_ARCHIVE_URL_3= https://github.com/wcoder/highlightjs-line-numbers.js/archive/v$(COMPONENT_VERSION_3).tar.gz
COMPONENT_ARCHIVE_HASH_3= \
	sha256:d089a401490d1c1a5e0bb49bad00f6c970d260787960150c7bd5e8cf36f15ace

BUILD_STYLE = meson
include $(WS_MAKE_RULES)/common.mk

CFLAGS += -Wdeprecated-declarations
LDFLAGS += -lm -lsocket -lnsl
#$(SOLARIS_11_3_ONLY)LDFLAGS += -licuuc_gcc


PDFJS=$(SOURCE_DIR)/third-party/pdfjs
HIGHLIGHTJS=$(SOURCE_DIR)/third-party/highlightjs

COMPONENT_POST_UNPACK_ACTION += ( \
	$(MKDIR) -p $(PDFJS) ; \
	cd $(PDFJS) ; \
	$(UNZIP) $(COMPONENT_DIR)/$(COMPONENT_ARCHIVE_1) )

$(SOURCE_DIR)/.prep: $(COMPONENT_SRC_3)/.prep $(COMPONENT_SRC_2)/.prep $(PDFJS)/.prep

$(PDFJS)/.prep: download unpack patch
	(cd $(@D) ; \
	$(PYTHON) pdfjs_generate_resource.py ; \
	$(GPATCH) -p0 < epiphany-pdfjs-changes.patch )
	$(TOUCH) $@

$(COMPONENT_SRC_2)/.prep: download unpack patch
	(cd $(@D) ; \
	$(ENV) npm install ; \
	$(ENV) node tools/build.js -n css javascript xml ; \
	$(CP) build/highlight.js $(HIGHLIGHTJS) )
	$(TOUCH) $@

$(COMPONENT_SRC_3)/.prep: download unpack patch
	(cd $(@D) ; \
	$(CP) src/highlightjs-line-numbers.js $(HIGHLIGHTJS) )
	$(TOUCH) $@


#CONFIGURE_OPTIONS += -Ddeveloper_mode=true

REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += gnome/gnome-shell
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/libdazzle
REQUIRED_PACKAGES += library/desktop/libnotify
REQUIRED_PACKAGES += library/desktop/libwnck3
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/desktop/webkitgtk4
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/gmp
REQUIRED_PACKAGES += library/gnome/libsecret
REQUIRED_PACKAGES += library/gnome/gcr
REQUIRED_PACKAGES += library/icu
#REQUIRED_PACKAGES += library/icu-gcc
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += library/libsoup
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/libxslt
REQUIRED_PACKAGES += library/nspr
REQUIRED_PACKAGES += library/security/nettle
REQUIRED_PACKAGES += library/security/nss
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/network/avahi
REQUIRED_PACKAGES += x11/library/libx11
