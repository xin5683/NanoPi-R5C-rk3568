#!/bin/bash

OPENWRTROOT=$(pwd)
export OPENWRTROOT

make defconfig
make download -j8
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;
ls -lah dl
