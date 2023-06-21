#!/bin/bash

OPENWRTROOT=$(pwd)
export OPENWRTROOT

pushd customfeeds

# Add luci-app-onliner (need luci-app-nlbwmon)
svn co https://github.com/immortalwrt/luci/branches/openwrt-18.06-k5.4/applications/luci-app-onliner luci/applications/luci-app-onliner

# Add luci-app-udp2raw
# git clone --depth=1 https://github.com/gngpp/luci-app-udp2raw luci/applications/luci-app-udp2raw
# svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/udp2raw packages/net/udp2raw

# Add luci-proto-modemmanager
svn co https://github.com/immortalwrt/luci/trunk/protocols/luci-proto-modemmanager luci/protocols/luci-proto-modemmanager

# Add tmate
git clone --depth=1 https://github.com/immortalwrt/openwrt-tmate

# Add gotop
svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/admin/gotop packages/admin/gotop

# Add minieap
svn co https://github.com/immortalwrt/packages/trunk/net/minieap packages/net/minieap

# Replace smartdns with the official version
rm -rf packages/net/smartdns
svn co https://github.com/openwrt/packages/trunk/net/smartdns packages/net/smartdns

# Add wg-quick
git clone https://github.com/gngpp/wg-quick package/network/utils/wg-quick

# Add luci-app-watchcat-plus
# rm -rf packages/utils/watchcat
# rm -rf luci/applications/luci-app-watchcat-plus
# svn co https://github.com/openwrt/packages/trunk/utils/watchcat packages/utils/watchcat
# git clone https://github.com/gngpp/luci-app-watchcat-plus.git luci/applications/luci-app-watchcat-plus

# Add luci-theme
# rm -rf luci/themes/luci-theme-design
# rm -rf luci/applications/luci-app-design-config
# git clone --depth=1 https://github.com/gngpp/luci-theme-design luci/themes/luci-theme-design 
# git clone --depth=1 https://github.com/gngpp/luci-app-design-config luci/applications/luci-app-design-config

# delete coremark
rm -rf packages/utils/coremark
svn export https://github.com/DHDAXCW/packages/trunk/utils/coremark packages/utils/coremark

# Add luci-aliyundrive-webdav
# rm -rf packages/multimedia/aliyundrive-webdav
# rm -rf luci/applications/luci-app-aliyundrive-webdav 
# svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav packages/multimedia/aliyundrive-webdav
# svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav luci/applications/luci-app-aliyundrive-webdav 

popd

