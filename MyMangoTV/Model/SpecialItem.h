//
//  SpecialItem.h
//  MyMangoTV
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialItem : NSObject
@property (nonatomic, assign) int FstlvlId;
@property (nonatomic, assign) int SpecialId;
@property (nonatomic, copy) NSString *Sname;
@property (nonatomic, copy) NSString *Pic;

- (id)initWithDict:(NSDictionary *)dict;

+ (instancetype)specialItem:(NSDictionary *)dict;
@end
