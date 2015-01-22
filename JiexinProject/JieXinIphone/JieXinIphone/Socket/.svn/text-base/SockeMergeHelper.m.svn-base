//
//  SockeMergeHelper.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-3-5.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SockeMergeHelper.h"

@implementation SockeMergeHelper

@synthesize packString;

static SockeMergeHelper *_sharedInst = nil;

+ (id) sharedService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[SockeMergeHelper alloc] init];
    });
    return _sharedInst;
}

- (void)dealloc
{
    self.packString = nil;
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        self.packString = [[[NSString alloc] init] autorelease];
	}
	return self;
}

- (PackType)inputString:(NSString *)str;
{
    if (str.length > 0)
    {
        self.packString = [packString stringByAppendingString:str];
        
        NSString *indicator = @"</JoyIM>";
        if ([packString hasSuffix:indicator])//数据完整
        {
            return PackType_receiveFinished;
        }
    }

    return PackType_receiving;
}

- (NSMutableArray *)analyzeString
{
    NSMutableArray *msgArr = [NSMutableArray array];
    NSString *indicator = @"</JoyIM>";
    NSArray *tmpArr = [self.packString componentsSeparatedByString:indicator];
    
    for (int i = 0; i < [tmpArr count]-1; ++i)
    {
        [msgArr addObject:[NSString stringWithFormat:@"%@%@",[tmpArr objectAtIndex:i],indicator]];
    }
    self.packString = @"";
   
    return msgArr;
}

@end
