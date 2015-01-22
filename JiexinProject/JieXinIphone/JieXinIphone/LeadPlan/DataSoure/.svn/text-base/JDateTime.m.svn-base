//
//  JDateTime.m
//  TheStationAgent
//
//  Created by Jeffrey on 14-1-10.
//  Copyright (c) 2014年 Jeffrey. All rights reserved.
//

#import "JDateTime.h"

@implementation JDateTime

//所有年列表
+(NSMutableArray *)GetAllYearArray{
    NSMutableArray * yearArray = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 1901; i<2050; i++) {
        NSString * days = [[NSString alloc]initWithFormat:@"%d",i];
        [yearArray addObject:days];
    }
    return yearArray;
}
//所有月列表
+(NSMutableArray *)GetAllMonthArray{
    return [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
}
//以YYYY年MM月dd日格式输出年月日
+(NSString*)GetDateTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}
//以YYYY年MM月dd日格式输出年月日
+(NSString*)GetDateTimedate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM月"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}
//获取指定年份指定月份的星期排列表
+(NSMutableArray *)GetDayArrayByYear:(int) year andMonth:(int) month{
    NSMutableArray * dayArray = [[[NSMutableArray alloc]init]autorelease];
    fontMonthDay=-1;
    endMonthDay=-1;
    currentMonthDay=month;
    for (int i = 1; i<=42; i++) {
        
        if (i <=[self GetTheWeekOfDayByYear:year andByMonth:month]-1) {
     
            int upyears,upmonths;
            month==1?(upyears=year-1,upmonths=13):(upmonths=month,upyears=year);
            int t=  [self GetNumberOfDayByYear:upyears andByMonth:upmonths-1]-[self GetTheWeekOfDayByYear:upyears andByMonth:upmonths]+i+1;
            if(upmonths==13) t=t+1;
            [dayArray addObject:[NSString stringWithFormat:@"%d",t]];
  
            fontMonthDay=upmonths-1;
            tfontYear=upyears;
            
        }else if ((i>[self GetTheWeekOfDayByYear:year andByMonth:month]-1)&&(i<[self GetTheWeekOfDayByYear:year andByMonth:month]+[self GetNumberOfDayByYear:year andByMonth:month])){

            NSString * days;
            if((i - [self GetTheWeekOfDayByYear:year andByMonth:month] +1)< 10)
                days = [NSString stringWithFormat:@"  %d",i-[self GetTheWeekOfDayByYear:year andByMonth:month]+1];
            else days = [NSString stringWithFormat:@"%d",i-[self GetTheWeekOfDayByYear:year andByMonth:month]+1];
            [dayArray addObject:days];
            currentMonthDay=month;
            tcurrentYear=year;
          
        }else {
    
            NSString * days;
            int upyears,upmonths;
            month==12?(upyears=year+1,upmonths=1):(upmonths=month+1,upyears=year);
            if((i - [self GetTheWeekOfDayByYear:year andByMonth:month] +1)< 10)
                days = [NSString stringWithFormat:@"  %d",(i-[self GetTheWeekOfDayByYear:year andByMonth:month]+1)%([self GetNumberOfDayByYear:year andByMonth:month])];
            else days = [NSString stringWithFormat:@"%d",(i-[self GetTheWeekOfDayByYear:year andByMonth:month]+1)%([self GetNumberOfDayByYear:year andByMonth:month])];
            [dayArray addObject:days];
            endMonthDay=upmonths;
            tendYear=upyears;
        }
    }
    return dayArray;
}
//计算year年month月第一天是星期几，周日则为0
+(int)GetTheWeekOfDayByYear:(int)year
                 andByMonth:(int)month{
    int numWeek = ((year-1)+ (year-1)/4-(year-1)/100+(year-1)/400+1)%7;//numWeek为years年的第一天是星期几
 
    int ar[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    int numdays = (((year/4==0&&year/100!=0)||(year/400==0))&&(month>2))?(ar[month-1]+1):(ar[month-1]);//numdays为month月years年的第一天是这一年的第几天

    int dayweek = (numdays%7 + numWeek)%7;//month月第一天是星期几，周日则为0
    if(dayweek==0)dayweek=7;
    return dayweek;
}
//判断year年month月有多少天
+(int)GetNumberOfDayByYear:(int)year
                andByMonth:(int)month{
    int dayWithMonth[]={31,28,31,30,31,30,31,31,30,31,30,31};
    if (((year%4==0&&year%100!=0)||(year%400==0))&&month==2){
        return 29;
    }
    return dayWithMonth[month-1];
}

+(NSString *)GetYear{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetMonth{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetDay{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetHour{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetMinute{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSString *)GetSecond{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"ss"];
    NSString* date = [[[NSString alloc]initWithString:[formatter stringFromDate:[NSDate date]]]autorelease];
    [formatter release];
    return date;
}

+(NSDictionary *)getFontYearAndMonth{
    
    return  @{@"YEAR":[NSString stringWithFormat:@"%d",tfontYear],@"MONTH":[NSString stringWithFormat:@"%02d",fontMonthDay]};
}

+(NSDictionary *)getEndYearAndMonth{
    return  @{@"YEAR":[NSString stringWithFormat:@"%d",tendYear],@"MONTH":[NSString stringWithFormat:@"%02d",endMonthDay]};
}

@end
