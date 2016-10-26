//
//  Person.h
//  JSAndOC
//
//  Created by cocoa on 16/10/25.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol PersonPtl <JSExport>

@property (nonatomic,copy)NSString *site;
/**
 对于多参数的方法，JavaScriptCore的转换方式将Objective-C的方法每个部分都合并在一起，冒号后的字母变为大写并移除冒号。比如下边协议中的方法，在JavaScript调用就是：doFooWithBar(foo, bar);
 
 **/
- (NSString *)fullyName;

@end

@interface Person : NSObject<PersonPtl>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;


@end
