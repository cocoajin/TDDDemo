//
//  CYDatetime.m
//  CYLunarCalendar
//
//  Created by Cyrus on 14-5-23.
//  Copyright (c) 2014年 cyrusleung. All rights reserved.
//

#import "CYDatetime.h"

@implementation CYDatetime

- (NSDate *)convertDate
{
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
@end


