//
//  LastChatMessageFeed.m
//  JieXinIphone
//
//  Created by liqiang on 14-4-16.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LastChatMessageFeed.h"
#import  "CDATAEncode.h"

@implementation LastChatMessageFeed

- (void)setMsg:(NSString *)msg
{
    msg = [CDATAEncode decodeCDATAStr:msg];
    if (_msg != msg) {
        [_msg release];
        _msg = [msg copy];
    }
}

- (void)dealloc
{
    self.msg = nil;
    [super dealloc];
}

@end
