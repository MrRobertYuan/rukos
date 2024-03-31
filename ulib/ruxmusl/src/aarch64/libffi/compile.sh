/home/robert/Desktop/aarch64-linux-musl-gcc/bin/aarch64-linux-musl-gcc -c -nostdinc -I${RUKOSHOME}/ulib/ruxmusl/install/include clear_cache.c -o clear_cache.o

ar rcs ../../../install/lib/libc.a closures.o ffi.o java_raw_api.o prep_cif.o raw_api.o sysv.o tramp.o types.o clear_cache.o