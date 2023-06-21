#!/bin/bash

OPENWRTROOT=$(pwd)
export OPENWRTROOT

echo -e "$(nproc) thread compile"
make tools/compile -j$(nproc)
make toolchain/compile -j$(nproc)
make target/compile -j$(nproc)
make diffconfig