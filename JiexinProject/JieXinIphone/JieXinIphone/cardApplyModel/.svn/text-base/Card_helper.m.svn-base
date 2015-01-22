//
//  Card_helper.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-5-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//
#import "Card_helper.h"
#import <CommonCrypto/CommonDigest.h>
#import "SDDataCache.h"

@implementation Card_helper
@synthesize dizhi;

+ (id) sharedService
{
    static Card_helper *_sharedInst=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[self alloc] init];
    });
    return _sharedInst;
}

- (void)getHTTP
{
//    dizhi = nil;
    NSString *domain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    if ([domain isEqualToString:@"111.11.28.41"])
    {
        self.dizhi = @"http://111.11.28.9:8091";
    }
    else if([domain isEqualToString:@"111.11.28.30"])
    {
         self.dizhi = @"http://111.11.28.30:8091";
//          dizhi = @"http://111.11.28.9:8091";
    }
}

-(void)dealloc{
    [requests release];
    [httpRequests release];
    [super dealloc];
}

- (id) init
{
	if (self = [super init])
	{
        requests =  [[NSMutableDictionary alloc] init];
        netStatus = [internetReach currentReachabilityStatus];
        httpRequests = [[NSMutableArray alloc] init];
	}
	return self;
}

- (BOOL)checkNetwork:(NSString *)errorMessage
{
    Reachability *internetReached = [Reachability reachabilityForInternetConnection];
	//网络异常
	if([internetReached currentReachabilityStatus] == NotReachable)
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"网络错误", @"") message:errorMessage delegate:self cancelButtonTitle:NSLocalizedString(@"确定", @"") otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		
		return NO;
        
	}
	return YES;
}

//监视网络状态,状态变化调用该方法.
- (void)reachabilityChanged: (NSNotification* )note
{
	netStatus = [internetReach currentReachabilityStatus];
	if (netStatus != kNotReachable)
	{
		//网络可用  在这将记录的收藏等操作完成.
		NSLog(@"网络可用");
	}
	else
	{
		//网络不可用
		NSLog(@"网络不可用");
	}
}


