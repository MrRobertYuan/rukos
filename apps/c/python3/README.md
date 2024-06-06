# Dl
Python3 depends on the dynamic loading

# Quick Start
1. Extract and compile python source and third-party libraries

```sh
chmod +x build.sh
./build.sh
```

2. Copy the musl libc dynamic loader to 'rootfs/lib'

ulib/ruxmusl/lib/


3. Run
run in '/ruxos' directory
```sh
make A=apps/c/python3 ARCH=aarch64 V9P=y NET=y MUSL=y LOG=off SMP=4 run
```