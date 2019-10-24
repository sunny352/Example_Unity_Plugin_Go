#!/bin/sh
# This uses the latest available iOS SDK, which is recommended.
# To select a specific SDK, run 'xcodebuild -showsdks'
# to see the available SDKs and replace iphoneos with one of them.
SDK=iphonesimulator
SDK_PATH=`xcrun --sdk $SDK --show-sdk-path`
export IPHONEOS_DEPLOYMENT_TARGET=8.0
# cmd/cgo doesn't support llvm-gcc-4.2, so we have to use clang.
CLANG=`xcrun --sdk $SDK --find clang`

if [[ "$GOARCH" == "386" ]]; then
	CLANGARCH="i386"
elif [[ "$GOARCH" == "amd64" ]]; then
	CLANGARCH="x86_64"
else
	echo "unknown GOARCH=$GOARCH" >&2
	exit 1
fi
#CLANGARCH="i386"

exec $CLANG -arch $CLANGARCH -isysroot $SDK_PATH -mios-version-min=8.0 "$@"
