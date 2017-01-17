
# docker-cross

Docker image containing Binutils + GDB-Simulator for various target architectures.

## [DockerHub](https://hub.docker.com/r/blukat29/cross/)

## How to use

```
docker pull blukat29/cross
docker run -v $(pwd):/root/shared -it blukat29/cross
```

Docker's `/root/shared` will be shared with Host's current directory.

## Using the tools

Tools are installed under `/usr/bin`.
binutils are combined into one single binary. binutils will automatically recognize the architecture.
If you need to explicitly specify the architecture, use `-M` flag.

```
readelf -h sparc.bin
objdump -M m32r -d m32r.bin
```


gdb-sims are compiled into separate programs for each architecture.

```
avr-elf-run avr.bin
sh-elf-run sh.bin
```

## Supported Architectures

Architecture   | binutils   | gdb-sim     | Comment
-------------- | ---------- | ----------- | -------
aarch64        | Y          |             | ARM 64-bit
alpha          | Y          |             | DEC Alpha
arc            | Y          |             | Argonaut RISC Core
arm            | Y          | Y           | ARM 32-bit (includes thumb mode)
avr            | Y          | Y           | Atmel AVR 8-bit
cris           | Y          | Y           | ETRAX CRIS
fr30           | Y          |             | Fujitsu FR30
frv            | Y          | Y           | Fujitsu FR-V
hppa           | Y          |             | Hewlett-Packard PA-RISC
h8300          | Y          | Y           | Renesas H8/300
i960           | Y          |             | Intel i960
ia64           | Y          |             | Intel ia64
m32r           | Y          | Y           | Renesas M32R
m6811          | Y          | Y           | Motorola 68HC11
m68k           | Y          |             | Motorola m68k
mcore          | Y          | Y           | Freescale M-CORE
mips           | Y          | Y           | MIPS 32-bit
mips16         | Y          | Y           | MIPS 16-bit mode (MIPS16e)
mips64         | Y          | Y           | MIPS 64-bit
mn10300        | Y          | Y           | Panasonic MN103
powerpc        | Y          | Y           | PowerPC 32-bit
powerpc64      | Y          |             | PowerPC 64-bit
s390           | Y          |             | IBM ESA/390
sh             | Y          | Y           | Renesas SuperH 32-bit
sh64           | Y          | Y           | Renesas SuperH 64-bit (sh5)
sparc          | Y          | Y           | SPARC
v850           | Y          | Y           | NEC V850
x86            | Y          | not needed  |
x86\_64        | Y          | not needed  |
