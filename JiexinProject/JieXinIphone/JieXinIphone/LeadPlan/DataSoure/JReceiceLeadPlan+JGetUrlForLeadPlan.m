//
//  JReceiceLeadPlan+JGetUrlForLeadPlan.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-2.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JReceiceLeadPlan+JGetUrlForLeadPlan.h"

@implementation JReceiceLeadPlan (JGetUrlForLeadPlan)


+(NSDictionary*)checkLeadPlanRequestUrlType:(enum requestTypes)requestTyep info:(NSDictionary*)dic{
    NSString *dizhi = nil;
    switch (requestTyep) {
        case QueryUserCalendarRight:{
            dizhi =[NSString stringWithFormat:@"%@cmd=%@&username=%@",[self getURL:requestTyep],kQueryUserCalendarRight,[dic objectForKey:@"userName"]];
        }
            break;
        case QueryUserMonCalendarList:{
            dizhi =[NSString stringWithFormat:@"%@cmd=%@&userId=%@&moth=%@",[self getURL:requestTyep],kQueryUserMonCalendarList,[dic objectForKey:@"userId"],[dic objectForKey:@"month"]];

        }
            break;
        case QueryUserDayCalendarList:{
            dizhi =[NSString stringWithFormat:@"%@cmd=%@&userId=%@&day=%@",[self getURL:requestTyep],kQueryUserDayCalendarList,[dic objectForKey:@"userId"],[dic objectForKey:@"day"]];
            }
            break;
        case QueryUserSpecifyDayCalendar:{
            dizhi =[NSString stringWithFormat:@"%@cmd=%@&userId=%@&startDay=%@&endDay=%@",[self getURL:requestTyep],kQueryUserSpecifyDayCalendarList,[dic objectForKey:@"userId"],[dic objectForKey:@"startDay"],[dic objectForKey:@"endDay"]];
            }
            break;
            
        default:
            break;
    }
    NSURL *url = [NSURL URLWithString:dizhi];
    if(!url) return nil;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [request release];
    
    if(received==nil){
        return nil;
    }
    NSError *error;
    NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    return dics;

}

@end
