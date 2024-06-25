/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 *
 * Copyright (c) 2015, 2016, Oracle and/or its affiliates. All rights reserved.
 */

#include "cxa_finalize.h"

#ifdef __cplusplus
extern "C" {
#endif

extern void* __dso_handle;

static void __attribute__((destructor)) __do_cleanup(void) {
  // The value of the magic symbol __dso_handle is supposed to be its own
  // address, though on 11.3, this does not seem to be the case.
  // This is not a problem for the compiler-generated __cxa_atexit invocations,
  // as those supply the address of the symbol, not its value.
  //
  // We work around by using the address explicitly, so that it matches
  // the dso parameter provided by the compiler to __cxa_atexit.

  __cxa_finalize(&__dso_handle);
}

#ifdef __cplusplus
}
#endif
