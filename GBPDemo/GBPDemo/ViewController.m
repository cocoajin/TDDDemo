//
//  ViewController.m
//  GBPDemo
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

    
//    Person *pe = [[Person alloc]init];
//    pe.name = @"jobs";
//    pe.age = 86;
//    pe.address = @"Beijing";

    
//    NSData *pd = [pe data];
//    [pd writeToFile:@"/Users/cocoajin/Desktop/person.data" atomically:YES];
//    
//    NSData *inDT = [NSData dataWithContentsOfFile:@"/Users/cocoajin/Desktop/person.data"];
//    Person *inp = [Person parseFromData:inDT error:nil];
//    NSLog(@"2: %@",inp);
    
    
    
    Person *pe = [[Person alloc]init];
    pe.name = @"jobs";
    pe.age = 86;
    pe.address = @"Beijing";
    
    //以下是效率对比
    //protocbufer
    NSLog(@"protocbufer: %@",pe);
    NSLog(@"%lu",[pe data].length);
    
    
    //json
    NSDictionary *pj = @{@"name":@"jobs",
                           @"age":@86,
                           @"address":@"Beijing"};
    NSData *jsd = [NSJSONSerialization dataWithJSONObject:pj options:0 error:nil];
    NSLog(@"JSON: %@",pj);
    NSLog(@"%lu", jsd.length);
    
    
    //xml
    NSString *xml = @"<name>jobs</name><age>86</age><address>Beijing</address>";
    NSData *xmlData = [xml dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"XML: %@",xml);
    NSLog(@"%lu",xmlData.length);
    
    [pe release];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
