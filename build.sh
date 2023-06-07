#!/bin/bash

#
# build.sh - A helper script to build the kernel
# (c) 2023 by github.com/saicharankandukuri <saicharankandukuri1x1@gmail.com>
#
# Usage: ./build.sh

CLANG_BIN="${PWD}/toolchain/clang-4691093/bin"
GCC_BIN="${PWD}/toolchain/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin"
FILENAME=$(basename "$0")

# check for toolchain dir
if [ ! -d "$CLANG_BIN" ] || [ ! -d "$GCC_BIN" ]; then
    echo "[BUILD]: Toolchain not found.."
    echo "[BUILD]: Run ./resolv_toolchain_linux.sh to resolve toolchain"
    exit 1
else
    echo "[BUILD]: Toolchain found.."
fi


function K_MAKE() {
    local options=$*
    
    echo
    echo "[K_MAKE]: $options"
    sleep 1
    
    ANDROID_MAJOR_VERSION=s \
        O=out \
        PLATFORM_VERSION=12 \
        CC="$CLANG_BIN/clang" \
        CLANG_TRIPLE="$GCC_BIN/aarch64-linux-gnu-" \
        CROSS_COMPILE="$GCC_BIN/aarch64-linux-android-" \
        make ARCH=arm64 CONFIG_SECTION_MISMATCH_WARN_ONLY=y $options
}

# if filename is cleanup then cleanup
if [ "$FILENAME" == "cleanup" ]; then
    echo "[BUILD]: Cleaning up.."
    K_MAKE mrproper
    K_MAKE clean
    exit 0
fi

# if filename is cleanup then cleanup
if [ "$FILENAME" == "menuconfig" ]; then
    echo "[BUILD]: Cleaning up.."
    K_MAKE exynos9610-m31nsxx_defconfig
    K_MAKE menuconfig
    exit 0
fi

K_MAKE exynos9610-m31nsxx_defconfig
# K_MAKE menuconfig
K_MAKE -j$(nproc --all)

# AIK pack

echo "[BUILD]: AIK pack.."
echo -e "\t ./SM-M315f_kernel.sh"

cp -rv arch/arm64/boot/Image ./AIK/Image
cp -rv arch/arm64/boot/dtb_exynos.img AIK/dtb
cp -rv arch/arm64/boot/dtbo_exynos.img AIK/dtbo

cd AIK || exit 1
rm -vf ./*.zip
zip -r ../SM-M315f_kernel.zip * -x .git README.md
cd .. || exit 1

