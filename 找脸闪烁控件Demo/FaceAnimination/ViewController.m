//
//  ViewController.m
//  FaceAnimination
//
//  Created by jinkeke@techshino.com on 14-7-23.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"

#import "CircleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    
    CircleView *crView = [[CircleView alloc]initWithFrame:CGRectMake(0, 50, 320, 240)];
    
    [self.view addSubview:crView];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
