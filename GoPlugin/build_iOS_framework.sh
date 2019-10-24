#!/usr/bin/env bash

export GOPATH=${PWD}
export PATH=${PWD}/bin:$PATH

if [[ ! -d ./Plugins/iOS ]]; then
    mkdir -p ./Plugins/iOS
fi

./bin/gomobile bind -target=ios -o ./Plugins/iOS/PlatformPlugin.framework -ldflags="-w" PlatformPlugin