//
//  Card_helper.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STFormDataRequest.h"
#import "Reachability.h"


@interface Card_helper: NSObject<UIAlertViewDelegate,ASIHTTPRequestDelegate>
{
    NSMutableDictionary *requests;
    NSMutableArray *httpRequests;
    
    NetworkStatus netStatus;
    Reachability* internetReach;
}

+ (Card_helper *)sharedService;
- (void)requestForType:(CardRequestType)type info:(NSDictionary *)requestInfo target:(id)target successSel:(NSString *)successSelector failedSel:(NSString *)failedSelector;
- (void)httpsCancel;
- (void)cancelRequestForDelegate:(id)delegate;

@property(nonatomic,strong) NSString *dizhi;


@end
