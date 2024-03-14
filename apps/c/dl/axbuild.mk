dl-objs := dl.o
app-objs := $(dl-objs)



# DL_GCC = ~/musl-cross-make/output/bin/aarch64-linux-musl-gcc 
DL_GCC =  aarch64-linux-musl-gcc
DL_GCC_FLAGS_COMMON = -mgeneral-regs-only  -ggdb
DL_GCC_FLAGS_STATIC = $(DL_GCC_FLAGS_COMMON)  -static -fPIE -pie 
DL_GCC_FLAGS_DYNAMIC =  $(DL_GCC_FLAGS_COMMON)

DL_ROOT_DIR = $(APP)/root
DL_LIB_DIR = $(DL_ROOT_DIR)/lib
DL_SOURCE = $(DL_ROOT_DIR)/hello.c
DL_OUTPUT_STATIC = $(DL_ROOT_DIR)/statichello
DL_OUTPUT_DYNAMIC = $(DL_ROOT_DIR)/dynamichello

include $(APP)/config.mk

ARGS = $(DL_APP_PATH),$(DL_ARGS)
ENVS = $(DL_ENVS)
# ARGS = $(DL_APP_PATH), --defaults-file=/install/my.cnf,  --basedir=/install, --datadir=/install/data, --plugin-dir=/install/lib/plugin, --user=root, --log-error=/install/data/err.log 
# ENVS = LD_LIBRARY_PATH=/usr/lib:/lib:/install/lib/private,hello=world,world=hello
V9P_PATH = $(DL_ROOT_DIR)

ifeq ($(DL_DEBUG),y)
DL_GCC_FLAGS_COMMON += -ggdb
endif


$(APP)/dl.o: build_dl



build_dl:
	echo --------------build_dl---------------------
	mkdir $(DL_ROOT_DIR) -p
	mkdir $(DL_LIB_DIR) -p
	cp $(APP)/../../../ulib/ruxmusl/install/lib/libc.so $(DL_LIB_DIR)/ld-musl-aarch64.so.1
	# $(DL_GCC) $(DL_GCC_FLAGS_STATIC) $(DL_SOURCE) -o $(DL_OUTPUT_STATIC) 
	# $(DL_GCC) $(DL_GCC_FLAGS_DYNAMIC) $(DL_SOURCE) -o $(DL_OUTPUT_DYNAMIC) 
	echo --------------build_dl---------------------