#!/usr/bin/env bash

echo "设置工程GOPATH"
export GOPATH=${PWD}:$GOPATH
export PATH=${PWD}/bin:$PATH

echo "设置操作系统为Darwin"
export GOOS=darwin

echo "设置CGO编译参数"
export CGO_ENABLED=1
export CGO_CFLAGS="$CGO_CFLAGS -fembed-bitcode"
export CGO_LDFLAGS="$CGO_LDFLAGS -fembed-bitcode"

echo "开始编译iOS真机版静态链接库 "
export CC="${PWD}/clangwrap_iphone.sh"
export CXX="${PWD}/clangwrap_iphone.sh"

echo "编译armv7"
export GOARCH=arm
export GOARM=7
go build -o ./iOS/temp/libNativePlugin_armv7.a -buildmode=c-archive src/NativePlugin/main.go

echo "编译arm64"
export GOARCH=arm64
go build -o ./iOS/temp/libNativePlugin_arm64.a -buildmode=c-archive src/NativePlugin/main.go

echo "开始编译iOS模拟器版静态链接库"
export CC="${PWD}/clangwrap_iphonesimulator.sh"
export CXX="${PWD}/clangwrap_iphonesimulator.sh"

echo "编译386"
export GOARCH="386"
go build -o ./iOS/temp/libNativePlugin_386.a -buildmode=c-archive src/NativePlugin/main.go

echo "编译amd64"
export GOARCH="amd64"
go build -o ./iOS/temp/libNativePlugin_amd64.a -buildmode=c-archive src/NativePlugin/main.go

echo "将不同架构的库合并为一个"
[[ ! -d ./Plugins/iOS/ ]] && mkdir -p ./Plugins/iOS/
lipo ./iOS/temp/libNativePlugin_386.a ./iOS/temp/libNativePlugin_amd64.a ./iOS/temp/libNativePlugin_arm64.a ./iOS/temp/libNativePlugin_armv7.a -create -output ./Plugins/iOS/libNativePlugin.a
cp ./iOS/temp/libNativePlugin_386.h ./Plugins/iOS/libNativePlugin.h
rm -rf ./iOS

echo "编译完成"