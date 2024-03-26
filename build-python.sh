export RUXOS_PATH=$(pwd)

# unzip cpython
if [ ! -d "./apps/c/cpython" ]; then
	cd ./apps/c/
	unzip cpython-3.9.18.zip
	mv cpython-3.9.18 cpython
fi

# get musl libc.a
if [ ! -d "./ulib/ruxmusl/install" ]; then
	cd $RUXOS_PATH
	make A=apps/c/hello ARCH=aarch64 MUSL=y
fi

# link musl with some math functions and libffi
cd ./ulib/ruxmusl/src/aarch64
make
cd $RUXOS_PATH

# get the config file
# 因为是静态编译，所以在 make -j4 -s 的过程中生成 sharedmod 的部分会因为找不到 musl 的函数以及 libpython 的函数而报错
# 在 cpython/Lib/disutils/command/build_ext.py line 546 后面加上
#    extra_args += ['libpython3.9d.a', '../../../ulib/ruxmusl/install/lib/libc.a']
# 就可以编译出动态模块了，会放在 build/lib.linux-aarch64-3.9 目录下
# 所以这里用了 -rf 强行替换

cp -rf ./tools/python/* ./apps/c/cpython

# compile python static
#if [ -f "./apps/c/cpython/libpython3.9d.a"]; then
cd ./apps/c/cpython
sh static-build-python.sh
make -j4 -s	
# make install
cd $RUXOS_PATH
#fi

make ARCH=aarch64 A=apps/c/cpython NET=y V9P=y V9P_PATH=apps/c/cpython MUSL=y ARGS=python3 LOG=error run
#make ARCH=aarch64 A=apps/c/cpython NET=y V9P=y V9P_PATH=apps/c/cpython MUSL=y ARGS=python3,test.py LOG=error run
