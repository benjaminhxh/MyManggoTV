//
//  hntvLivItem.m
//  MyMangoTV
//
//  Created by apple on 14-8-30.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "hntvLivItem.h"

@implementation hntvLivItem
- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)flashItem:(NSDictionary *)dict
{
    return [[hntvLivItem alloc] initWithDictionary:dict];
}
@end
