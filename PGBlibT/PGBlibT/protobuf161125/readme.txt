使用说明

1. 使用的是20161125最新的代码编译的静态库；
2. 支持模拟器和真机
3. 使用方式：全部导入Xcode工程，并在head search paths 里添加 $(PROJECT_DIR)/PGBlibT/protobuf161125

4. 如果工程是ARC,那么，由protobuf生成的代码 .m 文件需要添加 -fno-objc-arc , 因为protobuf不支持ARC