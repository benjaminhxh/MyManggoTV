//
//  hntvLivItem.h
//  MyMangoTV
//
//  Created by apple on 14-8-30.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hntvLivItem : NSObject

@property (nonatomic, assign) int ChannelId;
@property (nonatomic, copy) NSString *ChannelName;
@property (nonatomic, copy) NSString *Pic;
@property (nonatomic, copy) NSString *PlayUrl;
@property (nonatomic, strong) NSArray *CurrentProgrom;


- (id)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)hntvLivItem:(NSDictionary *)dict;

@end
