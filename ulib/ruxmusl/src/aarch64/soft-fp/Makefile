#
#	Makefile for software floating-point routines
#
#subdir	:= soft-fp

#include ../Makeconfig

#gcc-single-routines := negsf2 addsf3 subsf3 mulsf3 divsf3 eqsf2 \
	lesf2 gesf2 unordsf2 fixsfsi fixunssfsi floatsisf fixsfdi        \
	fixunssfdi floatdisf floatunsisf floatundisf

#gcc-double-routines := negdf2 adddf3 subdf3 muldf3 divdf3 eqdf2 \
	ledf2 gedf2 unorddf2 fixdfsi fixunsdfsi floatsidf fixdfdi        \
	fixunsdfdi floatdidf extendsfdf2 truncdfsf2 floatunsidf \
	floatundidf

#gcc-quad-routines := negtf2 addtf3 subtf3 multf3 divtf3 eqtf2 \
	letf2 getf2 unordtf2 fixtfsi fixunstfsi floatsitf fixtfdi      \
	fixunstfdi floatditf extendsftf2 trunctfsf2 extenddftf2 \
	trunctfdf2 floatunsitf floatunditf

#include ../Rules

RUKOSHOME=/media/robert/data/rukos-0115/rukos
MUSLHOME=/home/robert/Desktop/aarch64-linux-musl-gcc
CC=${MUSLHOME}/bin/aarch64-linux-musl-gcc
CFLAGS= -c -nostdinc -Og -ffreestanding -lpthread -I${RUKOSHOME}/ulib/ruxmusl/install/include

objects = divtf3 extenddftf2 extendsftf2 netf2 addtf3 subtf3 multf3 fixtfsi fixtfdi fixunstfsi floatsitf floatunsitf trunctfdf2 trunctfsf2 eqtf2 getf2 letf2

all: $(objects)

$(objects): %: %.c
	$(CC) $(CFLAGS) -o $@.o $<
	ar rcs ../../../install/lib/libc.a $@.o
	
