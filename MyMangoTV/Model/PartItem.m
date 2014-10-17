//
//  PartItem.m
//  MyMangoTV
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "PartItem.h"

@implementation PartItem
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)partItem:(NSDictionary *)dict
{
    return [[PartItem alloc] initWithDict:dict];
}

@end
