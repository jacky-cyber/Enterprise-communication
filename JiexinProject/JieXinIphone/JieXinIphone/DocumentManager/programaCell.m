//
//  programaCell.m
//  JieXinIphone
//
//  Created by miaolizhuang on 14-4-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "programaCell.h"

@implementation programaCell
@synthesize programaNameLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
