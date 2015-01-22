//
//  ChatConversationLabel.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-7.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatConversationLabel.h"

@interface ChatConversationLabel()

@property (nonatomic, retain) NSString *message;

@end

@implementation ChatConversationLabel

- (void)dealloc
{
    self.message = nil;
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

- (void)setLastMessage:(NSString *)lastMessage
{
    self.text = lastMessage;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
