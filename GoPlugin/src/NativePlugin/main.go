package main

import (
	"NativePlugin/InnerLib"
	"io/ioutil"
	"os"
	"time"
	"unsafe"
)

//
// #include <stdlib.h>
//
// typedef void(*OnEvent)(char*);
// static void callbackBridge(OnEvent callback, char* callbackInfo)
// {
//    callback(callbackInfo);
// }
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

//export GetStr
func GetStr() *C.char {
	return C.CString("测试")
}

//export SetStr
func SetStr(str *C.char) {
	goStr := C.GoString(str)
	ioutil.WriteFile("test_set_str.txt", []byte(goStr), os.ModePerm)
}

func main() {
}

//export GetNativeValue
func GetNativeValue() int {
	return InnerLib.TestFunc()
}

//export Delay
func Delay(callback C.OnEvent) {
	go func() {
		time.Sleep(time.Second)
		C.callbackBridge(callback, C.CString(time.Now().String()))
	}()
}

func init() {

}
