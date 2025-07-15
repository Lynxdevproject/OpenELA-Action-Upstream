#!/bin/bash
set -e

# 🧠 Load Config
source config.env

# 📦 Define Paths
KERNEL_DIR="$(pwd)"
OUT_DIR="${KERNEL_DIR}/out"
TOOLCHAIN_DIR="${KERNEL_DIR}/${TOOLCHAIN}"
DEFCONFIG="${DEFCONFIG:-defconfig}"

# 🔧 Clean Up
rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"

# 🔨 Export Toolchain
export PATH="${TOOLCHAIN_DIR}/bin:${PATH}"
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

# 🧬 Start Build
make -C "${KERNEL_DIR}" O="${OUT_DIR}" "${DEFCONFIG}"
make -C "${KERNEL_DIR}" O="${OUT_DIR}" -j$(nproc)

# 📦 Output
echo "✅ Build complete — output in ${OUT_DIR}"
