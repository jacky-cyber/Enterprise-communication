//
//  JDateTime.h
//  TheStationAgent
//
//  Created by Jeffrey on 14-1-10.
//  Copyright (c) 2014年 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
static int tfontYear;
static int tcurrentYear;
static int tendYear;

static int fontMonthDay;
static int currentMonthDay;
static  int endMonthDay;

@interface JDateTime : NSObject
//所有年列表
+(NSMutableArray *)GetAllYearArray;

//所有月列表
+(NSMutableArray *)GetAllMonthArray;

//获取指定年份指定月份的星期排列表
+(NSMutableArray *)GetDayArrayByYear:(int) year
                     andMonth:(int) month;
+(int)GetTheWeekOfDayByYear:(int)year
                 andByMonth:(int)month;
+(int)GetNumberOfDayByYear:(int)year
                andByMonth:(int)month;
//以YYYY年MM月dd日格式输出年月日
+(NSString*)GetDateTime;

+(NSString*)GetDateTimedate;

+(NSString *)GetYear;

+(NSString *)GetMonth;

+(NSString *)GetDay;

+(NSString *)GetHour;

+(NSString *)GetMinute;

+(NSString *)GetSecond;

+(NSDictionary *)getFontYearAndMonth;

+(NSDictionary *)getEndYearAndMonth;
@end
