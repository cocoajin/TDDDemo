//
//  DrawFont.m
//  GraphicAndAnimation
//
//  Created by jinkeke@techshino.com on 14-8-14.
//  Copyright (c) 2014年 www.techshino.com. All rights reserved.
//

#import "DrawFont.h"

@implementation DrawFont

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    
    
    //画文本
    
    UIFont *helveBlod = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
    NSString *myString = @"Some String";
    [myString drawAtPoint:CGPointMake(40, 30) withFont:helveBlod];
    
    
    //画带颜色的文本
    
    UIColor *myColor = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
    [myColor set];
    NSString *colorString = @"Color String";
    [colorString drawAtPoint:CGPointMake(40, 70) withFont:helveBlod];
    
    //在某矩形内绘图
    UIColor *orageColor = [UIColor orangeColor];
    [orageColor set];
    NSString *drectString = @"Rect String";
    [drectString drawInRect:CGRectMake(40, 110, 200, 25) withFont:helveBlod];
    
    
    //绘制照片
    //同样的，拿到 UIImage 图片，然后，调用 drawAtPoint: drawInRect 在指定地方绘制图片；
    UIImage *drawImage = [UIImage imageNamed:@"drawIMG.png"];
    [drawImage drawAtPoint:CGPointMake(40, 150)];
    
    
    //绘制线条
    [[UIColor brownColor] set]; //设置颜色
    CGContextRef currentContext = UIGraphicsGetCurrentContext();    //获取当前上下文
    CGContextSetLineWidth(currentContext, 3.0f);    //设置线宽
    CGContextMoveToPoint(currentContext, 170, 160); //设置画笔当前点
    CGContextAddLineToPoint(currentContext, 280, 160);  //从画笔点到当前点画直线
    CGContextMoveToPoint(currentContext, 280, 160);     //移动画笔到下一个点
    CGContextAddLineToPoint(currentContext, 280, 250);  //绘制下一条线
    CGContextMoveToPoint(currentContext, 280, 250);     //移动画笔
    CGContextAddLineToPoint(currentContext, 170, 160);  //再绘制一条线
    
    //可连续调用 CGContextAddLineToPoint() 方法，直接移动画笔画到下一点；
    CGContextAddLineToPoint(currentContext, 170, 250);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound); //设置两条线的连接方式 圆角，尖角，平角
    CGContextAddLineToPoint(currentContext, 280, 160);

    //绘制路径到上下文图形上
    CGContextStrokePath(currentContext);
    
    
    //使用 路径直接绘制图形 画一个 X
    CGMutablePathRef path  = CGPathCreateMutable(); //创建可变路径；
    CGPathMoveToPoint(path, NULL, 40, 270);
    CGPathAddLineToPoint(path, NULL, 140, 370);
    CGPathMoveToPoint(path, NULL, 40, 370);
    CGPathAddLineToPoint(path, NULL, 140, 270);
    
    //获取上下文，并在上下文中绘制路径
    CGContextRef currentConte = UIGraphicsGetCurrentContext();
    CGContextAddPath(currentConte, path);
    [[UIColor blueColor] set];
    CGContextDrawPath(currentConte, kCGPathStroke);
    CGPathRelease(path);
    
    
    
    
    //绘制矩形
    CGMutablePathRef rectPath = CGPathCreateMutable();
    CGRect rectDP = CGRectMake(170, 270, 100, 100);
    CGPathAddRect(rectPath, NULL, rectDP);
    
    CGContextRef reCurrentCon   = UIGraphicsGetCurrentContext();
    CGContextAddPath(reCurrentCon, rectPath);
    [[UIColor redColor] setFill];
    [[UIColor greenColor] setStroke];
    CGContextSetLineWidth(reCurrentCon, 2.0f);
    CGContextDrawPath(reCurrentCon, kCGPathFillStroke);
    
    
    
    
    //绘制阴影
    CGContextRef shawCurrentCon = UIGraphicsGetCurrentContext();
    //阴影设置
    CGContextSetShadowWithColor(shawCurrentCon, CGSizeMake(10.0f, 10.0f), 20.0f,[UIColor grayColor].CGColor);
    CGMutablePathRef shawPath = CGPathCreateMutable();
    CGRect shawRect1 = CGRectMake(40, 380, 100, 100);
    CGPathAddRect(shawPath, NULL, shawRect1);
    CGContextAddPath(shawCurrentCon, shawPath);
    [[UIColor blueColor] setFill];
    CGContextDrawPath(shawCurrentCon, kCGPathEOFill);
    CGPathRelease(shawPath);
    
    
    
    
    
    
    
    //绘制渐变
    CGContextRef jbCurrentCon = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *startColor = [UIColor blueColor];
    CGFloat *startColorComponets = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    
    UIColor *endColor = [UIColor greenColor];
    CGFloat *endColorComponets = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    CGFloat colorComponents[8] = {startColorComponets[0],startColorComponets[1],startColorComponets[2],startColorComponets[3], endColorComponets[0],endColorComponets[1],endColorComponets[2],endColorComponets[3]};
    CGFloat colorIndices[2] = {0.0f,1.0f};
    
    CGGradientRef gradients = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&colorComponents,(const CGFloat *)&colorIndices, 2);
    CGColorSpaceRelease(colorSpace);
    
    CGRect jbRect = CGRectMake(170, 380, 100, 100);
    CGPoint startPoint,endPoint;
    startPoint = CGPointMake(jbRect.origin.x, 430);
    endPoint = CGPointMake(270, startPoint.y);
    CGContextDrawLinearGradient(jbCurrentCon, gradients, startPoint, endPoint, 0);
    CGGradientRelease(gradients);
    
    
    //CTM 旋转，缩放，平移，见文档
    
    
    
}




@end
