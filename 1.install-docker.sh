#!/bin/bash

apt-get install -y mc ncdu htop sysstat iftop glances

sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    zsh 

# Make zsh default shell
chsh -s $(which zsh)

echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu artful stable' >> /etc/apt/sources.list.d/docker.list

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo timedatectl set-timezone UTC

# Old production version
#sudo apt-get install -y docker-ce=18.06.3~ce~3-0~ubuntu

# New production version
sudo apt-get install -y \
    docker-ce=5:19.03.5~3-0~ubuntu-bionic \
    docker-ce-cli=5:19.03.5~3-0~ubuntu-bionic \
    containerd.io

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

mkdir -p ~/.docker
cp config.json ~/.docker

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Append custom config to zsh
cat zshrc-append.txt >> ~/.zshrc

# Remove news on login
rm /etc/update-motd.d/10-help-text
rm /etc/update-motd.d/50-motd-news


if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
fi

touch ~/.ssh/authorized_keys

echo "-----------------------"

cat ~/.ssh/id_rsa.pub