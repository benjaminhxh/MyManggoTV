//
//  CategoryView.m
//  MyMangoTV
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width-8, self.bounds.size.height)];
        view.backgroundColor = [UIColor orangeColor];
        [self addSubview:view];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _imageView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, frame.size.width, 40)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        _vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 41, 5, 39, 36)];
        [self addSubview:_vipImageView];
    }
    return self;
}

@end
