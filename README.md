
# docker-cross

Docker image containing Binutils + GDB + GDB-Simulator for various target architectures.

## [DockerHub](https://hub.docker.com/r/blukat29/cross/)

## How to use

```
docker pull blukat29/cross
docker run -it blukat29/cross /bin/bash
```

Tools are located under `/usr/local/cross/bin`.

```
/usr/local/cross/bin/sparc-elf-readelf -h sparc.bin
/usr/local/cross/bin/m32r-elf-objdump -d m32r.bin
/usr/local/cross/bin/avr-elf-run avr.bin
```

## Supported Architectures

- arm-elf (ARM 32-bit)
- avr-elf (Amtel AVR 8-bit)
- cris-elf (ETRAX CRIS)
- frv-elf (Fujitsu FR-V)
- h8300-elf (Renesas H8/300)
- m32r-elf (Renesas M32R)
- m6811-elf (Freescale 68HC11)
- mcore-elf (Freescale M-CORE)
- mips64-elf (MIPS 64-bit)
- mips-elf (MIPS 32-bit)
- mips16-elf (MIPS 16-bit)
- mn10300 (Panasonic M103)
- powerpc-elf (PowerPC 32-bit)
- sh64-elf (Renesas SuperH 64-bit)
- sh-elf (Renesas SuperH 32-bit)
- sparc-elf (SPARC)
- v850-elf (NEC v850)

