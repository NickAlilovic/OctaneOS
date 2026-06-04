#!/bin/bash
# =============================================================================
# OctaneOS A733 post-build script
# Called by Buildroot after the rootfs is assembled, before squashfs packing.
# $1 = TARGET_DIR   $2 = HOST_DIR   $3 = BINARIES_DIR
# =============================================================================
set -euo pipefail

TARGET_DIR="$1"
# HOST_DIR is passed as an environment variable by Buildroot, not as $2
HOST_DIR="${HOST_DIR:-}"

# Fall back to locating the toolchain next to the kernel-66 tree
if [ -z "${HOST_DIR}" ]; then
    HOST_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../../../batocera/output/a733-cubie-a7s/host")"
fi

CROSS="${HOST_DIR}/bin/aarch64-buildroot-linux-gnu-"
KERNEL_DIR="$(dirname "${BASH_SOURCE[0]}")/../../../../linux/kernel-66"
KERNEL_DIR="$(realpath "${KERNEL_DIR}")"
GPU_MODULE_DIR="${KERNEL_DIR}/bsp/modules/gpu"

# =============================================================================
# Build pvrsrvkm.ko (Imagination PowerVR BXM-4-64 kernel module)
#
# The module source lives in bsp/modules/gpu/ which was prepared by
# setup-kernel-66.sh.  We build it out-of-tree using the already-built
# kernel and the Buildroot cross-compiler.
# =============================================================================
if [ ! -d "${GPU_MODULE_DIR}" ]; then
    echo "[post-build] WARNING: GPU module source not found at ${GPU_MODULE_DIR}"
    echo "[post-build] Run scripts/setup-kernel-66.sh first."
    exit 0
fi

echo "[post-build] Building pvrsrvkm.ko (PowerVR BXM-4-64)..."
make -C "${KERNEL_DIR}" \
    M="${GPU_MODULE_DIR}" \
    KERNEL_SRC_DIR="${KERNEL_DIR}" \
    KERNEL_OUT_DIR="${KERNEL_DIR}" \
    ARCH=arm64 \
    CROSS_COMPILE="${CROSS}" \
    PVR_SYSTEM=rgx_sunxi \
    RGX_BVNC=36.56.104.183 \
    WINDOW_SYSTEM=nulldrmws \
    CONFIG_OS_TYPE=linux \
    -j$(nproc) \
    modules

# Find built .ko files and install them
KVER=$(cat "${KERNEL_DIR}/include/config/kernel.release" 2>/dev/null || \
       awk -F\" '/UTS_RELEASE/{print $2}' "${KERNEL_DIR}/include/generated/utsrelease.h" 2>/dev/null || \
       echo "unknown")

KO_DEST="${TARGET_DIR}/lib/modules/${KVER}/extra"
mkdir -p "${KO_DEST}"

find "${GPU_MODULE_DIR}" -name "pvrsrvkm.ko" | while read ko; do
    "${CROSS}strip" --strip-debug "${ko}" -o "${KO_DEST}/pvrsrvkm.ko"
    echo "[post-build] Installed: ${KO_DEST}/pvrsrvkm.ko"
done

echo "[post-build] pvrsrvkm.ko done."
