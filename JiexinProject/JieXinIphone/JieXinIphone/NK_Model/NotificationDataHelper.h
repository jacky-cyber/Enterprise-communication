//
//  NotificationDataHelper.h
//  JieXinIphone
//
//  Created by gabriella on 14-3-14.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


#define kNotificationInfoTable      @"notificationInfoTable"
#define kMsgid                      @"msgid"
#define kMsgtime                    @"msgtime"
#define kMsgtitle                   @"msgtitle"
#define kMsgintro                   @"msgintro"
#define kMsg                        @"msg"
#define kMsgurl                     @"msgurl"

@interface NotificationDataHelper : NSObject

+ (NotificationDataHelper *) sharedService;

- (BOOL) appendNotification: (NSMutableDictionary *)wParam;
- (BOOL) notificationExist:(NSString *) msgid;
- (NSMutableArray *)getAllNotification;


@end
