#!/usr/bin/env bash

if [[ -d ./Plugins ]]; then
    rm -rf ./Plugins/
fi

echo "========== 编译iOS ==============================="
chmod +x build_iOS_archive.sh
./build_iOS_archive.sh

echo "========== 编译Android ==============================="
chmod +x build_Android_shared.sh
./build_Android_shared.sh

echo "========== 编译macOS ==============================="
chmod +x build_macos.sh
./build_macos.sh

echo "========== 编译windows ==============================="
chmod +x build_windows_cross.sh
./build_windows_cross.sh