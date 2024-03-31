RUKOSHOME=/media/robert/data/rukos-0115/rukos-czn/rukos
MUSLHOME=/home/robert/Desktop/aarch64-linux-musl-gcc
CC=${MUSLHOME}/bin/aarch64-linux-musl-gcc
CFLAGS= -c -nostdinc -Og -ffreestanding -lpthread -I${RUKOSHOME}/ulib/ruxmusl/install/include

objects = closures ffi java_raw_api prep_cif raw_api sysv tramp types

all: clear_cache $(objects)

clear_cache:
	$(CC) $(CFLAGS) -o clear_cache.o clear_cache.c
	ar rcs ../../../install/lib/libc.a clear_cache.o

$(objects): %:
	ar rcs ../../../install/lib/libc.a $@.o
	
