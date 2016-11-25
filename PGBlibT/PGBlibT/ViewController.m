//
//  ViewController.m
//  PGBlibT
//
//  Created by cocoa on 16/11/25.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "GPBProtocolBuffers.h"
#import "Person.pbobjc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"person.data" ofType:nil];
    NSData *peData = [NSData dataWithContentsOfFile:dataPath];
    NSError *pjError = nil;
    Person *ped = [Person parseFromData:peData error:&pjError];
    if (pjError) {
        NSLog(@"%@",pjError);
    }else
    {
        NSLog(@"%@",ped);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
