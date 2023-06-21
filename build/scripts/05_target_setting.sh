#!/bin/bash

OPENWRTROOT=$(pwd)
export OPENWRTROOT

mkdir -p files/root
pushd files/root

## Install oh-my-zsh
# Clone oh-my-zsh repository
git clone https://github.com/ohmyzsh/ohmyzsh ./.oh-my-zsh

# Install extra plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ./.oh-my-zsh/custom/plugins/zsh-completions

# Get .zshrc dotfile
cp ../../../build/scripts/.zshrc .
cp ../../../build/scripts/update.sh .

popd

mkdir -p files/etc
pushd files/etc
# System info
cp ../../../build/scripts/sysinfo.sh .
popd

source ../build/scripts/$MODEL.sh