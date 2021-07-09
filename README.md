# docker-cross

Docker image containing Binutils + GDB-Simulator for various target architectures.

## [DockerHub](https://hub.docker.com/r/blukat29/cross/)

## How to use

```
docker pull blukat29/cross:buster
docker run -v $(pwd):/work -it blukat29/cross:buster
```

Docker's `/work` will be shared with Host's current directory.

## Using the tools

Tools are installed under `/usr/local/cross/bin`, but it is in `$PATH`.

```
sparc-elf-readelf -h sparc.bin
m32r-elf-objdump -M m32r -d m32r.bin
avr-elf-run avr.bin
```

## Supported Architectures

| Architecture   | binutils | gdb-sim | Comment                                   |
|----------------|----------|---------|-------------------------------------------|
| aarch64-elf    | Y        | Y       | ARM 64-bit (includes thumb mode)          |
| alpha-linux    | Y        |         | DEC Alpha                                 |
| arc-elf        | Y        |         | Argonaut RISC Core                        |
| arm-elf        | Y        | Y       | ARM 32-bit (includes thumb mode)          |
| avr-elf        | Y        | Y       | Atmel AVR 8-bit                           |
| bfin-elf       | Y        | Y       | BlackFin 32-bit                           |
| cr16-elf       | Y        |         | CompactRISC 16-bit                        |
| cris-elf       | Y        | Y       | ETRAX CRIS                                |
| crx-elf        | Y        |         | CompactRISC 32-bit                        |
| fr30-elf       | Y        |         | Fujitsu FR30                              |
| frv-elf        | Y        | Y       | Fujitsu FR-V                              |
| h8300-elf      | Y        | Y       | Renesas H8/300                            |
| hppa-elf       | Y        |         | Hewlett-Packard PA-RISC                   |
| i960-elf       | Y        |         | Intel i960                                |
| ia64-elf       | Y        |         | Intel ia64                                |
| m32c-elf       | Y        | Y       | Midas M32C                                |
| m32r-elf       | Y        | Y       | Renesas M32R                              |
| m6811-elf      | Y        | Y       | Motorola 68HC11                           |
| m68k-elf       | Y        |         | Motorola m68k                             |
| mcore-elf      | Y        | Y       | Freescale M-CORE                          |
| microblaze-elf | Y        |         | Xilinx MicroBlaze                         |
| mips-elf       | Y        | Y       | MIPS 32-bit (includes big/little endians) |
| mips16-elf     | Y        | Y       | MIPS 16-bit mode (MIPS16e)                |
| mips64-elf     | Y        | Y       | MIPS 64-bit (includes big/little endians) |
| mmix-elf       | Y        |         | Donald Knuth's MMIX                       |
| mn10300-elf    | Y        | Y       | Panasonic MN103                           |
| msp430-elf     | Y        | Y       | Texas Instruments MSP430                  |
| powerpc-elf    | Y        | Y       | PowerPC 32-bit                            |
| powerpc64-elf  | Y        | Y       | PowerPC 64-bit                            |
| sh-elf         | Y        | Y       | Renesas SuperH 32-bit                     |
| sh64-elf       | Y        | Y       | Renesas SuperH 64-bit (SH5)               |
| sparc-elf      | Y        | Y       | SPARC                                     |
| v850-elf       | Y        | Y       | NEC V850                                  |
| wasm32-elf     | Y        |         | WebAssembly                               |
| x86\_64-linux  | Y        |         | x86-64                                    |
| xtensa-elf     | Y        |         | Tensilica Xtensa                          |

