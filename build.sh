#!/bin/bash
set -e

# 🧠 Load Configuration
source config.env

# 📁 Paths
KERNEL_DIR="$(pwd)"
OUT_DIR="${KERNEL_DIR}/out"
TOOLCHAIN_DIR="${KERNEL_DIR}/${TOOLCHAIN}"

# 🔧 Clean Previous Builds
echo "🧹 Cleaning old output..."
rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"

# 🔌 Export Build Environment
export PATH="${TOOLCHAIN_DIR}/bin:${PATH}"
export ARCH="${ARCH:-arm64}"
export SUBARCH="${ARCH}"
export CROSS_COMPILE="${CROSS_COMPILE:-aarch64-linux-android-}"

# 🔬 Kernel Info
echo "🔧 Building with defconfig: ${DEFCONFIG}"
echo "🛠️ Toolchain path: ${TOOLCHAIN_DIR}"

# 🧱 Run Defconfig
make -C "${KERNEL_DIR}" O="${OUT_DIR}" "${DEFCONFIG}"

# 🚀 Start Compilation
make -C "${KERNEL_DIR}" O="${OUT_DIR}" -j$(nproc) 2>&1 | tee build.log

# 📦 Final Output
echo "✅ Build finished!"
ls -lh "${OUT_DIR}/Image.gz-dtb" || echo "⚠️ Image.gz-dtb not found"

# 🧾 Optional: zip output
# zip -r "${KERNEL_NAME}-${VERSION}.zip" out/
