//
//  LongMsgFeed.m
//  JieXinIphone
//
//  Created by liqiang on 14-4-1.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LongMsgFeed.h"
#import "CDATAEncode.h"

@implementation LongMsgFeed
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
    self.serialID = nil;
    self.infoID = nil;
    self.time = nil;
    self.from = nil;
    self.to = nil;
    self.relateId = nil;
    self.msg = nil;
    [super dealloc];
}

@end
