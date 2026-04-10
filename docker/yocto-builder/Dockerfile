FROM ubuntu:22.04

LABEL description="Yocto Project build environment"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    xz-utils \
    debianutils \
    iputils-ping \
    zstd \
    liblz4-tool \
    file \
    locales \
    libacl1 \
    ca-certificates \
    lz4 \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /workspace

CMD ["/bin/bash"]
