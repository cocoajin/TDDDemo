
1. 两个lib.a里面同时编译有相同类库时，在项目 other link flag 为 -all_load 时，会出现
  重复编译错误； duplicate symbol _OBJC_XXX xxx.a(xxx.o);

2. 解决方案
  
  两个lib.a在编译时，去掉其中一个lib.a中的 该相同类库；
  或是 在 项目 other link flag 去掉 -all_load 设置