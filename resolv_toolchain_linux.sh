#!/bin/bash

TOOLCHAIN_DIR="${PWD}/toolchain"

if [ ! -d "$TOOLCHAIN_DIR" ]; then
    mkdir -p "$TOOLCHAIN_DIR"
fi

# Setup gcc prebuilds 
echo "[TOOLCHAIN] Setting up gcc prebuilts"
cd $TOOLCHAIN_DIR || exit
if [ ! -d "$TOOLCHAIN_DIR/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9" ]; then
    git clone https://github.com/SaicharanKandukuri/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git || {
        echo "[TOOLCHAIN] Failed to clone gcc prebuilts"
        exit 1
    }
    echo "[TOOLCHAIN] gcc prebuilts setup completed"
else
    echo "[TOOLCHAIN] gcc prebuilts already exists"
fi

# Setup clang prebuilds
if [ ! -d "$TOOLCHAIN_DIR/clang-4691093" ]; then
    echo "[TOOLCHAIN] Setting up clang prebuilts"

    [[ -f clang-4691093.tar.gz ]] && rm clang-4691093.tar.gz
    
    wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/android-9.0.0_r1/clang-4691093.tar.gz || {
        echo "[TOOLCHAIN] Failed to download clang prebuilts [https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/android-9.0.0_r1/clang-4691093.tar.gz]"
        exit 1
    }
    mkdir -p clang-4691093
    tar -xf clang-4691093.tar.gz -C clang-4691093
    echo "[TOOLCHAIN] Clang prebuilts setup completed"
fi
