//
//  CYDatetime.h
//  CYLunarCalendar
//
//  Created by Cyrus on 14-5-23.
//  Copyright (c) 2014年 cyrusleung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYDatetime : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
- (NSDate *)convertDate;

@end

