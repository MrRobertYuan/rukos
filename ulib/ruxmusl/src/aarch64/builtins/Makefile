RUKOSHOME=/media/robert/data/rukos-0115/ruxos
MUSLHOME=/home/robert/Desktop/aarch64-linux-musl-gcc
CC=${MUSLHOME}/bin/aarch64-linux-musl-gcc
CFLAGS= -c -nostdinc -Og -ffreestanding -lpthread -I${RUKOSHOME}/ulib/ruxmusl/install/include

objects = udivti3 udivmodti4

all: $(objects)

$(objects): %: %.c
	$(CC) $(CFLAGS) -o $@.o $<
	ar rcs ../../../install/lib/libc.a $@.o
