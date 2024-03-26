objects = udivti3 udivmodti4

all: $(objects)

$(objects): %: %.c
	$(CC) $(CFLAGS) -o $@.o $<
	ar rcs ../../../install/lib/libc.a $@.o
