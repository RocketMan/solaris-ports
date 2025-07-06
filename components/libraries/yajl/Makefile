#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source.  A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
#

#
# Copyright 2016 phorcys@126.com.  All rights reserved.
# Copyright 2025 Klaus Ziegler
#

# Adapted for Solaris 11.3 from OpenIndiana source avaialble here:
# https://github.com/OpenIndiana/oi-userland

BUILD_STYLE=cmake
BUILD_BITS=64
COMPILER=gcc
include ../../../make-rules/shared-macros.mk
GCC_ROOT=/usr/gcc/10

COMPONENT_NAME=         libyajl2
COMPONENT_VERSION=      2.1.0
COMPONENT_SUMMARY=      
COMPONENT_SRC=          yajl-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=      $(COMPONENT_NAME)-$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH= \
	sha256:3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a
COMPONENT_ARCHIVE_URL=  \
	https://github.com/lloyd/yajl/archive/refs/tags/$(COMPONENT_VERSION).tar.gz
COMPONENT_PROJECT_URL=  https://lloyd.github.io/yajl/

TEST_TARGET=$(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

# Auto-generated dependencies
REQUIRED_PACKAGES += system/library
