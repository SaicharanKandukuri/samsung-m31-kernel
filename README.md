# Samsung M31 (SM-M315F) - Device Kernel Source

Kernel source code of Samsung Galaxy M31 (SM-M315F) for my personal study.

[![Android kernel build test](https://github.com/SaicharanKandukuri/samsung-m31-kernel/actions/workflows/build-kernel.yml/badge.svg)](https://github.com/SaicharanKandukuri/samsung-m31-kernel/actions/workflows/build-kernel.yml)

- Build utilities are specially created for **linux amd64** hosts. [build.sh](build.sh)
- less headache with **aarch64** toolchain. [**resolv_toolchain_linux.sh**](resolv_toolchain_linux.sh)

> **Note:** This is not an official Samsung repository.

```
Linux kernel
============

This file was moved to Documentation/admin-guide/README.rst

Please notice that there are several guides for kernel developers and users.
These guides can be rendered in a number of formats, like HTML and PDF.

In order to build the documentation, use ``make htmldocs`` or
``make pdfdocs``.

There are various text files in the Documentation/ subdirectory,
several of them using the Restructured Text markup notation.
See Documentation/00-INDEX for a list of what is contained in each file.

Please read the Documentation/process/changes.rst file, as it contains the
requirements for building and running the kernel, and information about
the problems which may result by upgrading your kernel.

```

## Build


```bash
# setup host dependencies
apt install -y bc bison build-essential binutils-aarch64-linux-gnu ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick libncurses5 lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev

# setup toolchain
bash resolv_toolchain_linux.sh

# A cleanup is recommended
./cleanup

# Build
bash build_kernel.sh
```

<hr>

💪 💟 from [Saicharan Kandukuri](https://saicharankandukuri.me)
