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

BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		apcu
COMPONENT_VERSION=	5.1.18
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tgz
COMPONENT_ARCHIVE_URL=	https://pecl.php.net/get/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://pecl.php.net/package/APCu
COMPONENT_ARCHIVE_HASH=	\
    sha256:d46debe7acad6073b663ba1710c5cac671a60bf666966cf199bf6d07499bde2b
COMPONENT_ANITYA_ID=	11010

BUILD_TARGET = $(PHP_VERSIONS:%=$(BUILD_DIR)/php-%/.built)
INSTALL_TARGET = $(PHP_VERSIONS:%=$(BUILD_DIR)/php-%/.installed)
TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

$(BUILD_DIR)/%-5.6/.built:	PHP_VERSION=5.6
$(BUILD_DIR)/%-7.1/.built:	PHP_VERSION=7.1
$(BUILD_DIR)/%-7.3/.built:	PHP_VERSION=7.3
$(BUILD_DIR)/%-7.4/.built:	PHP_VERSION=7.4

$(BUILD_DIR)/%-5.6/.installed:	PHP_VERSION=5.6
$(BUILD_DIR)/%-7.1/.installed:	PHP_VERSION=7.1
$(BUILD_DIR)/%-7.3/.installed:	PHP_VERSION=7.3
$(BUILD_DIR)/%-7.4/.installed:	PHP_VERSION=7.4

CFLAGS += -I/usr/include/pcre

PHP_BINDIR = /usr/php/$(PHP_VERSION)/bin

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D) ; \
		cd $(@D) ; \
		$(PHP_BINDIR)/phpize)
CONFIGURE_SCRIPT = ./configure
CONFIGURE_OPTIONS += --with-php-config=$(PHP_BINDIR)/php-config

COMPONENT_INSTALL_ENV += INSTALL_ROOT=$(PROTO_DIR)
