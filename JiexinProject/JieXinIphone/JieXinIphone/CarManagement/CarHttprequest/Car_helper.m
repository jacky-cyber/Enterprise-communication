//
//  IPad_MangementServiceHelper.m
//  SunboxSoft_MO_iPad
//
//  Created by liqiang on 12-8-31.
//
//

#import "Car_helper.h"
#import <CommonCrypto/CommonDigest.h>
#import "SDDataCache.h"

#define Car_server @"http://111.11.28.30:8083"

@implementation Car_helper
@synthesize dizhi;
+ (id) sharedService
{
    static Car_helper *_sharedInst=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInst=[[self alloc] init];
    });
    return _sharedInst;
}

- (void)getHTTP
{
    NSString *domain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    if ([domain isEqualToString:@"111.11.28.41"])
    {
        self.dizhi = @"http://111.11.28.9:8089";
    }
    else if([domain isEqualToString:@"111.11.28.30"])
    {
        self.dizhi = @"http://111.11.28.30:8083";
    }
    //测试后千万要注掉这里 care
//    dizhi = @"http://10.120.145.26:8080";
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
	//	Reachability* curReach = [note object];
	//	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	//	BOOL connectionRequired= [hostReach connectionRequired];
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


- (void)requestForType:(HttpRequestType)type info:(NSDictionary *)requestInfo target:(id)target successSel:(NSString *)successSelector failedSel:(NSString *)failedSelector
{
    [self getHTTP];
    NSString *urlString = nil;
	NSString *storeString = nil;
    srand((unsigned)time(NULL)<<2);
    
    switch (type)
    {
        case kCarManager_Login:
        {
//            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=login&loginname=%@",dizhi,@"guoyuguang_qt"];
            
            
             storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=login&loginname=%@",dizhi,[requestInfo objectForKey:@"userName"]];

        }break;
        case kQuerycoursecarsqLoad:{
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryforsubmit&userId=%@",dizhi,[requestInfo objectForKey:@"userId"]];
        }break;
            
        case kQuerycoursecarsq:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action",dizhi];
        }break;
            
        case kQuerycoursecarsqDep:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=querydep&nowPage=-1",dizhi];
        }break;
            
        case kQuerycoursecarsqUser:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryuser&nowPage=-1&depid=%@",dizhi,[requestInfo objectForKey:@"depid"]];
        }break;
            
        case kQuerycourseCarManager:
        {
            NSString *power = [requestInfo objectForKey:@"power"];
            if ([power isEqualToString:@"0"])
            {
                storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryapplistadmin&nowPage=%@&cap=%@&handState=%@&userId=%@",dizhi,[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"],[requestInfo objectForKey:@"state"],[requestInfo objectForKey:@"userId"]];
                
            }
            else if ([power isEqualToString:@"1"])
            {
                storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryapplist&userId=%@&nowPage=%@&cap=%@&handState=%@",dizhi,[requestInfo objectForKey:@"userId"],[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"],[requestInfo objectForKey:@"state"]];
            }
            else if ([power isEqualToString:@"2"])
            {
                if ([[requestInfo objectForKey:@"state"] isEqualToString:@"0"] || [[requestInfo objectForKey:@"state"] isEqualToString:@"3"]) {
                    storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryapplistleader&leaderId=%@&nowPage=%@&cap=%@&handState=%@",dizhi,[requestInfo objectForKey:@"userId"],[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"],[requestInfo objectForKey:@"state"]];
                    
                    
                }
                else
                {
                    storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryapplist&userId=%@&nowPage=%@&cap=%@&handState=%@",dizhi,[requestInfo objectForKey:@"userId"],[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"],[requestInfo objectForKey:@"state"]];
                }
            }
            
        }break;
         
        case kQuerycourseCarDetail:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryappdetail&id=%@&userId=%@",dizhi,[requestInfo objectForKey:@"id"],[requestInfo objectForKey:@"userId"]];
            
        }break;
            
        case kCarManager_cancel:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=cancelapp&id=%@&userId=%@",dizhi,[requestInfo objectForKey:@"id"],[requestInfo objectForKey:@"userId"]];
        }break;
            
        case kCarManager_statistical:
        {
           storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=statbycarcompany&startTime=%@&endTime=%@&nowPage=%@&cap=%@",dizhi,[requestInfo objectForKey:@"startTime"],[requestInfo objectForKey:@"endTime"],[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"]];
            //如果时间信息不为空申请申请时间段内的信息
