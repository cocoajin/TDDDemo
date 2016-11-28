//
//  ViewController.m
//  FakeGPS
//
//  Created by cocoa on 16/11/28.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "JZLocationConverter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //第一步从高德地图上获取坐标
    //http://lbs.amap.com/console/show/picker
    
    
    //第二步转换成Wgs坐标系统
    CLLocation *loca = [[CLLocation alloc]initWithLatitude:33.142376 longitude:103.912874];
    CLLocationCoordinate2D c2d = [JZLocationConverter gcj02ToWgs84:loca.coordinate];
    NSLog(@"转换后： %f  %f",c2d.latitude,c2d.longitude);

    //第三步在.gpx中添加地图转换后的坐标
    
    //运行
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
