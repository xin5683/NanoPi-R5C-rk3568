#!/bin/bash

OPENWRTROOT=$(pwd)
export OPENWRTROOT

pushd ../build/opkg
sed -i "s/subtarget/$SUBTARGET/g" distfeeds*.conf
sed -i "s/target\//$TARGET\//g" distfeeds*.conf
sed -i "s/platform/$PLATFORM/g" distfeeds*.conf
popd

mkdir -p files/etc/uci-defaults/
cp ../build/scripts/init-settings.sh files/etc/uci-defaults/99-init-settings

mkdir -p files/etc/opkg
cp ../build/opkg/distfeeds-packages-server.conf files/etc/opkg/distfeeds.conf.server

mkdir -p files/etc/opkg/keys
cp ../build/opkg/1035ac73cc4e59e3 files/etc/opkg/keys/1035ac73cc4e59e3

if [ -n "$KMODS_IN_FIRMWARE" ] && [ "$KMODS_IN_FIRMWARE" == "true" ]; then
    mkdir -p files/www/snapshots
    cp -r bin/targets files/www/snapshots
    cp ../build/opkg/distfeeds-18.06-local.conf files/etc/opkg/distfeeds.conf
else
    cp ../build//opkg/distfeeds-18.06-remote.conf files/etc/opkg/distfeeds.conf
fi

cp files/etc/opkg/distfeeds.conf.server files/etc/opkg/distfeeds.conf.mirror
sed -i "s/http:\/\/192.168.123.100:2345\/snapshots/https:\/\/openwrt.cc\/snapshots\/$(date +"%Y-%m-%d")\/lean/g" files/etc/opkg/distfeeds.conf.mirror

make package/install -j$(nproc) || make package/install -j1 V=s
make target/install -j$(nproc) || make target/install -j1 V=s

pushd $OPENWRTROOT/bin/targets/$TARGET/$SUBTARGET
ls -lah
find . -maxdepth 1 -type f -name "*rootfs*" -print0 | xargs -0 rm -f
ext4_target=$(find . | grep $MODEL | grep 'ext4' | grep 'img.gz' | sed 's|^./||')
squashfs_target=$(find . | grep $MODEL | grep 'squashfs' | grep 'img.gz' | sed 's|^./||')
echo "ext4_target: $ext4_target"
echo "squashfs_target: $squashfs_target"
if [ -n "$ext4_target" ] && [ -n "$squashfs_target" ]; then
    find . -maxdepth 1 -type f ! -name "$ext4_target" ! -name "$squashfs_target" -print0 | xargs -0 rm -f
    mv $ext4_target $VERSION-$MODEL-ext4-sysupgrade.img.gz
    mv $squashfs_target $VERSION-$MODEL-squashfs-sysupgrade.img.gz
else
    if [ -n "$ext4_target" ]; then
        find . -maxdepth 1 -type f ! -name "$ext4_target" -print0 | xargs -0 rm -f
        mv $ext4_target $VERSION-$MODEL-ext4-sysupgrade.img.gz
    fi
    if [ -n "$squashfs_target" ]; then
        find . -maxdepth 1 -type f ! -name "$squashfs_target" -print0 | xargs -0 rm -f
        mv $squashfs_target $VERSION-$MODEL-squashfs-sysupgrade.img.gz
    fi
fi
popd

pushd $OPENWRTROOT
make checksum
mv $OPENWRTROOT/bin/targets/$TARGET/$SUBTARGET/sha256sums $OPENWRTROOT/bin/targets/$TARGET/$SUBTARGET/$VERSION-$MODEL-sha256sums
popd