//            if([requestInfo objectForKey:@"startTime"]!=nil&&[requestInfo objectForKey:@"endTime"]!=nil){
//                storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=statbycarcompany&startTime=%@&endTime=%@&nowPage=%@&cap=%@",dizhi,[requestInfo objectForKey:@"startTime"],[requestInfo objectForKey:@"endTime"],[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"]];
//            }
//                else{
//                    //默认申请全部公司的信息
//                    storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=statbycarcompany&nowPage=%@&cap=%@",dizhi,[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"]];
//                }
        }
            break;
            
        case kCarManager_search: {
            
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=queryapplistadmin&nowPage=%@&cap=%@",dizhi,[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"]];
            
        }break;
            
        case kCarCommitByLeader:
        {
            
         storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=submitappleader",dizhi];
            
        }break;
            
        case kCarCommitByAdmin:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action",dizhi];
        }break;
            
        case kQueryByNameCarManage:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=querybyname&name=%@&nowPage=%@&cap=%@",dizhi,[requestInfo objectForKey:@"name"],[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"]];
        }break;
           
        case kCarGetCompanys:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=querysupplier&nowPage=-1&cap=10&loginname=%@",dizhi,[requestInfo objectForKey:@"loginname"]];
        }break;
            
        case kCarGetDrivers:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=querydriver&nowPage=1&cap=-1",dizhi];
        }break;
            
        case kCarGetCarNumber:
        {
            storeString = [NSString stringWithFormat:@"%@/phone/phoneInterface.action?cmd=querycar&nowPage=1&cap=-1",dizhi];
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
    if(type==kCarCommitByLeader){
        [request addPostValue:[requestInfo objectForKey:@"id"] forKey:@"id"];
        NSNumber *num=[NSNumber numberWithInt:[[requestInfo objectForKey:@"handState"]intValue]];
        [request addPostValue: num forKey:@"handState"];
        [request addPostValue:[requestInfo objectForKey:@"leaderOpinion"] forKey:@"leaderOpinion"];

    }
    if(type==kCarCommitByAdmin){
        [request addPostValue:@"submitappadmin" forKey:@"cmd"];
        [request addPostValue:[requestInfo objectForKey:@"userId"] forKey:@"userId"];
        [request addPostValue:[requestInfo objectForKey:@"userName"] forKey:@"userName"];
        [request addPostValue:[requestInfo objectForKey:@"id"] forKey:@"id"];
        [request addPostValue:[requestInfo objectForKey:@"handState"] forKey:@"handState"];
        [request addPostValue:[requestInfo objectForKey:@"driver"] forKey:@"driver"];
        [request addPostValue:[requestInfo objectForKey:@"driverTel"] forKey:@"driverTel"];
        [request addPostValue:[requestInfo objectForKey:@"carNum"] forKey:@"carNum"];
        [request addPostValue:[requestInfo objectForKey:@"carcompany"] forKey:@"carcompany"];
    }
    if (type == kCarManager_statistical) {
//        [request addPostValue:[requestInfo objectForKey:@"id"] forKey:@"id"];
    }
    if (type == kQuerycoursecarsq)
    {
        [request addPostValue:@"submitapp" forKey:@"cmd"];
        [request addPostValue:[requestInfo objectForKey:@"userId"] forKey:@"userId"];
        [request addPostValue:[requestInfo objectForKey:@"carusername"] forKey:@"carusername"];
        [request addPostValue:[requestInfo objectForKey:@"department"] forKey:@"department"];
        [request addPostValue:[requestInfo objectForKey:@"departmentId"] forKey:@"departmentId"];
        [request addPostValue:[requestInfo objectForKey:@"userName"] forKey:@"userName"];
        [request addPostValue:[requestInfo objectForKey:@"userTel"] forKey:@"userTel"];
        [request addPostValue:[requestInfo objectForKey:@"peopleNum"] forKey:@"peopleNum"];
        [request addPostValue:[requestInfo objectForKey:@"carType"] forKey:@"carType"];
        [request addPostValue:[requestInfo objectForKey:@"useTime"] forKey:@"useTime"];
        [request addPostValue:[requestInfo objectForKey:@"drivePlace"] forKey:@"drivePlace"];
        [request addPostValue:[requestInfo objectForKey:@"returnTime"] forKey:@"returnTime"];
        [request addPostValue:[requestInfo objectForKey:@"returnPlace"] forKey:@"returnPlace"];
        [request addPostValue:[requestInfo objectForKey:@"reason"] forKey:@"reason"];
        [request addPostValue:[requestInfo objectForKey:@"comname"] forKey:@"comname"];
        [request addPostValue:[requestInfo objectForKey:@"handState"] forKey:@"handState"];
        [request addPostValue:[requestInfo objectForKey:@"require"] forKey:@"require"];
        [request addPostValue:[requestInfo objectForKey:@"leader"] forKey:@"leader"];
        [request addPostValue:[requestInfo objectForKey:@"leaderId"] forKey:@"leaderId"];

        
    }

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
    [request setTimeOutSeconds:60.0f];
    [request setShouldAttemptPersistentConnection:NO];
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

    //解析json
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
    NSDictionary *targetCallBack = [requests objectForKey:request.requestFlagMark];
    [[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"requestFailed"]) withObject:nil];

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
