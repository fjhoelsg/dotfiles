#!/bin/sh

# Enable universe repository
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y apt-transport-https software-properties-common
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository universe

# Install packages
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y \
  autoconf \
  automake \
  bsdmainutils \
  build-essential \
  coreutils \
  ca-certificates \
  curl \
  dash \
  findutils \
  g++ \
  gcc \
  git \
  git-lfs \
  gnupg-agent \
  golang \
  gpg \
  gnupg2 \
  gnupg-agent \
  htop \
  imagemagick \
  libssl-dev \
  make \
  neovim \
  nodejs \
  openjdk-11-jdk \
  openssh-client \
  openssl \
  python3 \
  python3-neovim \
  python3-pip \
  tmux \
  tree \
  unzip \
  wget \
  zsh
sudo DEBIAN_FRONTEND=noninteractive apt autoremove --purge -y
sudo DEBIAN_FRONTEND=noninteractive apt clean all

# Replace default shell with dash
sudo ln -sf "$(which dash)" /bin/sh

# Kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y kubectl

# Node
curl -sSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt install -y nodejs
