//
//  AESEncrypt.h
//  TEAES
//
//  Created by jinkeke@techshino.com on 16/3/30.
//  Copyright © 2016年 www.techshino.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESEncrypt : NSObject

+ (int)aes_cbc:(unsigned char *)in inLen:(int )inLen mode:(int )jmode outData:(unsigned char *)outData outLen:(int *)outLen;

@end
