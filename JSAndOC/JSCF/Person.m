//
//  Person.m
//  JSAndOC
//
//  Created by cocoa on 16/10/25.
//  Copyright © 2016年 dev.keke@gmail.com. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize site;

- (NSString *)fullyName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];

}

@end
