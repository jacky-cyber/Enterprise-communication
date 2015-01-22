//
//  JReceiceLeadPlan+JReceiceLeadPlanForPostRequest.m
//  JieXinIphone
//
//  Created by Jeffrey on 14-4-8.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "JReceiceLeadPlan+JReceiceLeadPlanForPostRequest.h"
#import "ASIFormDataRequest.h"
@implementation JReceiceLeadPlan (JReceiceLeadPlanForPostRequest)
+(NSDictionary*)postLeadPlanRequestUrlType:(enum requestTypes)requestTyep key:(NSArray*)_key info:(NSArray*)_value {
    NSString *dizhi = nil;
    ASIFormDataRequest *request=nil;;
    switch (requestTyep) {
        case AddDayCanlendar:{
            dizhi=[self getURL:requestTyep];
            request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:dizhi]];
            for(int i=0;i<[_key count];i++){
                [request setPostValue:[_value objectAtIndex:i] forKey:[_key objectAtIndex:i]];
            }
        }
            break;
        case ModifyDayCanlendar:{
            dizhi=[self getURL:requestTyep];
            request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:dizhi]];
            for(int i=0;i<[_key count];i++){
                [request setPostValue:[_value objectAtIndex:i] forKey:[_key objectAtIndex:i]];
            }
        }
            break;
        case DelateDayCanlendar:{
            dizhi=[self getURL:requestTyep];
            request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:dizhi]];
            for(int i=0;i<[_key count];i++){
                [request setPostValue:[_value objectAtIndex:i] forKey:[_key objectAtIndex:i]];
            }
        }
            break;
        default:
            break;
    }
 
    [request startSynchronous];
    if([request error]){
        [request release];
        return nil;
    }
    NSData *received=[request responseData];
    NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:nil];
    return dics;
}


@end