- (void)requestForType:(CardRequestType)type info:(NSDictionary *)requestInfo target:(id)target successSel:(NSString *)successSelector failedSel:(NSString *)failedSelector
{
    [self getHTTP];
    NSString *urlString = nil;
	NSString *storeString = nil;
    srand((unsigned)time(NULL)<<2);
    
    switch (type)
    {
        case Card_CommitRequest:
        {
             storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=submitapp&departmentId=%@&jobid=%@&userid=%@&appName=%@&userName=%@&mobile=%@&amount=%@&leader=%@&leaderId=%@&handState=%@&email=%@&fax=%@&phone=%@&yuserName=%@&pcode=%@",dizhi,[requestInfo objectForKey:@"departmentId"],[requestInfo objectForKey:@"jobid"],[requestInfo objectForKey:@"userid"],[requestInfo objectForKey:@"appName"],[requestInfo objectForKey:@"userName"],[requestInfo objectForKey:@"mobile"],[requestInfo objectForKey:@"amount"],[requestInfo objectForKey:@"leader"],[requestInfo objectForKey:@"leaderId"],[requestInfo objectForKey:@"handState"],[requestInfo objectForKey:@"email"],[requestInfo objectForKey:@"fax"],[requestInfo objectForKey:@"phone"],[requestInfo objectForKey:@"yuserName"],[requestInfo objectForKey:@"pcode"]];
        }break;
            
        case Card_UserInfoRequest:
        {
            storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryforsubmit&userId=%@",dizhi,[requestInfo objectForKey:@"userId"]];
        }break;
        case Card_LoginRequest:
        {
            storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=login&loginname=%@",dizhi,[[NSUserDefaults standardUserDefaults] objectForKey:User_Name]]/*@"zhangchao_qt"*/;
        }break;

        case Card_UserRequest:
        {
             NSString *handleState=[requestInfo objectForKey:@"handState"];
            if(handleState.length!=0){
            storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryapplist&userId=%@&nowPage=1&cap=100&handState=%@",dizhi,[requestInfo objectForKey:@"userId"],handleState];
            }else{
             storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryapplist&userId=%@&nowPage=1&cap=100",dizhi,[requestInfo objectForKey:@"userId"]];
            }
        }break;
        case Card_AdminRequest:
        {
            NSString *handleState=[requestInfo objectForKey:@"handState"];
            if(handleState.length!=0){
            storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryapplistadmin&userId=%@&nowPage=1&cap=100&handState=%@",dizhi,[requestInfo objectForKey:@"userId"],handleState];
            }else{
             storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryapplistadmin&userId=%@&nowPage=1&cap=100",dizhi,[requestInfo objectForKey:@"userId"]];
            }
        }break;
        case Card_LeaderRequest:
        {
             NSString *handleState=[requestInfo objectForKey:@"handState"];
            if(handleState.length!=0){
            storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryapplistleader&userId=%@&nowPage=1&cap=100&handState=%@",dizhi,[requestInfo objectForKey:@"userId"],handleState];
            }else{
                storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=queryapplistleader&userId=%@&nowPage=1&cap=100",dizhi,[requestInfo objectForKey:@"userId"]];

            }
        }break;
        case Card_ApprovalRequest:
        {
            storeString = [NSString stringWithFormat:@"%@/cardzq/phone/phoneInterface.action?cmd=submitappleader&id=%@&handState=%@",dizhi,[requestInfo objectForKey:@"id"],[requestInfo objectForKey:@"handState"]];
        }break;
               default:
			break;
    }
    urlString = storeString;
    urlString = [NSString encodeChineseToUTF8:urlString];

    if (![self checkNetwork:nil])
    {
        NSData *data = [[SDDataCache sharedDataCache] dataFromKey:storeString];
        NSDictionary *dic = [NSDictionary dictionary];
        if(data)
        {
            dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            //[target performSelector:NSSelectorFromString(successSelector) withObject:dic];
        }
        [target performSelector:NSSelectorFromString(successSelector) withObject:dic];
        
        return;
    }
    STFormDataRequest *request = [STFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
	request.requestFlagMark = [self getTimeStamp];
    request.userInfo=@{@"type":[NSNumber numberWithInt:type],@"delegate":target};
    [httpRequests addObject:request];
    NSMutableDictionary *headers = [[NSUserDefaults standardUserDefaults] objectForKey:Headers_Define];
    for(id key in [headers allKeys])
    {
        id value = [headers objectForKey:key];
        if(value)
        {
            [request addRequestHeader:key value:value];
        }
    }
    
    //带cookie的过程
    [request setUseCookiePersistence:NO];
    NSData *oldData = [[SDDataCache sharedDataCache] dataFromKey:@"Cookie"];
    NSMutableArray *cookie = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
    request.requestCookies = cookie;
    [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:60.0f];
    [request setDelegate:self];
    NSLog(@"%@",cookie);
    if (target)
	{
		NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:target, @"delegate", successSelector, @"requestFinished", failedSelector, @"requestFailed", nil];
		[requests setObject:tempDic forKey:request.requestFlagMark];
	}
	[request setDelegate:self];
    
    //异步
	[request startAsynchronous];
  
}
#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(STFormDataRequest *)request
{
    // 当以文本形式读取返回内容时用这个方法
    NSString *jsonString = [request responseString];
    NSData *jsonData = [request responseData];
    NSLog(@"服务器返回：jsonString=%@",jsonString);

    //解析json（确定返回数据格式为Json）
	NSMutableDictionary *parsedData = [NSMutableDictionary dictionaryWithDictionary:[self convertJsonToObject:jsonData]];
    
    NSDictionary *targetCallBack = [requests objectForKey:request.requestFlagMark];
    
    //归档
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:parsedData];
	//解档
    [[SDDataCache sharedDataCache] storeData:data forKey:[request.url absoluteString] toDisk:YES];

    [[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"requestFinished"]) withObject:parsedData];
    
    [requests removeObjectForKey:request.requestFlagMark];
    [httpRequests removeObject:request];
}

- (void)requestFailed:(STFormDataRequest *)request
{
    NSError *error = [request error];
    NSLog(@"服务器错误：requestFailed error =%@",error);
    
    [requests removeObjectForKey:request.requestFlagMark];
    
    [httpRequests removeObject:request];
}

- (NSString *)getTimeStamp
{
	NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
	return [NSString stringWithFormat:@"%f",timestamp];
}

#pragma mark - 清除网络请求
//清除所有的网络请求
- (void)httpsCancel
{
    for(STFormDataRequest *httpRequest in httpRequests)
    {
        [httpRequest clearDelegatesAndCancel];
    }
    [httpRequests removeAllObjects];
}

//通过delegate来清除相应的网络请求
- (void)cancelRequestForDelegate:(id)delegate
{
    for(STFormDataRequest *httpRequest in httpRequests)
    {
        id target = [httpRequest.userInfo objectForKey:@"delegate"];
        if (target == delegate) {
            [httpRequest clearDelegatesAndCancel];
            [httpRequests removeObject:httpRequest];
        }
    }
}

#pragma mark -
#pragma mark json的解析和生成

//将json转化为NSDictionary或者NSArray
- (id)convertJsonToObject:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil)
    {
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

//将NSDictionary或者NSArray转化为Json
- (NSData *)convertObjectToJson:(id)object
{
    if ([NSJSONSerialization isValidJSONObject:object])
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if ([jsonData length] > 0 && error == nil)
        {
            return jsonData;
        }
    }
    return  nil;
}

@end
