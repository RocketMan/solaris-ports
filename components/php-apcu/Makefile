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
# Copyright (c) 2025 Jim Mason <jmason at ibinx dot com>.  All rights reserved.
#

BUILD_BITS=64
COMPILER=gcc
include ../../make-rules/shared-macros.mk
GCC_ROOT=/usr/gcc/10

COMPONENT_NAME=		apcu
COMPONENT_VERSION=	5.1.24
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)-$(COMPONENT_VERSION).tgz
COMPONENT_ARCHIVE_URL=	https://pecl.php.net/get/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	https://pecl.php.net/package/APCu
COMPONENT_ARCHIVE_HASH=	\
    sha256:5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43
COMPONENT_ANITYA_ID=	11010

BUILD_STYLE=phpize
include $(WS_MAKE_RULES)/common.mk

CFLAGS += -I/usr/include/pcre
