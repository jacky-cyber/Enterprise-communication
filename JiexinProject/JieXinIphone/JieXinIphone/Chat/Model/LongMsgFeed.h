//
//  LongMsgFeed.h
//  JieXinIphone
//
//  Created by liqiang on 14-4-1.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongMsgFeed : NSObject

@property (nonatomic, retain) NSString *serialID;
@property (nonatomic, retain) NSString *infoID;
@property (nonatomic, assign) NSInteger msgType;
@property (nonatomic, assign) NSInteger sumCount;
@property (nonatomic, assign) NSInteger sendOrder;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *to;
@property (nonatomic, retain) NSString *relateId;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, assign) SendStatus sendStatus;

@end
