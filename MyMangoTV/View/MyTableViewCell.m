//
//  MyTableViewCell.m
//  MyTable
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell()

@end

@implementation MyTableViewCell

//4
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _image = [[UIImageView alloc] init];
        [self addSubview:_image];
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15];
        _label.numberOfLines = 2;
        [self addSubview:_label];
        
        _durlabel = [[UILabel alloc] init];
        _durlabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_durlabel];
        
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:12];
        [self addSubview:_name];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _image.frame = CGRectMake(5, 5, 100, self.frame.size.height-5);
    _label.frame = CGRectMake(110, 0, self.frame.size.width-120, 50);
    _durlabel.frame = CGRectMake(110, 50, self.frame.size.width-120, 10);
    _name.frame = CGRectMake(110, 60, self.frame.size.width-120, 20);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
