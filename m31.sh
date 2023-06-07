#!/bin/bash

export CC=$(pwd)/../clang/bin/clang CROSS_COMPILE=$(pwd)/../toolchain/bin/aarch64-linux-android- CLANG_TRIPLE=aarch64-linux-gnu-
make clean && make mrproper
export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s


make ARCH=arm64 exynos9610-m31nsxx_defconfig
make ARCH=arm64 -j16

cp -r arch/arm64/boot/Image AIK/Image
cp -r arch/arm64/boot/dtb_exynos.img AIK/dtb
cp -r arch/arm64/boot/dtbo_exynos.img AIK/dtbo
cd AIK
rm -rf LMAO_kernel_m31.zip
rm -rf LMAO_kernel_m31s.zip
zip -r9 LMAO_kernel_m31.zip * -x .git README.md *placeholder
cd ..
