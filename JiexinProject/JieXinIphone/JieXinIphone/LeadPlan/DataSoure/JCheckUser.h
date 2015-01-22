//
//  JCheckUser.h
//  JieXinIphone
//
//  Created by apple on 14-3-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QueryUserCalendar;

@interface JCheckUser : NSObject<UIAlertViewDelegate>{
    NSString *userId;
    NSMutableArray *leader;
}

@property(nonatomic,copy) NSString*userId;
@property(nonatomic,retain) NSMutableArray*leader;
@property(nonatomic,copy) NSString*resultcode,*userType;
@property(nonatomic,assign) id<QueryUserCalendar> calendarDelegate;
+(JCheckUser*)shareCheckUser;
@end

@protocol  QueryUserCalendar <NSObject>

- (void)userCalendar:(JCheckUser *)dic;

@end