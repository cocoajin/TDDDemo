//
//  RootViewController.m
//  KKBrowser
//
//  Created by jinkeke@techshino.com on 14-7-28.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];

    
    
    NSString *url = @"http://www.baidu.com";
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [webView loadRequest:requestUrl];
    
    
    
    
    self.view.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doSwipRight)];
    [swipRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipRight];
    
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doSwipLeft)];
    [swipLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipLeft];

    
    
    UITapGestureRecognizer *tapShare = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheIndexPage)];
    tapShare.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:tapShare];
    
    
}


- (void)tapTheIndexPage
{
    NSLog(@" **KK** [ %d ] %s 测试操作 %@",__LINE__,__FUNCTION__,@"双击");

}

- (void)doSwipRight
{
    //NSLog(@" **KK** [ %d ] %s 测试操作 %@",__LINE__,__FUNCTION__,@"右滑");
    [webView goBack];
}

- (void)doSwipLeft
{
    //NSLog(@" **KK** [ %d ] %s 测试操作 %@",__LINE__,__FUNCTION__,@"左滑");
    [webView goForward];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
