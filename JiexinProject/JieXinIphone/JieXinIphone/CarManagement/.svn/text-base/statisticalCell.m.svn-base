//
//  statisticalCell.m
//  JieXinIphone
//
//  Created by apple on 14-4-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "statisticalCell.h"

@implementation statisticalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews]; //初始化子视图
    }
    return self;
}

- (void)initSubViews {
    _comLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //_comLabel.text = @"全通";
    [_comLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_comLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //[_countLabel setText:@"1"];
    [_countLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview: _countLabel];
    
    
    //分割线
    _line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    [_line setFrame:CGRectZero];
    [self.contentView addSubview:_line];
    
//    _line = [[UILabel alloc] initWithFrame:CGRectZero];
//    [_line setBackgroundColor:[UIColor grayColor]];
//    [self.contentView addSubview:_line];
}



//设置子视图的坐标
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [_comLabel setFrame:CGRectMake(10, 10, 200, 40)];
    [_countLabel setFrame:CGRectMake(_comLabel.right+50, 10, 30, 30)];
    [_line setFrame:CGRectMake(230, 0, 1, 50)];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
