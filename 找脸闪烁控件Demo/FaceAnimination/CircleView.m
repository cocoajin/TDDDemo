//
//  CircleView.m
//  FaceAnimination
//
//  Created by jinkeke@techshino.com on 14-7-23.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import "CircleView.h"

#define kAminiTime 0.45f

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        
        //[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(doChangeTheColor) userInfo:nil repeats:YES];
        
        //闪现动画
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(doShowAndDiss) userInfo:nil repeats:YES];
        
    }
    return self;
}


- (void)doShowAndDiss
{
    if (self.alpha==1.0) {
        [UIView animateWithDuration:kAminiTime animations:^{
            self.alpha = 0;
        }];
    }
    
    else
    {
        [UIView animateWithDuration:kAminiTime animations:^{
            self.alpha = 1.0f;
        }];
    }
    
}

- (void)doChangeTheColor
{
    isChange = YES;
    
    //[self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect
{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float r = 0;
    float g = 0;
    float b = 0;
    
    if (isChange) {
        r=(float)(arc4random()%10)/10;
        g=0.5;
        b=0.5;
    }
    else
    {
        r=1.0;
        g=1.0;
        b=1.0;
    }
    CGFloat lengths[] = {5,5,5,5};
    
    
     CGRect aRect= CGRectMake(60, 1,self.bounds.size.width-60*2,self.bounds.size.height-4);
     CGContextSetRGBStrokeColor(context, r, g, b, 1.0);
     CGContextSetLineDash(context, 0, lengths, 4);
     CGContextSetLineWidth(context, 3.0);
     CGContextAddEllipseInRect(context, aRect); //椭圆
     CGContextDrawPath(context, kCGPathStroke);
    
    



    
}


@end
