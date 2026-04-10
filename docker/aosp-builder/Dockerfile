FROM ubuntu:22.04

LABEL description="AOSP build environment"

ENV DEBIAN_FRONTEND=noninteractive

ARG GIT_USER_NAME="CI Builder"
ARG GIT_USER_EMAIL="ci@localhost"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git-core \
    gnupg \
    flex \
    bison \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    libc6-dev-i386 \
    x11proto-core-dev \
    libx11-dev \
    lib32z1-dev \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    fontconfig \
    libncurses5 \
    ccache \
    python3 \
    python-is-python3 \
    openjdk-17-jdk-headless \
    rsync \
    wget \
    ca-certificates \
    bc \
    coreutils \
    dosfstools \
    e2fsprogs \
    fdisk \
    kmod \
    mtools \
    openssl \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install repo tool
RUN curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \
    && chmod a+rx /usr/local/bin/repo

# Git config for repo (configurable via build args)
RUN git config --global user.email "${GIT_USER_EMAIL}" \
    && git config --global user.name "${GIT_USER_NAME}" \
    && git config --global color.ui false

ENV USE_CCACHE=1

WORKDIR /workspace

CMD ["/bin/bash"]
