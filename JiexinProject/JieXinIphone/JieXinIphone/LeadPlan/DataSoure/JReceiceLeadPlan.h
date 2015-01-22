//
//  JReceiceLeadPlan.h
//  JieXinIphone
//
//  Created by apple on 14-3-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JReceiceLeadPlan : NSObject{
@public
    int totalMonth[43];
    int totalHoliday[43];//假期列表
    int  totalNewMessage[43];//更新信息列表
}

@property(nonatomic,retain) NSMutableArray *data,*personData,*holidayArr,*newMessageArr,*pointArr,*currentMonthList;
@property(nonatomic,copy)NSString*resultcode;
@property(nonatomic,assign)int currentMonth,currentYear;


-(id)shareJReciceLeadPlan;
-(int)reciceLeadPlan:(NSString*)userId month:(NSString*)month;
-(int)reciceLeadPlan:(NSString*)userId day:(NSString*)day;
-(int)reciceLeadPlan:(NSString*)userId startDay:(NSString*)startMonth endDay:(NSString*)endMonth currentYear:(int) currentY currentMonth:(int)currentM array:(NSArray*)array;
-(void)addLeadPlan:(NSString*)userId time:(NSArray*)time theme:(NSString*)theme person:(NSArray*)person canlendarType:(NSString*)canlendarType location:(NSString*)location remarks:(NSString*)remarks;
-(void)modifyLeadPlan:(NSArray*)modifyUser canlendarId:(NSString*)canlendarId time:(NSArray*)time theme:(NSString*)theme person:(NSArray*)person canlendarType:(NSString*)canlendarType location:(NSString*)location remarks:(NSString*)remarks;
-(void)deleteLeadPlan:(NSString*)userId canlendarId:(NSString*)canlendarId;
//返回当天日程总数
-(int)getTotalMonth:(int)index;
//返回当天是否为节假日
-(int)gettotalHoliday:(int)index;
//返回当天是否为有信息更新
-(int)gettotalNewMessage:(int)index;
+(NSString*)getURL:(enum requestTypes)requestType;
//判断日期是否正确
+(NSArray*)isTrueDateForString:(NSString*)date;

@end
