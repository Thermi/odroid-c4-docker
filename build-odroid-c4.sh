#!/bin/bash
cd odroid-c4
export MAKEFLAGS="-j$(nproc)"
lunch odroidc4-eng

make clean
source build/envsetup.sh
make
