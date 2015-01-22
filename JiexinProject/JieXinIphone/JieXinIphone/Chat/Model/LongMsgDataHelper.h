
//
//  LongMsgDataHelper.h
//  JieXinIphone
//
//  Created by liqiang on 14-4-1.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "LongMsgFeed.h"


@interface LongMsgDataHelper : NSObject
+(LongMsgDataHelper *)sharedService;
- (BOOL)insertALongMsgToDB:(LongMsgFeed *)feed;
- (BOOL)deleteLongMsgsWithInfoId:(NSString *)infoID;
//- (BOOL)updateMessageSendStatusWithSerialID:(NSString *)serialID withInfoID:(NSString *)infoID withSendStatus:(SendStatus)sendStatus;
- (BOOL)updateMessageSendStatusWithSerialID:(NSString *)serialID withSendorder:(NSString *)sendorder withSendStatus:(SendStatus)sendStatus withRelateID:(NSString *)relateID;
- (NSString *)getInfoIDFromSerialID:(NSString *)serialID;

- (BOOL)querySendResultWithInfoID:(NSString *)infoID withRelativeId:(NSInteger)relativeID;

- (NSMutableArray *)combineLongMsgsWithInfoId:(NSString *)InfoId WithRelateID:(NSString *)relateID;

- (NSString *)queryMinSerialIdWithInfoId:(NSString *)InfoId WithRelateID:(NSString *)relateID;


@end
