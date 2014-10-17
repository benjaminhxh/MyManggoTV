//
//  MyTabBarItem.m
//  CustomTabBarApp2
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "MyTabBarItem.h"

@implementation MyTabBarItem
- (id)initWithImage:(UIImage *)image selectedimage:(UIImage *)selectedimage title:(NSString *)title
{
    if (self = [super init]) {
        self.selectedImage = selectedimage;
        self.image = image;
        self.title = title;
    }
    
    return self;
}
@end
