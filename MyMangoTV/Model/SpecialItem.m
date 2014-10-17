//
//  SpecialItem.m
//  MyMangoTV
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "SpecialItem.h"

@implementation SpecialItem
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)specialItem:(NSDictionary *)dict
{
    return [[SpecialItem alloc] initWithDict:dict];
}
@end
