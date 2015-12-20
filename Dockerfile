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
RUN sh setup-binutils.sh mipsel-unknown-linux-gnu

COPY setup-gdb.sh /tmp/setup-gdb.sh
RUN sh setup-gdb.sh mipsel-unknown-linux-gnu


