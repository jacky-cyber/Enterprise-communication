//
//  NotOnlineRemindView.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-6.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "NotOnlineRemindView.h"

@implementation NotOnlineRemindView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        // Initialization code
    }
    return self;
}

- (void)initSubViews
{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, kScreen_Width-6, CGRectGetHeight(self.frame))];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"对方不在线，您的消息将通过短信发送。";
    titleLabel.center = CGPointMake(kScreen_Width/2, CGRectGetHeight(self.frame)/2);
    [self addSubview:titleLabel];
    [titleLabel release];
    
    UIButton *removeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBt addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    removeBt.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:removeBt];
}

- (void)removeSelf
{
    [self removeFromSuperview];
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
