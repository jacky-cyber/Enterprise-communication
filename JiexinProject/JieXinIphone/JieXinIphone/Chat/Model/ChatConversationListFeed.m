//
//  ChatConversationListFeed.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-21.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatConversationListFeed.h"
#import "CDATAEncode.h"

@implementation ChatConversationListFeed

- (void)setLast_message:(NSString *)last_message
{
    last_message = [CDATAEncode decodeCDATAStr:last_message];
    if (_last_message != last_message) {
        [_last_message release];
        _last_message = [last_message copy];
    }
}

- (void)dealloc
{
    self.relativeName = nil;
    self.last_message = nil;
    self.msgDate = nil;
    self.loginId = nil;
    self.messageLabel = nil;
    [super dealloc];
}

@end
