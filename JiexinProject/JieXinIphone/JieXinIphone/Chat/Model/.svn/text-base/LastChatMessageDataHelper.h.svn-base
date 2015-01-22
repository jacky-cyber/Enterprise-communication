//
//  LastChatMessageDataHelper.h
//  JieXinIphone
//
//  Created by liqiang on 14-4-16.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LastChatMessageFeed.h"


@interface LastChatMessageDataHelper : NSObject
+(LastChatMessageDataHelper *)sharedService;
- (BOOL)insertAChatLastMsgToDB:(LastChatMessageFeed *)feed;
- (NSString *)queryChatLastMsgFromDB:(NSInteger)relativeId;

@end
