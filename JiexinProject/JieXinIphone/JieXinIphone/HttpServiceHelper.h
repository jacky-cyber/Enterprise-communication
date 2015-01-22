//
//  HttpServiceHelper.h
//  JieXinIphone
//
//  Created by 高大鹏 on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STFormDataRequest.h"
#import "Reachability.h"
#import "zlib.h"
#import "ZipArchive.h"

@interface HttpServiceHelper : NSObject<ASIHTTPRequestDelegate>
{
    NSMutableDictionary *requests;
    NSMutableArray *httpRequests;
    //判断网络是否连接
    Reachability* internetReach;
    NetworkStatus netStatus;
    BOOL isSave;
}


+ (HttpServiceHelper *)sharedService;
- (void)restore;
- (NSString *)getTimeStamp;
- (BOOL)checkNetwork:(NSString *)errorMessage;
- (void)requestForType:(HttpRequestType)type info:(NSDictionary *)requestInfo target:(id)target successSel:(NSString *)successSelector failedSel:(NSString *)failedSelector;
- (void)httpsCancel;
- (void)cancelRequestForDelegate:(id)delegate;


@end
