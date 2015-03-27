//
//  ViewController.m
//  CookieTest
//
//  Created by jinkeke@techshino.com on 15/3/5.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"
#import "SVHTTPRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SVHTTPRequest POST:@"http://test2.sunniboy.com/UserCenter/Login" parameters:@{@"Email": @"kmj320@163.com",@"Password": @"11111111111111111111111111111111",@"FromType": @"1"} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        NSString *ut8=[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
        NSLog(@"rrr=%@",ut8);
        NSLog(@"cookies: %@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
