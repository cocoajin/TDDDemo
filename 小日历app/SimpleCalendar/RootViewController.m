//
//  RootViewController.m
//  SimpleCalendar
//
//  Created by jinkeke@techshino.com on 14-7-30.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UIWebViewDelegate>

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
    
    
    [self loadWebCalendar];
    [self setUpLoadingView];

    
    
}



- (void)setUpLoadingView
{
    loadingView  = [[UIView alloc]initWithFrame:self.view.bounds];
    loadingView.backgroundColor = [UIColor clearColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:loadingView.bounds];
    imageV.image = [UIImage imageNamed:@"Default.png"];
    [loadingView addSubview:imageV];
    [self.view addSubview:loadingView];
    
}

- (void)loadWebCalendar
{
    webCalendar = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webCalendar.backgroundColor = [UIColor clearColor];
    NSURL *url = [NSURL URLWithString:@"http://tuijs.com/calendar"];
    webCalendar.delegate = self;
    [webCalendar loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webCalendar];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (loadingView) {
        [loadingView removeFromSuperview];
        
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertShow = [[UIAlertView alloc]initWithTitle:@"加载错误" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertShow show];
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
