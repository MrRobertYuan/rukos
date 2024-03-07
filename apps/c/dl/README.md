# dynamic app loader

让 ruxos 可以直接运行文件系统里的 ELF 二进制文件, 而不需要编译整个系统.

## 运行

将编译好的文件(可执行文件和动态库文件), 放入 ruxos 文件系统中(`$(APP)/root`).
- 已提供 musl-libc

修改`config.mk`
- DL_APP_PATH: 可执行文件在 ruxos 文件系统下的路径, 例如 `/a.out` 
- DL_ARGS: 参数
- DL_ENVS: 环境变量

运行:
`make A=apps/c/dl ARCH=aarch64 V9P=y NET=y MUSL=y LOG=info SMP=1 run`

### hello-world

文件系统中已有 `hello.c`.

编译:
```sh
musl-gcc hello.c -o hello
```

修改配置文件
```makefile
DL_APP_PATH = /hello
```

运行:
```sh
make A=apps/c/dl ARCH=aarch64 V9P=y NET=y MUSL=y LOG=info SMP=1 run
```

### 编译时指定自定义动态库

文件系统中已有 `hello2.c` 和 `libhello.c`.

编译:
```sh
musl-gcc libhello.c -shared -o lib/libhello.so 
musl-gcc hello2.c -o hello2 -L./lib -lhello 
```

修改配置文件
```makefile
DL_APP_PATH = /hello2
```

运行:
```sh
make A=apps/c/dl ARCH=aarch64 V9P=y NET=y MUSL=y LOG=info SMP=1 run
```


### dlopen

文件系统中已有 `hello3.c` 和 `libhello.c`.

编译:
```sh
musl-gcc libhello.c -shared -o lib/libhello.so 
musl-gcc hello3.c -o hello3 
```

```makefile
DL_APP_PATH = /hello3
```

运行:
```sh
make A=apps/c/dl ARCH=aarch64 V9P=y NET=y MUSL=y LOG=info SMP=1 run
```


### 动态库位置

一般在**默认目录**, 例如
- `/lib` 
- `/usr/lib` 

如果想放在其他位置, 可以选择:
- 修改编译选项(例如`rpath`)
- 修改环境变量(例如`LD_LIBRARY_PATH`)


## 已知问题

### 栈大小

使用 `mmap` 申请了 10M 空间作为栈.

理论上应该使用原栈, 或者在内核生成新的 PCB 并分配栈.

或许会导致未知问题.

### 读取 ELF 文件头

为了获取 ELF 文件头进行解析, 需要将该 ELF 文件读入内存. 

Linux 选择读取 ELF 文件前 128B 的内容, 如果有需要再额外读取更多. 

但为了方便, ruxos 暂时直接读取整个文件.

这在读取超大文件(MySQL)时, 会有明显卡顿. 

### vDSO 

暂未实现.

### SMP

多核环境下会报错.




## 原理

### 解释器和动态链接器

### 加载器




