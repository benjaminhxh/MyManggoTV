//
//  LiveTableViewCell.m
//  MyMangoTV
//
//  Created by apple on 14-8-30.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "LiveTableViewCell.h"

@implementation LiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _image = [[UIImageView alloc] init];
        [self addSubview:_image];
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.numberOfLines = 2;
        [self addSubview:_label];
        
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:15];
        [self addSubview:_name];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_button];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _image.frame = CGRectMake(5, 5, 100, self.frame.size.height-5);
    _name.frame = CGRectMake(110, 0, self.frame.size.width-120, 50);
    _label.frame = CGRectMake(110, 60, self.frame.size.width-120, 20);
    _button.frame = CGRectMake(self.frame.size.width-70, 30, 60, 30);
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
