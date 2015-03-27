//
//  RSAEncoder.m
//  Frame
//
//  Created by Ted on 13-7-29.
//  Copyright (c) 2013年 Ted. All rights reserved.
//

#import "RSAEncoder.h"
#import "PY_DataUtil.h"
#import "SecKeyWrapper.h"



@implementation RSAEncoder

@synthesize mod,exp;

#define kTempPublicKey @"perTempPayKey"
//#define PUBLIC_KEY @"8e0ce54f489b3bfe9a56bc1ffe2a1853b55dd8437feef2e8c217d9231432479aa44bda504d0227688e950218e0764988c62b75d10d7bb2ab084e66bdbb1f6d2ce0eef3a82ac9725f3184ebd7211c6d01b3ab6fa62dd34f268fd9c3f58865a82cde4a97c3e4bf8f1d132bb75c00df2c98ee829257ef0ad0f09ddd5d446f6a928d"

 
//#define EXPONENT @"010001"


-(id)initWithMod:(NSString *)_mod exp:(NSString *)_exp{
    self = [super init];
    if(self){
        self.mod = _mod;
        self.exp = _exp;
    }
    return self;
}



-(NSString *)enWithMod:(NSString *)_mod exp:(NSString *)_exp src:(NSString *)src
{
    if(![src length]){
        @throw [NSException exceptionWithName:@"NSInvalidArgumentException" reason:@"Data not set." userInfo:nil];
    }
    
    
    
    //根据mod和exp生成公钥对象
    NSData *modBits = [PY_DataUtil twoOne:_mod];
    NSData *expBits = [PY_DataUtil twoOne:_exp];
    
    /* the following is my (bmosher) hack to hand-encode the mod and exp
     * into full DER encoding format, using the following as a guide:
     * http://luca.ntop.org/Teaching/Appunti/asn1.html
     * this is due to the unfortunate fact that the underlying API will
     * only accept this format (not the separate values)
     */
    
    // 6 extra bytes for tags and lengths
    NSMutableData *fullKey = [[NSMutableData alloc] initWithLength:6+[modBits length]+[expBits length]];
    unsigned char *fullKeyBytes = [fullKey mutableBytes];
    unsigned int bytep = 0; // current byte pointer
    fullKeyBytes[bytep++] = 0x30;
    if(4+[modBits length]+[expBits length] >= 128){
        fullKeyBytes[bytep++] = 0x81;
        [fullKey increaseLengthBy:1];
    }
    unsigned int seqLenLoc = bytep;
    fullKeyBytes[bytep++] = 4+[modBits length]+[expBits length];
    fullKeyBytes[bytep++] = 0x02;
    if([modBits length] >= 128){
        fullKeyBytes[bytep++] = 0x81;
        [fullKey increaseLengthBy:1];
        fullKeyBytes[seqLenLoc]++;
    }
    fullKeyBytes[bytep++] = [modBits length];
    [modBits getBytes:&fullKeyBytes[bytep]];
    bytep += [modBits length];
    fullKeyBytes[bytep++] = 0x02;
    fullKeyBytes[bytep++] = [expBits length];
    [expBits getBytes:&fullKeyBytes[bytep++]];
    
    [[SecKeyWrapper sharedWrapper] removePeerPublicKey:kTempPublicKey];
    SecKeyRef publicKey = [[SecKeyWrapper sharedWrapper] addPeerPublicKey:kTempPublicKey keyBits:fullKey];
    
    
    //    [fullKey release];
    
    //加密机要求：原串转成字节数组之后，在字节数组之前加上原串的长度值，然后再进行加密
    int length = src.length;
    NSData *data_src = [PY_DataUtil strToData:src];
    Byte *byte_src = (Byte *)[data_src bytes];
    Byte byte[length+1];
    for (int i=0; i<length+1; i++) {
        if (i==0) {
            byte[0] = length;
        }else{
            byte[i] = byte_src[i-1];
        }
    }
    NSData *data_src_new = [[NSData alloc] initWithBytes:byte length:length+1];
    
    //加密
    NSData *encrypted = [[SecKeyWrapper sharedWrapper] wrapSymmetricKey:data_src_new keyRef:publicKey];
    NSString *result = [PY_DataUtil oneTwo:encrypted];
    
    // remove temporary key from keystore
    [[SecKeyWrapper sharedWrapper] removePeerPublicKey:kTempPublicKey];
    
    //    SKY_Log(@"---------%@ %d", result,result.length);
    
    return result;
}

- (NSString *) encryptWithString:(NSString *)content
{
    return [self enWithMod:self.mod exp:self.exp src:content];
}



@end
