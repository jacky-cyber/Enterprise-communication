//
//  TimeChangeWithTimeStamp.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "TimeChangeWithTimeStamp.h"

@implementation TimeChangeWithTimeStamp

+ (NSString *)timeStampToTime:(NSString *)time
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+ (NSString *)timeStampToFFFTime:(long long int)time
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    confromTimespStr = [NSString stringWithFormat:@"%@.%lld",confromTimespStr,time%1000];
    return confromTimespStr;
}


+ (NSString *)timeToTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
+ (NSString *)getNowTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return  [formatter stringFromDate:date];

}
+ (NSString *)getFFFSeriodId:(NSDate *)date
{
    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"SSS"];
    NSString *  locationString=[dateformatter stringFromDate:date];
    NSLog(@"locationString:%@",locationString);
    //    date = [dateformatter dateFromString:locationString];
    long long int time = ((long long int)[date timeIntervalSince1970])*1000+[locationString intValue] - [AppDelegate shareDelegate].serverAndLocalDiff;
    return [NSString stringWithFormat:@"%lld",time
            ];
}
+ (NSString *)getMMTimeFromFFFTime:(NSString *)dateStr
{
    //毫秒
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    //秒级的
    NSDateFormatter *SSFormatter = [[NSDateFormatter alloc] init];
    [SSFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = nil;
    if ([dateStr rangeOfString:@"."].location!=NSNotFound) {
        date =[formatter dateFromString:dateStr];
    }
    else
    {
        date =[SSFormatter dateFromString:dateStr];
    }
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *retureStr = [formatter1 stringFromDate:date];
    return retureStr;
}

+ (NSString *)getSSSTimeFromFFFTime:(NSString *)dateStr
{
    //毫秒
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date = [formatter dateFromString:dateStr];
    NSDateFormatter *SSFormatter = [[NSDateFormatter alloc] init];
    [SSFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *retureStr = [SSFormatter stringFromDate:date];
    return retureStr;
}


+(BOOL)isBeyondMMWithTime:(NSString *)time1 withOtherTime:(NSString *)time2
{
    //分钟
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date1 =[formatter dateFromString:time1];
    NSDate *date2 =[formatter dateFromString:time2];

    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitMinute)
											   fromDate:date1
												 toDate:date2
												options:0];
    if ([components minute]>1) {
        return YES;
    }
    return NO;
}

//计算两个时间点之间是否超过4小时
+(BOOL)isBeyond4HoursWithFromTime:(NSString *)time1 withNowDate:(NSDate *)nowDate
{
    //分钟
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 =[formatter dateFromString:time1];
    
    NSString *nowTime = [formatter stringFromDate:nowDate];
    NSDate *date2 =[formatter dateFromString:nowTime];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitHour)
											   fromDate:date1
												 toDate:date2
												options:0];
    if ([components hour]>4) {
        return YES;
    }
    return NO;
}


+ (long long int)resetServerTimeAndLocalTime:(NSString *)msgTime
{
 //   msgTime是毫秒级的 算服务器的 毫秒时间戳
    NSDateFormatter  *SSSformatter=[[[NSDateFormatter alloc] init] autorelease];
    [SSSformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *serverDate = [SSSformatter dateFromString:msgTime];
    

    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"SSS"];
    
    NSString *serverString = [dateformatter stringFromDate:serverDate];
    long long int serverTime = ((long long int)[serverDate timeIntervalSince1970])*1000+[serverString intValue];
    NSString *  locationString=[dateformatter stringFromDate:[NSDate date]];
    long long int time = ((long long int)[[NSDate date] timeIntervalSince1970])*1000+[locationString intValue];
    return  time - serverTime;

}




@end
