//
//  ViewController.m
//  GraphicAndAnimation
//
//  Created by jinkeke@techshino.com on 14-8-14.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"
#import "DrawFont.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    DrawFont *dFontView = [[DrawFont alloc] initWithFrame:self.view.bounds];
    dFontView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dFontView];
    
    
    //[self enumerateFonts];
    
    [self componentColor];
    
    
}


//颜色分解
- (void)componentColor
{
    UIColor *steelBlueColor = [UIColor colorWithRed:0.3f green:0.4f blue:0.6f alpha:1.0f];
    CGColorRef colorRef = steelBlueColor.CGColor;
    const CGFloat *compoents = CGColorGetComponents(colorRef);
    NSUInteger componentsCount = CGColorGetNumberOfComponents(colorRef);
    
    for (int count = 0; count <componentsCount; count++) {
        
        NSLog(@"Component %lu = %.02f",(unsigned long)count+1,compoents[count]);
        
    }
    
    
}


//枚举字体
- (void)enumerateFonts
{
    //字体族科(Families)
    for (NSString *familyName in [UIFont familyNames]) {
        
        NSLog(@"Font Family = %@",familyName);
        
        
        //每一个字体族在字样（Face）
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            
            NSLog(@"\tFont name = %@",fontName);
            
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
