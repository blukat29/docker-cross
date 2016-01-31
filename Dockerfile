FROM ubuntu:14.04

RUN sed -i 's/archive.ubuntu.com/ftp.kaist.ac.kr/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
  build-essential \
  gcc \
  make \
  texinfo \
  curl \
  && apt-get clean

ENV BINUTILS_VERSION 2.25.1
ENV GDB_VERSION 7.10
ENV PREFIX /usr/local/cross
RUN mkdir -p $PREFIX

WORKDIR /tmp

RUN curl -o binutils.tar.bz2 http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.bz2
RUN tar xf binutils.tar.bz2

RUN curl -o gdb.tar.xz http://ftp.gnu.org/gnu/gdb/gdb-$GDB_VERSION.tar.xz
RUN tar xf gdb.tar.xz

COPY setup-binutils.sh /tmp/setup-binutils.sh
COPY setup-gdb.sh /tmp/setup-gdb.sh

RUN sh setup-binutils.sh arm-elf
RUN sh setup-binutils.sh avr-elf
RUN sh setup-binutils.sh cris-elf
RUN sh setup-binutils.sh frv-elf
RUN sh setup-binutils.sh h8300-elf
RUN sh setup-binutils.sh m32r-elf
RUN sh setup-binutils.sh m6811-elf
RUN sh setup-binutils.sh mcore-elf
RUN sh setup-binutils.sh mips64-elf
RUN sh setup-binutils.sh mips16-elf
RUN sh setup-binutils.sh mips-elf
RUN sh setup-binutils.sh mn10300-elf
RUN sh setup-binutils.sh powerpc-elf
RUN sh setup-binutils.sh sh64-elf
RUN sh setup-binutils.sh sh-elf
RUN sh setup-binutils.sh sparc-elf
RUN sh setup-binutils.sh v850-elf

RUN sh setup-gdb.sh arm-elf
RUN sh setup-gdb.sh avr-elf
RUN sh setup-gdb.sh cris-elf
RUN sh setup-gdb.sh frv-elf
RUN sh setup-gdb.sh h8300-elf
RUN sh setup-gdb.sh m32r-elf
RUN sh setup-gdb.sh m6811-elf
#RUN sh setup-gdb.sh mcore-elf
RUN sh setup-gdb.sh mips64-elf
RUN sh setup-gdb.sh mips16-elf
RUN sh setup-gdb.sh mips-elf
RUN sh setup-gdb.sh mn10300-elf
RUN sh setup-gdb.sh powerpc-elf
RUN sh setup-gdb.sh sh64-elf
RUN sh setup-gdb.sh sh-elf
#RUN sh setup-gdb.sh sparc-elf
RUN sh setup-gdb.sh v850-elf

