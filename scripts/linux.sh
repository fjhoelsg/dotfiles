#!/bin/sh

# Prepend options to resolv.conf
if [ -f "/etc/resolv.conf" ]; then
  echo "options timeout:1 rotate" > /tmp/resolv.conf
  cat /etc/resolv.conf >> /tmp/resolv.conf
  sudo chown --reference=/etc/resolv.conf /tmp/resolv.conf
  sudo chmod --reference=/etc/resolv.conf /tmp/resolv.conf
  sudo rm -f /etc/resolv.conf
  sudo mv /tmp/resolv.conf /etc/resolv.conf 
fi

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
  keychain \
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
