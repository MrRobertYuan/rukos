objects = closures ffi java_raw_api prep_cif raw_api sysv tramp types

all: clear_cache $(objects)

clear_cache:
	$(CC) $(CFLAGS) -o clear_cache.o clear_cache.c
	ar rcs ../../../install/lib/libc.a clear_cache.o

$(objects): %:
	ar rcs ../../../install/lib/libc.a $@.o
	
