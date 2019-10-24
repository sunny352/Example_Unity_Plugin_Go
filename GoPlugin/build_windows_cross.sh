#!/usr/bin/env bash

if ! hash x86_64-w64-mingw32-gcc 2>/dev/null; then
    echo "找不到MinGW，安装"
    brew install mingw-w64
fi

export GOPATH=${PWD}:$GOPATH
export PATH=${PWD}/bin:$PATH

export CGO_ENABLED=1

echo "编译x86_64的dll"
export GOOS=windows
export GOARCH="amd64"
export CC="x86_64-w64-mingw32-gcc"

go build -o ./Plugins/NativePlugin.dll -buildmode=c-shared src/NativePlugin/main.go
echo "编译完成"