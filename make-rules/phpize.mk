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
# Copyright (c) 2020-2024 Jim Mason <jmason at ibinx dot com>.
#

BUILD_TARGET ?= $(PHP_VERSIONS:%=$(BUILD_DIR)/php-%/.built)
INSTALL_TARGET ?= $(PHP_VERSIONS:%=$(BUILD_DIR)/php-%/.installed)
TEST_TARGET ?= $(NO_TESTS)

include $(WS_MAKE_RULES)/configure.mk

$(BUILD_DIR)/%-7.4/.configured:	PHP_VERSION=7.4
$(BUILD_DIR)/%-8.2/.configured:	PHP_VERSION=8.2
$(BUILD_DIR)/%-8.3/.configured:	PHP_VERSION=8.3
$(BUILD_DIR)/%-8.4/.configured:	PHP_VERSION=8.4

PHP_BINDIR = /usr/php/$(PHP_VERSION)/bin

CFLAGS += -DPHP_$(subst .,,$(PHP_VERSION))

CLEAN_PATHS += package.xml

CONFIGURE_ENV += CFLAGS="$(strip $(CFLAGS))"
CONFIGURE_ENV += CXXFLAGS="$(strip $(CXXFLAGS))"
CONFIGURE_ENV += LDFLAGS="$(strip $(LDFLAGS))"

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D) ; \
		cd $(@D) ; \
		$(PHP_BINDIR)/phpize) ;

# configure script is in the build directory
CONFIGURE_SCRIPT = $(@D)/configure

CONFIGURE_OPTIONS += --with-php-config=$(PHP_BINDIR)/php-config

COMPONENT_INSTALL_ENV += INSTALL_ROOT=$(PROTO_DIR)

REQUIRED_PACKAGES += web/php-74
REQUIRED_PACKAGES += web/php-82
REQUIRED_PACKAGES += web/php-83
REQUIRED_PACKAGES += web/php-84
