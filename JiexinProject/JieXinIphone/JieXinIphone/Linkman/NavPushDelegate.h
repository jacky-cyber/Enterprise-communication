//
//  NavPushDelegate.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-22.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavPushDelegate <NSObject>

@optional


- (void)pushToGroupChatView:(NSDictionary *)dic;
- (void)pushToSendMess:(NSArray *)array;

- (void)pushToSendMess:(NSArray *)array withGroupId:(NSString *)groupid;

@end
