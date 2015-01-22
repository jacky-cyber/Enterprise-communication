//
//  ShowAlertView.h
//  DL_MO_iPadProject
//
//  Created by liqiang on 14-1-17.
//  Copyright (c) 2014年 ishinetech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowAlertView : NSObject

+(void)showAlertViewStr:(NSString *)alertStr;
+(void)showAlertViewStr:(NSString *)alertStr andDlegate:(id)sender;
+(void)showAlertViewStr:(NSString *)alertStr andDlegate:(id)sender withTag:(NSInteger)tag;

@end
