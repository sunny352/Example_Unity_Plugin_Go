#!/usr/bin/env bash

export GOPATH=${PWD}:$GOPATH
export PATH=${PWD}/bin:$PATH

if [[ ! $NDKARCH ]]; then
    if [[ "$(uname)"=="Darwin" ]];then
        export NDKARCH="darwin-x86_64"
    elif [[ "$(expr substr $(uname -s) 1 5)"=="Linux" ]];then
        export NDKARCH="linux-x86_64"
    fi
fi

export GOOS=android

export CGO_ENABLED=1

echo "编译arm64"
export GOARCH=arm64
export CC="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/aarch64-linux-android21-clang"
export CXX="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/aarch64-linux-android21-clang++"
go build -o ./Plugins/Android/libs/arm64-v8a/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go

echo "编译armv7"
export GOARCH=arm
export GOARM=7
export CC="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/armv7a-linux-androideabi16-clang"
export CXX="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/armv7a-linux-androideabi16-clang++"
go build -o ./Plugins/Android/libs/armeabi-v7a/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go

echo "编译x86"
export GOARCH=386
export CC="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/i686-linux-android16-clang"
export CXX="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/i686-linux-android16-clang++"
go build -o ./Plugins/Android/libs/x86/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go

#echo "编译x86_64"
#export GOARCH=amd64
#export CC="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/x86_64-linux-android21-clang"
#export CXX="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$NDKARCH/bin/x86_64-linux-android21-clang++"
#go build -o ./Plugins/Android/libs/x86_64/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go

echo "编译完成"