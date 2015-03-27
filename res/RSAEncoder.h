//
//  RSAEncoder.h
//  Frame
//
//  Created by Ted on 13-7-29.
//  Copyright (c) 2013年 Ted. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncoder : NSObject

@property (nonatomic,strong) NSString * mod;
@property (nonatomic,strong) NSString * exp;

-(id)initWithMod:(NSString *)mod exp:(NSString *)exp;


- (NSString *) encryptWithString:(NSString *)content;

@end
