//
//  MyTableViewCell.h
//  MyTable
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

//@property (nonatomic, assign) int number;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *durlabel;
@property (nonatomic, strong) UIImageView *image;

@end
