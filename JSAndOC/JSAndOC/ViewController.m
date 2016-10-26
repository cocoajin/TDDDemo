//
//  ViewController.m
//  JSAndOC
//
//  Created by cocoa on 16/10/25.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *theWeb;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    theWeb = [[UIWebView alloc]initWithFrame:self.view.bounds];
    theWeb.scalesPageToFit = YES;
    theWeb.delegate = self;
    [self.view addSubview:theWeb];
    
    
    //本示例方法适用于iOS 6 +
    
    NSURL *reqUrl = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"js1.html" ofType:nil]];
    [theWeb loadRequest:[NSURLRequest requestWithURL:reqUrl]];
    
    
    
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(100, 100, 100, 100);
    [clickBtn setTitle:@"clisk" forState:0];
    [clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:clickBtn];
    [clickBtn addTarget:self action:@selector(clickToCloseAlert) forControlEvents:UIControlEventTouchUpInside];
    
    

}

//OC调JS 并传参数
- (void)clickToCloseAlert
{
    //在弹出的alert中可能会有来自 xxx.html 字样 （百度去掉）
    [theWeb stringByEvaluatingJavaScriptFromString:@"sdkhito('cc')"];
}



//JS 调 OC 并传参数
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //访问如下自定义协议连接
    //request.URL   tcsdk://START?name=cc&age=18&phone=10086
    //request.URL.scheme   tcsdk 取出协议
    //request.URL.host     START 取出host
    //request.URL.query name=cc&age=18&phone=10086  取出参数
    NSLog(@"%@",request.URL);
    NSLog(@"%@",request.URL.scheme);
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
