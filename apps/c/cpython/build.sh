#!/bin/bash
set -e

ARCH=aarch64
VER=python3.11

jobs=32
# install_dir=../dl/root/${VER}
# install_dir=/media/robert/data/ruxos-0510/rukos/apps/c/cpython/${VER}
install_dir=$(pwd)/../dl/rootfs
toolchain=${ARCH}-linux-musl

echo "Creating ${install_dir} folder with $(whoami) user permissions ..."
[ -d ${install_dir} ] || mkdir -p ${install_dir}
[ -d build ] || mkdir build
cd build

for d in $(ls ../package/*)
do
echo $d
dir=$(basename $d)
dir=${dir%%.*}

if ! [ -d ${dir}* ]; then
tar xf $d

# To build
if [[ $dir == Python-3* ]]; then
continue

elif [[ $dir == zlib* ]]; then
pushd ${dir}*
CROSS_PREFIX="${toolchain}-"  ./configure --prefix=${install_dir}
make -j${jobs} && make install
popd

else
pushd ${dir}*
./configure --host=${toolchain} --enable-static=yes --prefix=${install_dir} 
make -j${jobs} && make install
popd

fi
fi
done

echo "Building ${VER}"
cd Python-3*

export PKG_CONFIG_PATH=${install_dir}/lib/pkgconfig

unset CFLAGS LDFLAGS CC
export CC=aarch64-linux-musl-gcc
export CFLAGS+=" -I${install_dir}/include/" # Just to include libffi
export LDFLAGS+=" -L${install_dir}/lib/"
export CONFIG_SITE=config.site

echo '
ac_cv_file__dev_ptmx=yes
ac_cv_file__dev_ptc=no
ac_cv_func_accept4=no
ac_cv_func_utimensat=no
ac_cv_func_setitimer=no
ac_cv_func_clock_getres=no
ac_cv_func_clock_nanosleep=no
' > ./CONFIG_SITE

echo '
ac_cv_file__dev_ptmx=yes
ac_cv_file__dev_ptc=no
ac_cv_func_accept4=no
ac_cv_func_utimensat=no
ac_cv_func_setitimer=no
ac_cv_func_clock_getres=no
ac_cv_func_clock_nanosleep=no
ac_cv_func_wait4=no
ac_cv_func_select6=no
' > ./config.site

# ./configure --prefix=${install_dir} --with-build-python=${VER} --build=x86_64 --host=${toolchain} \
# --enable-ipv6 CONFIG_SITE=./CONFIG_SITE --enable-optimizations

./configure --prefix=${install_dir} --with-build-python=${VER} --build=x86_64 --host=${toolchain} \
--enable-ipv6 --with-config-site=./CONFIG_SITE --enable-optimizations


# --with-static-libpython=yes
# --enable-shared=no
# --with-system-ffi=no

make -j4 -s && make install 
# make test

echo ========= Cross compiled python successfully =========
echo Please check ${install_dir}