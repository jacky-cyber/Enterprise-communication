//
//  HttpReachabilityHelper.m
//  JieXinIphone
//
//  Created by tony on 14-3-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "HttpReachabilityHelper.h"

@implementation HttpReachabilityHelper

static HttpReachabilityHelper *_sharedInst = nil;

+ (id) sharedService
{
	@synchronized(self){
		if(_sharedInst == nil)
		{
			_sharedInst = [[self alloc] init];
		}
	}
	return _sharedInst;
}

- (id) init
{
	if (self = [super init])
	{
		//通知 (网络状态变化)
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChangedRecent:) name: kReachabilityChangedNotification object: nil];
		//Change the host name here to change the server your monitoring
		internetReach = [[Reachability reachabilityForInternetConnection]retain];
	    [internetReach startNotifier];
		netStatus = [internetReach currentReachabilityStatus];
	}
	return self;
}

#pragma mark Reachability
//监视网络状态,状态变化调用该方法.
- (void)reachabilityChangedRecent: (NSNotification* )note
{
	netStatus = [internetReach currentReachabilityStatus];
	if (netStatus != kNotReachable)
	{
		//网络可用  在这将记录的收藏等操作完成.
		NSLog(@"reachabilityChangedRecent-->网络可用");
        //重新连接socket
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus]) {
            [[YiXinScoketHelper sharedService] connect];
        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:kConnect object:nil];
	}
	else
	{
		//网络不可用
		NSLog(@"reachabilityChangedRecent-->网络不可用");
        [[NSNotificationCenter defaultCenter] postNotificationName:kReachChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDisconnect object:nil];
        //        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"网络不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
        //        [alert release];
	}
}

- (BOOL)checkNetwork:(NSString *)errorMessage
{
	netStatus = [internetReach currentReachabilityStatus];
    //网络异常
    if(netStatus == kNotReachable){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:errorMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        [alertView release];
		return NO;
	}
	return YES;
}

@end
