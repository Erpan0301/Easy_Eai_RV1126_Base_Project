#!/bin/bash
set -e

TARGET_IP="192.168.1.160"
USERNAME="nano"
PASSWORD="123456"
TARGET_PATH="/userdata/apps"
LOCAL_BINARY="build/hello_rv1126"

if [ ! -f "$LOCAL_BINARY" ]; then
    echo "❌ 构建产物 $LOCAL_BINARY 不存在，请先运行 ./build.sh"
    exit 1
fi

echo ">>> 创建目标目录（如不存在）..."
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no ${USERNAME}@${TARGET_IP} "mkdir -p ${TARGET_PATH}"

echo ">>> 正在部署 $LOCAL_BINARY 到 ${TARGET_IP}:${TARGET_PATH}/"
sshpass -p "$PASSWORD" scp -o StrictHostKeyChecking=no "$LOCAL_BINARY" ${USERNAME}@${TARGET_IP}:${TARGET_PATH}/

echo "✅ 部署完成。你可以在开发板上运行："
echo "   ${TARGET_PATH}/hello_rv1126"
