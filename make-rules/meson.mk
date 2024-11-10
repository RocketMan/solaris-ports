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


PATH=$(GNUBIN):$(USRBINDIR)

# use meson instead of configure
undefine CONFIG_SHELL
CONFIGURE_SCRIPT=$(MESON)

BUILD_STYLE = configure
include $(WS_MAKE_RULES)/configure.mk
include $(WS_MAKE_RULES)/ninja.mk

MESON_SOURCE ?= $(SOURCE_DIR)

# last component of the meson argument list must be the source directory
CONFIGURE_OPTIONS += $(MESON_SOURCE)

# ensure that meson is present in the build environment
$(SOURCE_DIR)/.prep: $(SOURCE_DIR)/.checked-meson

$(SOURCE_DIR)/.checked-meson:
	test -f $(MESON) || { echo >&2 "\n\e[31mMeson is required to build.  Meson is available in the Solaris userland gate.\e[0m\n"; exit 1; }
	$(TOUCH) $@
