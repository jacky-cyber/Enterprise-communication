//
//  TimeChangeWithTimeStamp.h
//  JieXinIphone
//
//  Created by liqiang on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeChangeWithTimeStamp : NSObject

+ (NSString *)timeToTimeStamp:(NSDate *)date;
+ (NSString *)timeStampToFFFTime:(long long int)time;

+ (NSString *)timeStampToTime:(NSString *)time;
+ (NSString *)getNowTime;
//获取毫秒的时间戳
+ (NSString *)getFFFSeriodId:(NSDate *)date;
//将毫秒的时间 变成分钟的时间
+ (NSString *)getMMTimeFromFFFTime:(NSString *)dateStr;
//将毫秒的时间 变成秒的时间
+ (NSString *)getSSSTimeFromFFFTime:(NSString *)dateStr;


//计算两个时间点之间是否超过3分钟
+(BOOL)isBeyondMMWithTime:(NSString *)time1 withOtherTime:(NSString *)time2;
//计算两个时间点之间是否超过4小时
+(BOOL)isBeyond4HoursWithFromTime:(NSString *)time1 withNowDate:(NSDate *)nowDate;


//重置时间间隔
+ (long long int)resetServerTimeAndLocalTime:(NSString *)msgTime;


@end
