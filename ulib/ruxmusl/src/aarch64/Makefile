RUKOSHOME=$(pwd)/../../../..

CC=aarch64-linux-musl-gcc
CFLAGS= -c -nostdinc -Og -ffreestanding -lpthread -I${RUKOSHOME}/ulib/ruxmusl/install/include

export RUKOSHOME CC CFLAGS

SUB_DIR := builtins libffi soft-fp

all:
	make -C builtins
	make -C libffi
	make -C soft-fp

clean:
	rm -f ./builtins/*.o
	rm -f ./soft-fp/*.o
	rm -f ./libffi/clear_cache.o