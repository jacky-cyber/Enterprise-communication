//
//  ChatDetailImageBtn.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatDetailImageBtn.h"

@implementation ChatDetailImageBtn

- (void)dealloc
{
    self.imageStr = nil;
    self.feed = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
