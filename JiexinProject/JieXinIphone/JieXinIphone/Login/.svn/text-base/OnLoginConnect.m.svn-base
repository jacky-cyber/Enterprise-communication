//
//  OnLoginConnect.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-8.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "OnLoginConnect.h"

@implementation OnLoginConnect

+ (void)doReLoginConnect:(NSDictionary *)loginDic;
{
    NSString *status = [loginDic objectForKey:@"status"];
    NSString *username = [loginDic objectForKey:@"username"];
    NSString *clientDbVersion = [loginDic objectForKey:@"clientDbVersion"];
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:kClientDbVersion])
//    {
//        clientDbVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kClientDbVersion];
//    }
    NSString *userPsw =  [loginDic objectForKey:@"userPsw"];
    //    NSString *domain = [NSString stringWithFormat:@"%d",]
    //loginType  1代表iPhone 0 是安卓
    NSString *loginType = [NSString stringWithFormat:@"%d",kiPhoneLoginType];
    BOOL isPhoneNum = [ToolUtil validateMobile:username];
    NSArray *loginArr =nil;
    if (isPhoneNum)
    {
       loginArr = @[@{@"cmd":@"login"},@{@"status": status},@{@"domain": @"9000"},@{@"mobile": username},@{@"clientDbVersion": clientDbVersion},@{@"userPsw": userPsw},@{@"type": @"req"},@{@"loginType": loginType}];
    }
    else
    {
        loginArr = @[@{@"cmd":@"login"},@{@"status": status},@{@"domain": @"9000"},@{@"userName": username},@{@"clientDbVersion": clientDbVersion},@{@"userPsw": userPsw},@{@"type": @"req"},@{@"loginType": loginType}];
    }

    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:loginArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

@end
