//
//  PaginationButton.h
//  MyTable
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaginationButton : UIView

//当前选中
@property (nonatomic, assign) int selectedIndex;
//想要按下按钮后，其他控件做出改变
@property (nonatomic, strong) void (^didSelectedAtIndex)(PaginationButton *,NSInteger);

@property (nonatomic, assign) NSInteger numberOfButton; //按钮个数 默认为2

//设置按钮文字颜色 默认黑色
@property (nonatomic, strong) UIColor *Normalcolor;
@property (nonatomic, strong) UIColor *Selectedcolor;
//设置按钮背景图
@property (nonatomic, strong) UIImage *Normalbgimage;
@property (nonatomic, strong) UIImage *Selectedbgimage;

- (void)setTitle:(NSArray *)titleitems; //设置按钮文字
- (void)setImage:(NSArray *)imageitems; //设置按钮图片
@end
