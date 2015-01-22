//
//  PicWallCell.m
//  JieXinIphone
//
//  Created by macOne on 14-3-7.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "PicWallCell.h"

@implementation PicWallCell

@synthesize image_01,image_02,image_03;

#define WID 90
#define BETWEEN 10

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        image_01 = [UIButton buttonWithType:UIButtonTypeCustom];
        [image_01 setFrame:CGRectMake(15, 10, WID, WID)];
        [self addSubview:image_01];
        
        image_02 = [UIButton buttonWithType:UIButtonTypeCustom];
        [image_02 setFrame:CGRectMake(image_01.frame.origin.x+image_01.frame.size.width+BETWEEN, image_01.frame.origin.y, WID, WID)];
        [self addSubview:image_02];
        
        image_03 = [UIButton buttonWithType:UIButtonTypeCustom];
        [image_03 setFrame:CGRectMake(image_02.frame.origin.x+image_02.frame.size.width+BETWEEN, image_01.frame.origin.y, WID, WID)];
        [self addSubview:image_03];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
