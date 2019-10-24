set GOPATH=%~dp0;%GOPATH%
set PATH=%~dp0/bin:%PATH%

set ANDROID_NDK_HOME=D:\\Android\\android-ndk-r20

set NDKARCH=windows-x86_64

set GOOS=android

set CGO_ENABLED=1


set GOARCH=arm64
set CC=%ANDROID_NDK_HOME%/toolchains/llvm/prebuilt/%NDKARCH%/bin/aarch64-linux-android21-clang.cmd
set CXX=%ANDROID_NDK_HOME%/toolchains/llvm/prebuilt/%NDKARCH%/bin/aarch64-linux-android21-clang++.cmd
go build -o ./Plugins/Android/libs/arm64-v8a/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go


set GOARCH=arm
set GOARM=7
set CC=%ANDROID_NDK_HOME%/toolchains/llvm/prebuilt/%NDKARCH%/bin/armv7a-linux-androideabi16-clang.cmd
set CXX=%ANDROID_NDK_HOME%/toolchains/llvm/prebuilt/%NDKARCH%/bin/armv7a-linux-androideabi16-clang++.cmd
go build -o ./Plugins/Android/libs/armeabi-v7a/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go


set GOARCH=386
set CC=%ANDROID_NDK_HOME%/toolchains/llvm/prebuilt/%NDKARCH%/bin/i686-linux-android16-clang.cmd
set CXX=%ANDROID_NDK_HOME%/toolchains/llvm/prebuilt/%NDKARCH%/bin/i686-linux-android16-clang++.cmd
go build -o ./Plugins/Android/libs/x86/libNativePlugin.so -buildmode=c-shared src/NativePlugin/main.go

