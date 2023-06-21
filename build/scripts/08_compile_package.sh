#!/bin/bash

OPENWRTROOT=$(pwd)
export OPENWRTROOT

echo -e "$(nproc) thread compile"
make package/compile -j$(nproc) || make package/compile -j$(nproc)
make package/index

cd $OPENWRTROOT/bin/packages/*
PLATFORM=$(basename `pwd`)
export PLATFORM

cd $OPENWRTROOT/bin/targets/*
TARGET=$(basename `pwd`)
export TARGET

cd *
SUBTARGET=$(basename `pwd`)
export SUBTARGET

FIRMWARE=$(pwd)
export FIRMWARE
