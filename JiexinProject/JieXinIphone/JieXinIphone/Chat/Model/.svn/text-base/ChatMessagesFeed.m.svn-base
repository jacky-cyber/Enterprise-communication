//
//  ChatMessagesFeed.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatMessagesFeed.h"
#import "CDATAEncode.h"
#import "OHAttributedLabel.h"

@implementation ChatMessagesFeed

- (void)setMessage:(NSString *)message
{
    message = [CDATAEncode decodeCDATAStr:message];
    if (_message != message) {
        [_message release];
        _message = [message copy];
    }
}

- (void)dealloc
{
    
    self.fromUserName = nil;
    self.message  = nil;
    self.date = nil;
    self.loginid = nil;
    self.sendDate = nil;
    self.attributedLabel = nil;
    [super dealloc];
}

@end
