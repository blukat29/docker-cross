FROM debian:wheezy

RUN sed -i 's/deb.debian.org/ftp.kr.debian.org/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
  build-essential \
  texinfo \
  curl \
  libncurses-dev \
  binutils-multiarch \
  && rm -rf /var/lib/apt/lists/*

# Download sources
WORKDIR /opt
RUN mkdir -p scripts

COPY scripts/fetch.sh scripts/fetch.sh
RUN scripts/fetch.sh \
    http://ftp.gnu.org/gnu/binutils/binutils-2.25.1.tar.bz2 \
    binutils-src
RUN scripts/fetch.sh \
    http://ftp.gnu.org/gnu/gdb/gdb-7.9.1.tar.xz \
    gdb-src

# General build settings
ENV MAKEOPT "-j 7"
ENV PREFIX "/usr/local/cross/"
RUN mkdir -p $PREFIX

# Install binutils
COPY scripts/binutils.sh scripts/binutils.sh
RUN scripts/binutils.sh \
    avr-elf,cris-elf,fr30-elf,frv-elf,h8300-elf,i960-elf,ia64-elf,\
m6811-elf,mcore-elf,mn10300-elf,v850-elf

# Install gdb-sim.
COPY scripts/gdb.sh scripts/gdb.sh
RUN scripts/gdb.sh arm-elf
RUN scripts/gdb.sh avr-elf
RUN scripts/gdb.sh cris-elf
RUN scripts/gdb.sh frv-elf
RUN scripts/gdb.sh h8300-elf
RUN scripts/gdb.sh m32r-elf
RUN scripts/gdb.sh m6811-elf
RUN scripts/gdb.sh mips-elf
RUN scripts/gdb.sh mips16-elf
RUN scripts/gdb.sh mips64-elf
RUN scripts/gdb.sh mn10300-elf
RUN scripts/gdb.sh powerpc-elf
RUN scripts/gdb.sh sh-elf
RUN scripts/gdb.sh sh64-elf
RUN scripts/gdb.sh sparc-elf
RUN scripts/gdb.sh v850-elf

# For mcore-elf, make only gdb-sim because build breaks.
COPY scripts/mcore.sh scripts/mcore.sh
RUN scripts/mcore.sh

RUN rm -rf binutils-src gdb-src
RUN mkdir /root/shared
VOLUME /root/shared
CMD cd /root/shared && /bin/bash
