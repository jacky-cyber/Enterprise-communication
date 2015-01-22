//
//  JReceiceLeadPlan.m
//  JieXinIphone
//
//  Created by apple on 14-3-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JReceiceLeadPlan.h"
#import "HttpServiceHelper.h"
#import "JReceiceLeadPlan+JGetUrlForLeadPlan.h"
#import "JReceiceLeadPlan+JReceiceLeadPlanForPostRequest.h"
#import "JDateTime.h"
#import "documentDataHelp.h"
static JReceiceLeadPlan *receiceLP=nil;
@implementation JReceiceLeadPlan


@synthesize data,resultcode,personData,holidayArr,currentMonthList,pointArr,currentMonth,currentYear;
-(id)shareJReciceLeadPlan{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        receiceLP=[[JReceiceLeadPlan alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNotifactionData) name:@"NEWNOTIFACTIONMESSAGE" object:nil];
    });
    return receiceLP;
}
//返回当天日程总数
-(int)getTotalMonth:(int)index{
    return totalMonth[index];
}
//返回当天是否为节假日
-(int)gettotalHoliday:(int)index{
    return totalHoliday[index];
}
//返回当天是否为有信息更新
-(int)gettotalNewMessage:(int)index{
    return totalNewMessage[index];
}
-(int)reciceLeadPlan:(NSString*)userId month:(NSString*)month{

    
    NSDictionary *dic=[JReceiceLeadPlan checkLeadPlanRequestUrlType:QueryUserMonCalendarList info:@{@"userId":userId,@"month":month}];
  
    self.data=[dic objectForKey:@"data"];
    self.resultcode=[dic objectForKey:@"resultcode"];
    for(int i=0;i<43;i++) totalMonth[i]=0;
    int i=0;
    for(NSDictionary *arr in self.data){
        if([[arr objectForKey:@"calendarIntroducte"]count] ){
            int dayNum=[[[[self.data objectAtIndex:i++] objectForKey:@"day"] substringFromIndex:8] intValue]+[JDateTime GetTheWeekOfDayByYear:[[month substringToIndex:4] intValue] andByMonth:[[month substringFromIndex:4]intValue]]-1;
            totalMonth[dayNum]+=[[arr objectForKey:@"calendarIntroducte"]count];
        }
    }
    return 0;
}
-(int)reciceLeadPlan:(NSString*)userId startDay:(NSString*)startMonth endDay:(NSString*)endMonth currentYear:(int) currentY currentMonth:(int)currentM array:(NSArray*)array{
    self.currentMonthList =nil;
    self.currentMonthList=[NSMutableArray arrayWithArray:array];//保存当前列表
    self.currentYear=currentY;
    self.currentMonth=currentM;
    NSString *day1=[array[0] intValue]>=10?array[0]:[NSString stringWithFormat:@"0%@",array[0]];
    NSString *day41=[array[41] intValue]>=10?array[41]:[NSString stringWithFormat:@"0%@",array[41]];
    NSDictionary *dic=[JReceiceLeadPlan checkLeadPlanRequestUrlType:QueryUserSpecifyDayCalendar info:@{@"userId":userId,@"startDay":[NSString stringWithFormat:@"%@%@",startMonth,day1],@"endDay":[NSString stringWithFormat:@"%@%@",endMonth,day41]}];
    self.data=[dic objectForKey:@"data"];
    self.resultcode=[dic objectForKey:@"resultcode"];
    self.holidayArr=(NSMutableArray*)[[dic objectForKey:@"holiday"] componentsSeparatedByString:@","];
    if([self.holidayArr isEqualToArray:@[@""]])
        self.holidayArr=nil;
    for(int i=0;i<43;i++){
        totalMonth[i]=0;
        totalHoliday[i]=0;
    }

    NSString *fontYearToDayStr=nil;
    NSString *endYearToDayStr=nil;
    NSString *dayStr=nil;

    for(NSDictionary *arr in self.data){
        NSString *string=[arr  objectForKey:@"day"];
        if(string.length<8) continue;
        int dayNum=[[[arr  objectForKey:@"day"] substringFromIndex:8] intValue];
 
        dayStr=dayNum>=10?[NSString stringWithFormat:@"%d",dayNum]:[NSString stringWithFormat:@"0%d",dayNum];
        fontYearToDayStr=[NSString stringWithFormat:@"%@-%@",[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"],dayStr];
       
        endYearToDayStr=[NSString stringWithFormat:@"%@-%@",[[JDateTime getEndYearAndMonth]objectForKey:@"MONTH"],dayStr];
        
        if([[arr objectForKey:@"day"] hasSuffix:fontYearToDayStr]){
            dayNum-=[array[0] intValue];
        }else if([[arr objectForKey:@"day"] hasSuffix:endYearToDayStr]){
            dayNum+=[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]-[array[0] intValue]+[JDateTime GetNumberOfDayByYear:currentY andByMonth:currentM];
        }else{
            dayNum+=[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]-[array[0] intValue];
        }
        totalMonth[dayNum]+=[[arr objectForKey:@"calendarIntroducte"]count];
        
    }
    ///获取假日的日期
    for(NSString *string in self.holidayArr){//
        if(string.length<8) continue;
        int dayNum=[[string substringFromIndex:8] intValue];
        dayStr=dayNum>=10?[NSString stringWithFormat:@"%d",dayNum]:[NSString stringWithFormat:@"0%d",dayNum];
        fontYearToDayStr=[NSString stringWithFormat:@"%@-%@",[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"],dayStr];//前个月
        endYearToDayStr=[NSString stringWithFormat:@"%@-%@",[[JDateTime getEndYearAndMonth]objectForKey:@"MONTH"],dayStr];//后个月
        
        if([string hasSuffix:fontYearToDayStr]){
            //上个月的记录
            dayNum-=[array[0] intValue];
        }else if([string hasSuffix:endYearToDayStr]){
            //下个月的记录
            dayNum+=[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]-[array[0] intValue]+[JDateTime GetNumberOfDayByYear:currentY andByMonth:currentM];
        }else{//本月的记录
            dayNum+=[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]-[array[0] intValue];
        }
        totalHoliday[dayNum]=1;
    }
    //加载是否有新信息
    [self loadNotifactionData];

    return 0;
}
-(int)reciceLeadPlan:(NSString*)userId day:(NSString*)day{
    
    NSDictionary *dic=[JReceiceLeadPlan checkLeadPlanRequestUrlType:QueryUserDayCalendarList info:@{@"userId":userId,@"day":day} ];
    self.personData=nil;
    personData=[[NSMutableArray alloc]initWithArray:[dic objectForKey:@"data"]];
    self.resultcode=[dic objectForKey:@"resultcode"];
    return 0;
}
//NSString
-(void)addLeadPlan:(NSString*)userId time:(NSArray*)time theme:(NSString*)theme person:(NSArray*)person canlendarType:(NSString*)canlendarType location:(NSString*)location remarks:(NSString*)remarks{

    NSDictionary *dic=[JReceiceLeadPlan postLeadPlanRequestUrlType:AddDayCanlendar key:@[@"cmd",@"addUserId",@"timeType",@"startTime",@"endTime",@"theme",@"personType",@"userId",@"userName",@"canlendarType",@"location",@"remarks"] info:@[kAddDayCanlendar,userId,time[0],time[1],time[2],theme,person[0],person[1],person[2],canlendarType,location,remarks]];
    self.resultcode=[dic objectForKey:@"resultcode"];
}
-(void)modifyLeadPlan:(NSArray*)modifyUser canlendarId:(NSString*)canlendarId time:(NSArray*)time theme:(NSString*)theme person:(NSArray*)person canlendarType:(NSString*)canlendarType location:(NSString*)location remarks:(NSString*)remarks{

    NSDictionary *dic=[JReceiceLeadPlan postLeadPlanRequestUrlType:ModifyDayCanlendar key:@[@"cmd",@"modifyUserId",@"modifyUserName",@"canlendarId",@"timeType",@"startTime",@"endTime",@"theme",@"personType",@"userId",@"userName",@"canlendarType",@"location",@"remarks"] info:@[kModifyDayCanlendar,modifyUser[0],modifyUser[1],canlendarId,time[0],time[1],time[2],theme,person[0],person[1],person[2],canlendarType,location,remarks]];
    self.resultcode=[dic objectForKey:@"resultcode"];
}
-(void)deleteLeadPlan:(NSString*)userId canlendarId:(NSString*)canlendarId{
    //NSDictionary *dic=[JReceiceLeadPlan checkLeadPlanRequestUrlType:DelateDayCanlendar info:@{@"userId":userId,@"canlendarId":canlendarId}];
    NSDictionary *dic=[JReceiceLeadPlan  postLeadPlanRequestUrlType:DelateDayCanlendar key:@[@"cmd",@"userId",@"canlendarId"] info:@[kDelateDayCanlendar,userId,canlendarId]];
    self.resultcode=[dic objectForKey:@"resultcode"];
}

-(void)loadNotifactionData{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NEWNOTIFACTIONMESSAGE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNotifactionData) name:@"NEWNOTIFACTIONMESSAGE" object:nil];
    NSArray *bigArr=[[documentDataHelp sharedService] readDocModelItem:@"NewsTable"];
    self.pointArr =nil;
    self.pointArr=[[NSMutableArray alloc]init];
    for(int i=0;i<[bigArr count];i++){
        if([[bigArr[i] objectForKey:@"sysid"]isEqualToString:@"06"]){
            [self.pointArr addObject:[bigArr[i] objectForKey:@"categoryid"]];
        }
    }
    if([self.pointArr isEqualToArray:@[@""]])self.pointArr=nil;
    NSString *fontYearToDayStr=nil;
    NSString *endYearToDayStr=nil;
    NSString *currentYearTodayStr=nil;
    NSArray *yearMonthDay=nil;
    for(int i=0;i<43;i++)
        totalNewMessage[i]=0;
    ///获取新更新日程
    for(int i=0;i<[self.pointArr count];i++){
        yearMonthDay=[JReceiceLeadPlan isTrueDateForString:self.pointArr[i]];
        if(!yearMonthDay){
            [[documentDataHelp sharedService] deleteTestList:@"06" withCategoryid:self.pointArr[i]];
            continue;
        }
        int dayNum=[yearMonthDay[2] intValue];
        fontYearToDayStr=[NSString stringWithFormat:@"%@-%@",[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"],yearMonthDay[2]];//前个月
        currentYearTodayStr=[NSString stringWithFormat:@"%d-%@",self.currentMonth,yearMonthDay[2]];//本个月
        endYearToDayStr=[NSString stringWithFormat:@"%@-%@",[[JDateTime getEndYearAndMonth]objectForKey:@"MONTH"],yearMonthDay[2]];//后个月
        
        if([self.pointArr[i] hasSuffix:fontYearToDayStr]&&dayNum>=[self.currentMonthList[0] intValue]){
            //上个月的记录
            dayNum-=[self.currentMonthList[0] intValue];
            totalNewMessage[dayNum]=1;
        }else if([self.pointArr[i] hasSuffix:endYearToDayStr]&&dayNum<=[self.currentMonthList[41]intValue]){
            //下个月的记录
            NSLog(@"%@",[JDateTime getFontYearAndMonth]);
            NSLog(@"%@",[JDateTime getEndYearAndMonth]);
            NSLog(@"%@",self.currentMonthList[0]);
            NSLog(@"%@",self.currentMonthList[41]);
            NSLog(@"%d",[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]);
            
            NSLog(@"%d",[JDateTime GetNumberOfDayByYear:self.currentYear andByMonth:self.currentMonth]);
            dayNum+=[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]-[self.currentMonthList[0] intValue]+[JDateTime GetNumberOfDayByYear:self.currentYear andByMonth:self.currentMonth];
            totalNewMessage[dayNum]=1;
        }else if([self.pointArr[i] hasSuffix:currentYearTodayStr]){//本月的记录
            dayNum+=[JDateTime GetNumberOfDayByYear:[[[JDateTime getFontYearAndMonth]objectForKey:@"YEAR"] intValue] andByMonth:[[[JDateTime getFontYearAndMonth]objectForKey:@"MONTH"] intValue]]-[self.currentMonthList[0] intValue];
            totalNewMessage[dayNum]=1;
        }
      
   
        

    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NEWNOTIFACTIONOPEATION" object:nil];
}
+(NSString*)getURL:(enum requestTypes)requestType{
    NSString *mainDomain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain] ;
    if ([mainDomain isEqualToString:kQIXINSERVER_IP]){
        return [NSString stringWithFormat:@"http://%@/lschedulezq/phoneInterface.do?", kCHEDLESERVER_IP];
    }else if([mainDomain isEqualToString:kTESTSERVER_IP]){
        return  [NSString stringWithFormat:@"http://%@/lschedule/phoneInterface.do?",kCHEDLESERVER_IP];
    }else if([mainDomain isEqualToString:kTESTSERVERONLY_IP]){
        return [NSString stringWithFormat:@"http://%@/lschedule/phoneInterface.do?", kTESTSERVERs_IP4];
    }else if([mainDomain isEqualToString: kOTHERSERVER_IP]){
        return [NSString stringWithFormat:@"http://%@/lschedulezq/phoneInterface.do?", kOTHERSERVER_IP];
    }
    return nil;
}
+(NSArray*)isTrueDateForString:(NSString*)date{
    
    NSString *matchedStr=@"\\d{4}+[-]\\d{2}+[-]\\d{2}";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"self matches %@",matchedStr];
    if([pred evaluateWithObject:date]){
        NSArray *array=[date componentsSeparatedByString:@"-"];
        int day[]={0, 31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        
        if([[array objectAtIndex:1]intValue]<1 ||[[array objectAtIndex:1]intValue]>12 || [[array objectAtIndex:2] intValue]<1){
            return nil;
        }
        if(([[array objectAtIndex:0]intValue] % 4 == 0 && [[array objectAtIndex:0]intValue] % 100 != 0) || [[array objectAtIndex:0]intValue] % 400 == 0){
            day[2]=29;
        }else{
            day[2]=28;
        }
        
        if([[array objectAtIndex:2] intValue]<=day[[[array objectAtIndex:1]intValue]]){
            return array;
        }
    }
    return  nil;
    
}


-(void)dealloc{
    [super dealloc];
}

@end

