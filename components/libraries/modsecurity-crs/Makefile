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
# Copyright (c) 2025 Jim Mason <jmason at ibinx dot com>
#

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		modsecurity-crs
COMPONENT_VERSION=	3.3.4
COMPONENT_ARCHIVE_HASH=	\
	sha256:15a84aaa041aa532905a34546b613bd3aed122e3f9814fbb5c28e1655d02b74d
COMPONENT_SRC_NAME=	coreruleset
COMPONENT_PROJECT_URL=	https://github.com/coreruleset/coreruleset
COMPONENT_ARCHIVE_URL=	\
	$(COMPONENT_PROJECT_URL)/archive/refs/tags/v$(COMPONENT_VERSION).tar.gz
COMPONENT_BUGDB=	library/xmlsec

# There is nothing to build, just package the dist files
BUILD_STYLE= pkg

COMMON_TARGETS= no
include $(WS_MAKE_RULES)/common.mk

PROTO_CRS_DIR=	\
	$(PROTO_DIR)/usr/share/$(COMPONENT_NAME)

PKG_MANIFEST=	\
	$(BUILD_DIR)/modsecurity-crs.dynamic

# move relevant dist files into the proto area
$(BUILD_DIR)/.installed: $(SOURCE_DIR)/.prep
	(cd $(SOURCE_DIR); \
		$(MKDIR) $(PROTO_CRS_DIR); \
		$(CP) -r rules/ $(PROTO_CRS_DIR)/; \
		$(CP) -r util/ $(PROTO_CRS_DIR)/ )
	$(TOUCH) $@

# generate dynamic manifest from dist files
$(BUILD_DIR)/.make-manifest: $(BUILD_DIR)/.installed
	(cd $(PROTO_DIR); \
		$(FIND) . -type f ! -name '*.example' -print | $(GAWK) '{ sub(/^\.\//, "", $$1); print "file path="$$0 }' > $(PKG_MANIFEST) )
	$(TOUCH) $@

install: $(BUILD_DIR)/.make-manifest
