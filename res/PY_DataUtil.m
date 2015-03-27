//
//  StringData.m
//  mbank
//
//  Created by Ted on 13-7-23.
//
//

#import "PY_DataUtil.h"

const char charStr[] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};

@implementation PY_DataUtil


//字节转换为字符(NSUTF8StringEncoding)
+ (NSString *)dataToStr: (NSData *)data{
    NSString * result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return result;
}

//字符转换为字节(NSUTF8StringEncoding)
+ (NSData *)strToData: (NSString *)str{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

//字节转换为字符(16进制字节扩展)
+ (NSString *) oneTwo:(NSData *)data{
	
	int count = [data length];
	NSMutableString *result = [NSMutableString stringWithCapacity:count];
	
	Byte *bs = (Byte *)[data bytes];
	for(int i=0;i<count;i++){
		NSString *str = [[NSString alloc] initWithFormat:@"%02x",bs[i]];
		[result appendString: str];
	}
	return result;
}

//字符转换为字节(16进制字符串转换)
+ (NSData *)twoOne:(NSString *)str{
    
    //确保输入字符串不是nil;
    if (!str) return nil;
    
    //保证字符串长度为偶数(前补0)
    NSString *newStr = nil;
    if(([str length] % 2) == 0){
        newStr = [[NSString alloc] initWithString:str];
    }else {
        newStr = [[NSString alloc] initWithFormat:@"0%@",str];
    }
    
    //2位字符串转为1位字节
    int newLen = [newStr length]/2;
    NSMutableData *result = [NSMutableData dataWithCapacity:newLen];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i=0; i < newLen; i++) {
        byte_chars[0] = [newStr characterAtIndex:i*2];
        byte_chars[1] = [newStr characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);  //利用c函数转换（16进制）
        [result appendBytes:&whole_byte length:1];
    }
    
    return result;
}

@end
