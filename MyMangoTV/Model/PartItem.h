//
//  PartItem.h
//  MyMangoTV
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartItem : NSObject
@property (nonatomic, assign) int FstlvlId;
@property (nonatomic, assign) int TypeId;
@property (nonatomic, copy) NSString *Pname;
@property (nonatomic, copy) NSString *Pic;
@property (nonatomic, copy) NSString *PublishTime;

- (id)initWithDict:(NSDictionary *)dict;

+ (instancetype)partItem:(NSDictionary *)dict;
@end
