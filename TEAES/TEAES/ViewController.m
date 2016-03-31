//
//  ViewController.m
//  TEAES
//
//  Created by jinkeke@techshino.com on 16/3/29.
//  Copyright © 2016年 www.techshino.com. All rights reserved.
//

#import "ViewController.h"
#import "AESEncrypt.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSString *)bytesToHexString:(NSData *)data
{
    NSMutableString *mstr = [[NSMutableString alloc]initWithCapacity:1];
    Byte *theBytes = (Byte *)data.bytes;
    int bLen = (int )data.length;
    for (int i = 0; i <bLen; i++) {
        if( ((int)theBytes[i] &0xff) < 0x10)
        {
            [mstr appendString:@"0"];
        }
        [mstr appendFormat:@"%x", (int)theBytes[i] & 0xff ];
    }
    
    
    return mstr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    Byte f5[5] = {8,9,10,11,12};
    
    NSLog(@"%@",[self bytesToHexString:[NSData dataWithBytes:f5 length:5]]);
    NSLog(@"%d %d",0x10,0xf);
    
    NSString *helloWD = @"hello";
    NSLog(@"加密前：%@",helloWD);
    NSData *ssData = [helloWD dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *sourIn = (unsigned char *)ssData.bytes;
    int inlen = (int )ssData.length;
    int jmod = 0;
    Byte outD[2*1024] = {0};
    int outL = 0;
    
    int ret = [AESEncrypt aes_cbc:sourIn inLen:inlen mode:jmod outData:outD outLen:&outL];
    
    NSLog(@"inlen=%d ret=%d outl=%d",inlen,ret,outL);
    NSData *encData = [NSData dataWithBytes:outD length:outL];
    NSLog(@"加密后：%@ %d",encData,encData.length);
    
    
    NSMutableString *theSTR = [[NSMutableString alloc]initWithCapacity:1];
    for (int i =0; i < outL; i++) {
        
        if(((int) outD[i]&0xff) < 0x10)
        {
            [theSTR appendString:@"0"];
        }
        [theSTR appendFormat:@"%x",(int )outD[i]&0xff];
    }
    
    NSLog(@"组合后：%@",theSTR);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
