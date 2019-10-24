#!/usr/bin/env bash

export GOPATH=${PWD}
export PATH=${PWD}/bin:$PATH

export ANDROID_NDK_HOME="/Users/zhangmingzhen/Documents/NDK/android-ndk-r20"
export ANDROID_HOME="/Users/zhangmingzhen/Documents/android_sdk"

if [[ ! -d ./Plugins/Android ]]; then
    mkdir -p ./Plugins/Android
fi

./bin/gomobile bind -target=android -o ./Plugins/Android/PlatformPlugin.aar -ldflags="-w" PlatformPlugin