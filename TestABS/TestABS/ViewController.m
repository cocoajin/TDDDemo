//
//  ViewController.m
//  TestABS
//
//  Created by jinkeke@techshino.com on 15/10/26.
//  Copyright © 2015年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.titleLabel.text = NSLocalizedString(@"INDEX_TITLE", @"title");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
