//
//  main.m
//  3DE
//
//  Created by Brandon Zhu on 29/10/2012.
//  Copyright (c) 2012 Brandon Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+ThreeDES.h"

#import "AppDelegate.h"

#define kKey @"b0326c4f1e0e2c2970584b14a5a36d1886b4b115"

int main(int argc, char *argv[])
{
    @autoreleasepool {
//        NSLog(@"kkkk >> %@",[kKey generateSecrectKey]);
        NSString *path1 = @"/Users/brandon_zhu/Desktop/jboss-web_3DES.xml";
        NSData *data1 = [[NSData alloc] initWithContentsOfFile:path1];
        NSString *stringBefore = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSString *enStr = [NSString decrypt:stringBefore withKey:kKey];
        NSLog(@"%@",enStr);
        NSLog(@"SHA1 %@",[kKey sha1]);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
