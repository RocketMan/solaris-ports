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
# Copyright (c) 2010, 2018, Oracle and/or its affiliates. All rights reserved.
#


# The package branch version scheme is:
#
#       release_major.release_minor.update.component_revision
#

#
# Release major number: 2014, 2015, etc.
#
RELEASE_MAJOR ?= 2018

#
# Release minor number: 0, 1, 2, etc.
#
RELEASE_MINOR ?= 0

#
# Release update number: 0, 1, 2, etc.
#
UPDATENUM ?= 0

#
# Component revision. Should be specified in the component's Makefile
#
COMPONENT_REVISION ?= 0

# Target OS version
PKG_SOLARIS_VERSION ?= 5.11

#
# Branch Identifier.  Used in the version section of the package name to
# identify the operating system branch that the package was produced for.
#
BRANCHID ?= $(RELEASE_MAJOR).$(RELEASE_MINOR).$(UPDATENUM).$(COMPONENT_REVISION)

#
# Build Version.  Used in the version section of the package name to identify
# the operating system version and branch that the package was produced for.
# The part before the "-" is not needed for newer releases, but is needed for
# backwards compatibility with older releases; the default value is "5.11" so
# the IPS team recommends we use that.
#
BUILD_VERSION ?=  $(PKG_SOLARIS_VERSION)-$(BRANCHID)

# Set a default reference repository against which pkglint is run, in case it
# hasn't been set in the environment.
CANONICAL_REPO ?=		http://pkg.oracle.com/solaris/release/
