#!/bin/bash

export MUSLHOME="/home/robert/Desktop/aarch64-linux-musl-gcc"
export AR="${MUSLHOME}/bin/aarch64-linux-musl-ar"

object="extenddftf2.o netf2.o addtf3.o subtf3.o multf3.o fixtfsi.o fixunstfsi.o floatsitf.o floatunsitf.o"

export RUKOSHOME="/media/robert/data/rukos-0115/rukos"
export LIBC="${RUKOSHOME}/ulib/ruxmusl/install/lib/libc.a"

ar rcs $(LIBC) $(object)
ar rcs ../../../install/lib/libc.a udivti3.o udivmodti4.o