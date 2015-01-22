//
//  GetContantValue.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-15.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "GetContantValue.h"

@implementation GetContantValue
+(NSString *)getDomaiId
{
    NSString *headStr = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *companyPackageid = @"0";
    if([headStr isEqualToString:@"111.11.28.29"])
    {
        companyPackageid=@"0";
    }
    else if
        ([headStr isEqualToString:@"111.11.28.30"])
    {
        companyPackageid=@"3";
    }
    else if
        ([headStr isEqualToString:@"111.11.28.41"])
    {
        companyPackageid=@"1";
    }
    else if
        ([headStr isEqualToString:@"10.120.148.84"])
    {
        companyPackageid=@"4";
    }
    else if([headStr isEqualToString:@"111.11.28.57"])
    {
        companyPackageid = @"5";
    }
    else if([headStr isEqualToString:@"111.11.28.58"])
    {
        companyPackageid = @"6";
    }
    else if([headStr isEqualToString:@"111.11.29.65"])
    {
        companyPackageid = @"7";
    }
    else if([headStr isEqualToString:@"111.11.28.53"])
    {
        companyPackageid = @"8";
    }
    return companyPackageid;
}

+(NSString *)getHeadStr
{
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    NSString *headString= @"";
    if([string isEqualToString:@"111.11.28.30"])
    {
        headString=@"http://111.11.28.30:8087";
    }
    else
    {
        headString=@"http://111.11.28.9:8087";
    }
    return headString;
}
@end
