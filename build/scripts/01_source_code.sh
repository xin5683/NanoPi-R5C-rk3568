#!/bin/bash

if [ -n "$MODEL" ] && [ "$MODEL" == "r5c" ]; then 
    git clone https://github.com/DHDAXCW/lede-rockchip -b stable --depth=1 openwrt;
fi

cd openwrt
rm -rf .git

OPENWRTROOT=$(pwd)
export OPENWRTROOT

mkdir customfeeds
# git clone --depth=1 https://github.com/coolsnowwolf/packages customfeeds/packages
# git clone --depth=1 https://github.com/coolsnowwolf/luci customfeeds/luci
git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages
git clone --depth=1 https://github.com/DHDAXCW/luci customfeeds/luci
