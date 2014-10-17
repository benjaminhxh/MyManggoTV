//
//  PaginationButton.m
//  MyTable
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PaginationButton.h"

@interface PaginationButton ()
{
    NSMutableArray *btnArray;
}

@end
@implementation PaginationButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectedIndex = 0;
        self.numberOfButton = 2;
        
    }
    return self;
}

- (void)setNumberOfButton:(NSInteger)numberOfButton
{
    _numberOfButton = numberOfButton;
    
    CGFloat width = self.frame.size.width / numberOfButton;
    btnArray = [NSMutableArray array];
    for (int i = 0; i < numberOfButton; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i * width, 0, width,self.frame.size.height);
        btn.tag = i;
        [self addSubview:btn];
        [btnArray addObject:btn];
    }
}

- (void)setTitle:(NSArray *)titleitems
{
    for (int i=0; i<btnArray.count; i++)
    {
        [btnArray[i] setTitle:titleitems[i] forState:UIControlStateNormal];
    }
}

- (void)setImage:(NSArray *)imageitems
{
    for (int i=0; i<btnArray.count; i++)
    {
        [btnArray[i] setImage:imageitems[i] forState:UIControlStateNormal];
    }
}

- (void)setNormalcolor:(UIColor *)Normalcolor
{
    _Normalcolor = Normalcolor;
    for (UIButton *btn in btnArray)
    {
        [btn setTitleColor:_Normalcolor forState:UIControlStateNormal];
    }
}
- (void)setSelectedcolor:(UIColor *)Selectedcolor
{
    _Selectedcolor = Selectedcolor;
    for (UIButton *btn in btnArray)
    {
        [btn setTitleColor:_Selectedcolor forState:UIControlStateSelected];
    }
}
- (void)setNormalbgimage:(UIImage *)Normalbgimage
{
    _Normalbgimage = Normalbgimage;
    for (UIButton *btn in btnArray)
    {
        [btn setBackgroundImage:Normalbgimage forState:UIControlStateNormal];
    }
    
}
- (void)setSelectedbgimage:(UIImage *)Selectedbgimage
{
    _Selectedbgimage = Selectedbgimage;
    for (UIButton *btn in btnArray)
    {
        [btn setBackgroundImage:Selectedbgimage forState:UIControlStateSelected];
    }
}
    
- (void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    UIButton *btn = btnArray[selectedIndex];
    [self clicked:btn];
}

- (void)clicked:(UIButton *)sender
{
    for (UIButton *btn in btnArray)
    {
        btn.selected = NO;
    }
    sender.selected = YES;
   
    _selectedIndex =sender.tag;

    if (_didSelectedAtIndex) {
        _didSelectedAtIndex(self, sender.tag);
    }

}

@end

