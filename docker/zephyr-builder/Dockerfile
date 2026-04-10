FROM ubuntu:22.04

LABEL description="Zephyr RTOS build environment"

ENV DEBIAN_FRONTEND=noninteractive

ARG ZEPHYR_SDK_VERSION=0.16.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    gperf \
    ccache \
    dfu-util \
    device-tree-compiler \
    wget \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-tk \
    python3-wheel \
    python3-venv \
    xz-utils \
    file \
    make \
    gcc \
    gcc-multilib \
    g++-multilib \
    libsdl2-dev \
    libmagic1 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install west and Zephyr Python deps
RUN pip3 install --no-cache-dir west pyelftools

# Install Zephyr SDK (minimal — aarch64 toolchain only)
ENV ZEPHYR_SDK_INSTALL_DIR=/opt/zephyr-sdk-${ZEPHYR_SDK_VERSION}
RUN wget -q https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK_VERSION}/zephyr-sdk-${ZEPHYR_SDK_VERSION}_linux-x86_64_minimal.tar.xz \
    && tar xf zephyr-sdk-${ZEPHYR_SDK_VERSION}_linux-x86_64_minimal.tar.xz -C /opt/ \
    && rm zephyr-sdk-${ZEPHYR_SDK_VERSION}_linux-x86_64_minimal.tar.xz \
    && cd /opt/zephyr-sdk-${ZEPHYR_SDK_VERSION} \
    && ./setup.sh -t aarch64-zephyr-elf -c

WORKDIR /workspace

CMD ["/bin/bash"]
