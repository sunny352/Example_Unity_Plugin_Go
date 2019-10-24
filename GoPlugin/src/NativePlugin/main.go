package main

import (
	"NativePlugin/InnerLib"
	"time"
	"unsafe"
)

/*
#include <stdlib.h>
*/
import "C"

//export GetTime
func GetTime() *C.char {
	value := C.CString(time.Now().String() + " 测试")
	return value
}

//export FreeStr
func FreeStr(str *C.char) {
	C.free(unsafe.Pointer(str))
}

func main() {
}

//export GetNativeValue
func GetNativeValue() int {
	return InnerLib.TestFunc()
}

func init() {

}
