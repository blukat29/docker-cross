
# docker-cross

Docker image containing Binutils + GDB + GDB-Simulator for various target architectures.

## [DockerHub](https://hub.docker.com/r/blukat29/cross/)

## How to use

```
docker pull blukat29/cross
docker run -v $(pwd):/root/shared -it blukat29/cross
```

Tools are located under `/usr/local/cross/bin`.

```
/usr/local/cross/bin/sparc-elf-readelf -h sparc.bin
/usr/local/cross/bin/m32r-elf-objdump -d m32r.bin
/usr/local/cross/bin/avr-elf-run avr.bin
```

## Supported Architectures

Architecture   | binutils   | gdb-sim     | Comment
-------------- | ---------- | ----------- | -------
aarch64        | apt        | unsupported | ARM 64-bit
alpha          | apt        | unsupported | DEC Alpha
arc            | apt        | unsupported | Argonaut RISC Core
arm            | apt        | built       | ARM 32-bit (includes thumb mode)
avr            | built      | built       | Atmel AVR 8-bit
cris           | built      | built       | ETRAX CRIS
fr30           | built      | unsupported | Fujitsu FR30
frv            | built      | built       | Fujitsu FR-V
hppa           | apt        | unsupported | Hewlett-Packard PA-RISC
h8300          | built      | built       | Renesas H8/300
i960           | built      | unsupported | Intel i960
ia64           | built      | unsupported | Intel ia64
m32r           | apt        | built       | Renesas M32R
m6811          | built      | built       | Motorola 68HC11
m68k           | apt        | unsupported | Motorola m68k
mcore          | built      | built       | Freescale M-CORE
mips           | apt        | built       | MIPS 32-bit
mips16         | apt        | built       | MIPS 16-bit mode (MIPS16e)
mips64         | apt        | built       | MIPS 64-bit
mn10300        | built      | built       | Panasonic MN103
powerpc        | apt        | built       | PowerPC 32-bit
powerpc64      | apt        | unsupported | PowerPC 64-bit
s390           | apt        | unsupported | IBM ESA/390
sh             | apt        | built       | Renesas SuperH 32-bit
sh64           | apt        | built       | Renesas SuperH 64-bit (sh5)
sparc          | apt        | built       | SPARC
v850           | built      | built       | NEC V850
x86            | apt        | not needed  |
x86\_64        | apt        | not needed  |
