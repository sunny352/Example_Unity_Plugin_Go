# Example_Unity_Plugin_Go
使用Go编写Unity插件的一个示例

要想将Go编写的库嵌入到Unity中使用的话，需要使用Go的C接口，也就是cgo部分

编译dll需要安装MinGW-w64

iOS由于是链接静态库，所以archive库和framework库不可以同时存在，否则启动就闪退

Android的Native库需要把.h文件去掉，不然会报告重名

C#在参数和返回值直接使用MarshalAs方式处理字符串的时候，无需手动处理内存释放

UnmanagedType.LPUTF8Str需要开启.net 4.x支持