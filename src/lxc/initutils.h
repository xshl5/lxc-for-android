/*
 * lxc: linux Container library
 *
 * (C) Copyright IBM Corp. 2007, 2008
 *
 * Authors:
 * Daniel Lezcano <daniel.lezcano at free.fr>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#ifndef __LXC_INITUTILS_H
#define __LXC_INITUTILS_H

#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "string_utils.h"

#define DEFAULT_VG "lxc"
#define DEFAULT_THIN_POOL "lxc"
#define DEFAULT_ZFSROOT "lxc"
#define DEFAULT_RBDPOOL "lxc"

#ifndef PR_SET_MM
#define PR_SET_MM 35
#endif

#ifndef PR_SET_MM_MAP
#define PR_SET_MM_MAP 14

struct prctl_mm_map {
	uint64_t start_code;
	uint64_t end_code;
	uint64_t start_data;
	uint64_t end_data;
	uint64_t start_brk;
	uint64_t brk;
	uint64_t start_stack;
	uint64_t arg_start;
	uint64_t arg_end;
	uint64_t env_start;
	uint64_t env_end;
	uint64_t *auxv;
	uint32_t auxv_size;
	uint32_t exe_fd;
};
#endif

extern const char *lxc_global_config_value(const char *option_name);

extern int setproctitle(char *title);

#endif /* __LXC_INITUTILS_H */
