FROM ubuntu:22.04

LABEL description="CMake cross-compilation environment for aarch64"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    file \
    && rm -rf /var/lib/apt/lists/*

# Toolchain file for aarch64 cross-compilation
RUN mkdir -p /opt/toolchains
COPY aarch64-linux-gnu.cmake /opt/toolchains/aarch64-linux-gnu.cmake

WORKDIR /workspace

CMD ["/bin/bash"]
