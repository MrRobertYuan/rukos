dl-objs := dl.o
app-objs := $(dl-objs)



# DL_GCC = ~/musl-cross-make/output/bin/aarch64-linux-musl-gcc 
DL_GCC =  aarch64-linux-musl-gcc
DL_GCC_FLAGS_COMMON = -mgeneral-regs-only  -ggdb
DL_GCC_FLAGS_STATIC = $(DL_GCC_FLAGS_COMMON)  -static -fPIE -pie 
DL_GCC_FLAGS_DYNAMIC =  $(DL_GCC_FLAGS_COMMON)

DL_ROOT_DIR = $(APP)/root
DL_SOURCE = $(DL_ROOT_DIR)/hello.c
DL_OUTPUT_STATIC = $(DL_ROOT_DIR)/statichello
DL_OUTPUT_DYNAMIC = $(DL_ROOT_DIR)/dynamichello

ARGS = dynamichello,envtest,test1,test2
ENVS = hello=world,world=hello
V9P_PATH = $(DL_ROOT_DIR)

ifeq ($(DL_DEBUG),y)
DL_GCC_FLAGS_COMMON += -ggdb
endif


$(APP)/dl.o: build_dl



build_dl:
	# $(DL_GCC) $(DL_GCC_FLAGS_STATIC) $(DL_SOURCE) -o $(DL_OUTPUT_STATIC) 
	# $(DL_GCC) $(DL_GCC_FLAGS_DYNAMIC) $(DL_SOURCE) -o $(DL_OUTPUT_DYNAMIC) 

	

