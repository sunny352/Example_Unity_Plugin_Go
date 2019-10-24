set GOPATH=%~dp0;%GOPATH%
set PATH=%~dp0/bin:%PATH%

echo "需要安装MinGW64"

go build -o NativePlugin.dll -buildmode=c-shared src/NativePlugin/main.go