#!/bin/bash

# mt7921
rm -rf package/kernel/rtl8821cu
rm -rf package/kernel/mac80211
rm -rf package/kernel/mt76
rm -rf package/network/services/hostapd

svn export https://github.com/openwrt/openwrt/trunk/package/kernel/mt76 package/kernel/mt76
svn export https://github.com/openwrt/openwrt/trunk/package/kernel/mac80211 package/kernel/mac80211
svn export https://github.com/openwrt/openwrt/trunk/package/network/services/hostapd package/network/services/hostapd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# panfrost gpu
rm ./target/linux/rockchip/modules.mk
rm ./package/kernel/linux/modules/video.mk
cp ../build/patch/modules-6.1/modules.mk ./target/linux/rockchip/modules.mk
cp ../build/patch/modules-6.1/video.mk ./package/kernel/linux/modules/video.mk

# tty console
cp ../build/patch/armv8/base-files/etc/inittab ./target/linux/rockchip/armv8/base-files/etc/inittab

# build image
rm -rf target/linux/rockchip/image/armv8.mk
cp -f ../build/patch/rockchip/image/armv8-r5c.mk ./target/linux/rockchip/image/armv8.mk

# kernel-6.1 patches
sed -i 's/5.4/6.1/g' ./target/linux/rockchip/Makefile
cp -r ../build/patch/rockchip/patches-6.1/ ./target/linux/rockchip/patches-6.1/

# build config
cp ../build/r5c.config .config
