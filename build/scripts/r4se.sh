#!/bin/bash

# Add cpufreq
rm -rf ./feeds/luci/applications/luci-app-cpufreq 
svn export https://github.com/DHDAXCW/luci-bt/trunk/applications/luci-app-cpufreq ./feeds/luci/applications/luci-app-cpufreq
ls -lah ./feeds/luci/applications/luci-app-cpufreq/po/zh_Hans
mv ./feeds/luci/applications/luci-app-cpufreq/po/zh_Hans ./feeds/luci/applications/luci-app-cpufreq/po/zh-cn
ls -lah ./feeds/luci/applications/luci-app-cpufreq/po/zh-cn
ln -sf ./feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq
sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq

# panfrost gpu
rm ./target/linux/rockchip/modules.mk
rm ./package/kernel/linux/modules/video.mk
cp ../build/patch/modules-5.4/modules.mk ./target/linux/rockchip/modules.mk
cp ../build/patch/modules-5.4/video.mk ./package/kernel/linux/modules/video.mk

# overclock
rm -f ./target/linux/rockchip/patches-5.4/992-rockchip-rk3399-overclock-to-2.2-1.8-GHz-for-NanoPi4.patch
cp ../build/patch/rockchip/patches-5.4/992-rockchip-rk3399-overclock-to-2.2-1.8-GHz-for-NanoPi4.patch ./target/linux/rockchip/patches-5.4/992-rockchip-rk3399-overclock-to-2.2-1.8-GHz-for-NanoPi4.patch

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/10.0.1.1/g' package/base-files/files/bin/config_generate

# kernel
sed -i 's/6.1/5.4/g' ./target/linux/rockchip/Makefile

# build config
cp ../build/r4se.config .config