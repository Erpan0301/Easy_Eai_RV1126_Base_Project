#!/bin/bash
set -e

# === 项目参数 ===
BUILD_DIR="build"
TOOLCHAIN_FILE="toolchain-rv1126.cmake"
TARGET_BINARY="hello_rv1126"
LOCAL_BINARY="${BUILD_DIR}/${TARGET_BINARY}"

# === 目标设备信息 ===
TARGET_IP="192.168.1.160"
USERNAME="nano"
PASSWORD="123456"
TARGET_PATH="/userdata/apps"

# === 1. 构建项目 ===
echo ">>> [1/3] 正在构建项目..."
cmake -B "$BUILD_DIR" -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja
cmake --build "$BUILD_DIR" -j$(nproc)

# === 2. 检查构建产物 ===
if [ ! -f "$LOCAL_BINARY" ]; then
    echo "❌ 构建失败：未找到 $LOCAL_BINARY"
    exit 1
fi

# === 3. 部署到目标设备 ===
echo ">>> [2/3] 创建目标路径（如果不存在）..."
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no ${USERNAME}@${TARGET_IP} "mkdir -p ${TARGET_PATH}"

echo ">>> [3/3] 复制 ${LOCAL_BINARY} 到设备 ${TARGET_IP}:${TARGET_PATH}/"
sshpass -p "$PASSWORD" scp -o StrictHostKeyChecking=no "$LOCAL_BINARY" ${USERNAME}@${TARGET_IP}:${TARGET_PATH}/

echo "✅ 构建 + 部署完成。你可以在设备上运行："
echo "   ${TARGET_PATH}/${TARGET_BINARY}"
