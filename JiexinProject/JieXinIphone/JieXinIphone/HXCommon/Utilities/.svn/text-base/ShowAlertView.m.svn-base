//
//  ShowAlertView.m
//  DL_MO_iPadProject
//
//  Created by liqiang on 14-1-17.
//  Copyright (c) 2014年 ishinetech. All rights reserved.
//

#import "ShowAlertView.h"

@implementation ShowAlertView
+(void)showAlertViewStr:(NSString *)alertStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:alertStr
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];

    [alert release];
}

+(void)showAlertViewStr:(NSString *)alertStr andDlegate:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:alertStr
                                                   delegate:sender
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    [alert release];
}

+(void)showAlertViewStr:(NSString *)alertStr andDlegate:(id)sender withTag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:alertStr
                                                   delegate:sender
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    alert.tag = tag;
    [alert show];
    
    [alert release];
}



@end
