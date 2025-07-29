#!/bin/bash
set -e

BUILD_DIR="build"
TOOLCHAIN_FILE="toolchain-rv1126.cmake"

echo ">>> [1/2] 配置 CMake..."
cmake -B "$BUILD_DIR" -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" -G Ninja

echo ">>> [2/2] 开始构建..."
cmake --build "$BUILD_DIR" -j$(nproc)

echo "✅ 构建完成，输出文件: $BUILD_DIR/hello_rv1126"
