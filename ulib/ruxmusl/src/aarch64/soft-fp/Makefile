objects = divtf3 extenddftf2 extendsftf2 netf2 addtf3 subtf3 multf3 fixtfsi fixtfdi fixunstfsi floatsitf floatunsitf trunctfdf2 trunctfsf2 eqtf2 getf2 letf2

all: $(objects)

$(objects): %: %.c
	$(CC) $(CFLAGS) -o $@.o $<
	ar rcs ../../../install/lib/libc.a $@.o
	
