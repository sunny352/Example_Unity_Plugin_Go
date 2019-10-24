#!/usr/bin/env bash

export GOPATH=${PWD}:$GOPATH
export PATH=${PWD}/bin:$PATH

echo "编译macOS的bundle"
go build -o ./Plugins/NativePlugin.bundle -buildmode=c-shared src/NativePlugin/main.go
echo "编译完成"