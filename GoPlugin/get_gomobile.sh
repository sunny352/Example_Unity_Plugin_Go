#!/usr/bin/env bash

export http_proxy=http://127.0.0.1:1081
export https_proxy=http://127.0.0.1:1081

export GOPATH=${PWD}
export PATH=${PWD}/bin:$PATH

go get -u -v golang.org/x/mobile/cmd/gomobile
go get -u -v golang.org/x/tools/go/packages

./bin/gomobile init