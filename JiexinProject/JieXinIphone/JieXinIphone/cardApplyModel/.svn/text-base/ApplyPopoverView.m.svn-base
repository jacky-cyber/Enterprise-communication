//
//  ApplyPopoverView.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ApplyPopoverView.h"

@implementation ApplyPopoverView
@synthesize popoverDelegate;

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews
{
    //背景图片
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgView.image = [UIImage imageNamed:@"select.png"];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    [bgView release];
    
    //确认提交
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm.frame = CGRectMake(0, 10, 105, 35);
    [confirm setTitle:@"确认提交" forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont boldSystemFontOfSize:kCommonFont];
    [confirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside ];
    [self addSubview:confirm];
    
    //返回修改
    UIButton *modify = [UIButton buttonWithType:UIButtonTypeCustom];
    modify.frame = CGRectMake(0, 45, 105, 35);
    [modify setTitle:@"返回修改" forState:UIControlStateNormal];
    modify.titleLabel.font = [UIFont boldSystemFontOfSize:kCommonFont];
    [modify addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside ];
    [self addSubview:modify];
}

#pragma mark -
#pragma mark ButtonPressed Methods

- (void)confirm:(UIButton *)sender
{
    if (self.popoverDelegate && [self.popoverDelegate respondsToSelector:@selector(commitApply)]) {
        [self.popoverDelegate commitApply];
    }
}

- (void)modify:(UIButton *)sender
{
    if (self.popoverDelegate && [self.popoverDelegate respondsToSelector:@selector(modifyApply)]) {
        [self.popoverDelegate modifyApply];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
