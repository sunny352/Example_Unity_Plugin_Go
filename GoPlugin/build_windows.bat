set GOPATH=%~dp0;%GOPATH%
set PATH=%~dp0/bin:%PATH%

go build -o ./Plugins/NativePlugin.dll -buildmode=c-shared src/NativePlugin/main.go