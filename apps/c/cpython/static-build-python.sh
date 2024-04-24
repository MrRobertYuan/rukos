#!/bin/bash

export RUKOSHOME="$(pwd)/../../.."

export PY_PREFIX="${RUKOSHOME}/apps/c/cpython-exec"
export CC="aarch64-linux-musl-gcc"
export AR="aarch64-linux-musl-ar"
export LIBC="${RUKOSHOME}/ulib/ruxmusl/install/lib/libc.a"
export CONFIG_SITE=config.site

./configure --prefix="${PY_PREFIX}"\
	LDFLAGS="-nostdlib -no-pie -T${RUKOSHOME}/modules/ruxhal/linker_aarch64-qemu-virt.lds" \
	CFLAGS="-nostdinc -I${RUKOSHOME}/ulib/ruxmusl/install/include -I${RUKOSHOME}/ulib/ruxmusl/src/aarch64/include " \
	--with-pydebug --host=aarch64-linux-musl --build=x86_64-linux-musl --disable-ipv6 --with-config-site=./CONFIG_SITE

#-DHAVE_READLINK -DHAVE_FORK -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK -DHAVE_TIMEGM -DHAVE_ROUND -DHAVE_COPYSIGN -DHAVE_MKNOD -DHAVE_MAKEDEV -DHAVE_DLOPEN -DPOSIX_SEMAPHORES_NOT_ENABLED -DHAVE_SYSCONF -DHAVE_DYNAMIC_LOADING

#./configure --prefix="${PY_PREFIX}" --enable-shared \
#	LDFLAGS="-nostdlib -T${RUKOSHOME}/modules/ruxhal/linker_aarch64-qemu-virt-for-python.lds" \
#	CFLAGS="-nostdinc -fPIC -Og -ffreestanding -lpthread -I${RUKOSHOME}/ulib/ruxmusl/install/include -I${RUKOSHOME}/ulib/ruxmusl/src/aarch64/include -DHAVE_READLINK -DHAVE_FORK -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK -DHAVE_TIMEGM -DHAVE_ROUND -DHAVE_COPYSIGN -DHAVE_MKNOD -DHAVE_MAKEDEV -DHAVE_DLOPEN -DPOSIX_SEMAPHORES_NOT_ENABLED -DHAVE_SYSCONF -DHAVE_DYNAMIC_LOADING" \
#	--with-pydebug --host=aarch64-linux-musl --build=x86_64-linux-musl --disable-ipv6 --with-config-site=./CONFIG_SITE
