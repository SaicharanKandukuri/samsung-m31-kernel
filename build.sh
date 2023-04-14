#!/bin/bash

#
# build.sh - A helper script to build the kernel
# (c) 2023 by github.com/saicharankandukuri <saicharankandukuri1x1@gmail.com>
#
# Usage: ./build.sh

CLANG_BIN="${PWD}/toolchain/clang-4691093/bin"
GCC_BIN="${PWD}/toolchain/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin"

function K_MAKE() {
    local options=$*
    
    ANDROID_MAJOR_VERSION=s \
        O=out \
        PLATFORM_VERSION=12 \
        CC="$CLANG_BIN/clang" \
        CLANG_TRIPLE="$GCC_BIN/aarch64-linux-gnu-" \
        CROSS_COMPILE="$GCC_BIN/aarch64-linux-android-" \
        make ARCH=arm64 CONFIG_SECTION_MISMATCH_WARN_ONLY=y $options
}

K_MAKE mrproper
K_MAKE clean
K_MAKE exynos9610-m31nsxx_defconfig
K_MAKE -j$(nproc --all)
