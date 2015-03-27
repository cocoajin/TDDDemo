//
//  PageViewController.m
//  ComicBook
//
//  Created by jinkeke@techshino.com on 15/3/17.
//  Copyright (c) 2015年 www.techshino.com. All rights reserved.
//

#import "PageViewController.h"
#import "AsyncImageView.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageV.imageURL = [NSURL URLWithString:self.imgUrl];
    [self.view addSubview:imageV];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
