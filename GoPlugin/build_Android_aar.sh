#!/usr/bin/env bash

export GOPATH=${PWD}:$GOPATH
export PATH=${PWD}/bin:$PATH

# export ANDROID_NDK_HOME=""
# export ANDROID_HOME=""

if [[ ! -d ./Plugins/Android ]]; then
    mkdir -p ./Plugins/Android
fi

./bin/gomobile bind -target=android -o ./Plugins/Android/PlatformPlugin.aar -ldflags="-w" PlatformPlugin