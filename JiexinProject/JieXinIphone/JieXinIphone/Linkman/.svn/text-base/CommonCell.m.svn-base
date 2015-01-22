//
//  CommonCell.m
//  demo
//
//  Created by 高大鹏 on 14-2-19.
//  Copyright (c) 2014年 BeaconStudio. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell
@synthesize logo;
@synthesize title,subTitle;
@synthesize delegate;
@synthesize selectBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(260, 15, 30.0, 30.0)];
        [button setImage:[UIImage imageNamed:@"fuxuan_1.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"fuxuan_2.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        selectBtn = button;
        self.userInteractionEnabled = YES;
        [self addSubview:button];
    }
    return self;
}

- (void)setStyle:(CellStyle)style
{
    switch (style)
    {
        case GroupStyle:
        {
            logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
            [self addSubview:logo];
            
            title = [[UILabel alloc] initWithFrame:CGRectMake(70, 7, 280, 25)];
            title.font = [UIFont systemFontOfSize:16];
            [self addSubview:title];
            
            subTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 33, 280, 20)];
            subTitle.textColor = [UIColor grayColor];
            subTitle.font = [UIFont systemFontOfSize:14];
            [self addSubview:subTitle];
            
            [self bringSubviewToFront:selectBtn];
        }break;
        case MemberStyle:
        {
            logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
            [self addSubview:logo];
            
            title = [[UILabel alloc] initWithFrame:CGRectMake(70, 7, 280, 25)];
            title.font = [UIFont systemFontOfSize:16];
            [self addSubview:title];
            
            subTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 33, 280, 20)];
            subTitle.textColor = [UIColor grayColor];
            subTitle.font = [UIFont systemFontOfSize:14];
            [self addSubview:subTitle];
        }break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)selectCell:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCellWith:withSelected:)])
    {        
        [self.delegate selectCellWith:self withSelected:sender.selected];
    }
}

@end
