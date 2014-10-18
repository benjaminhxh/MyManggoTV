//
//  collectCell.h
//  BabyTend
//
//  Created by zhxf on 14-4-28.
//  Copyright (c) 2014年 zhxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *roseNum;
@property (weak, nonatomic) IBOutlet UILabel *goldNum;
@property (weak, nonatomic) IBOutlet UIButton *cellType;

@end
