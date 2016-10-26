//
//  ViewController.m
//  JSCF
//
//  Created by cocoa on 16/10/25.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"

@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *theWeb;
    JSContext *jsCXT;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //以下使用javascriptcore.framewordk
    
    //适用于iOS7.0
    
    theWeb = [[UIWebView alloc]initWithFrame:self.view.bounds];
    theWeb.scalesPageToFit = YES;
    theWeb.delegate = self;
    [self.view addSubview:theWeb];
    
    NSURL *reqUrl = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"js2.html" ofType:nil]];
    [theWeb loadRequest:[NSURLRequest requestWithURL:reqUrl]];


}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //使用webview的js执行环境
    jsCXT = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //异常处理
    jsCXT.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    
    
//    //OC 调用JS
//    [jsCXT[@"sdkhi2"] callWithArguments:nil];
//    sdkhito
//    [jsCXT[@"sdkhito"] callWithArguments:@[@"aa"]];
    
    
    //注册一个方法由js调用
    jsCXT[@"ocsayhi"] = ^(NSString *name) {
        NSLog(@"say hi to %@",name);
    };
    
    
    Person *pp = [[Person alloc]init];
    pp.firstName = @"cc";
    pp.lastName = @"j";
    pp.site = @"baidu.com";
    jsCXT[@"pl"] = pp;
    
    
    [jsCXT evaluateScript:@"alert(pl.fullyName())"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
