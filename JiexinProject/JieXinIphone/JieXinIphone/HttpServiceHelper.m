//
//  HttpServiceHelper.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-3-12.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "HttpServiceHelper.h"
#import "SDDataCache.h"
#import "JSON.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDictionary+HttpXMLParser.h"

#define  kCHEDLESERVER_IP @"http://111.11.28.9:8080"
#define kQIXINSERVER_IP @"111.11.28.41"
#define kOTHERSERVER_IP @"111.11.29.71:8080"
#define kTESTSERVERONLY_IP @"111.11.28.30"
#define kTESTSERVER_IP @"111.11.28.29"
#define kTESTSERVER_IP2 @"111.11.28.9:8087"
#define kTESTSERVER_IP3 @"111.11.28.30:8083"
#define kdocumentMange_IP @"111.11.28.20"

#define kQueryUserCalendarRight @"queryUserCalendarRight"
#define kQuerycourselists @"querycourselist"
#define kQuerycoursedetails @"querycoursedetail"
@implementation HttpServiceHelper

static HttpServiceHelper *_sharedInst = nil;

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
		requests = [[NSMutableDictionary alloc] init];
		[self restore];
		//通知 (网络状态变化)(不用加，此时都放到了HttpReachabilityHelper进行统一管理)
		//[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
		//Change the host name here to change the server your monitoring
		internetReach = [[Reachability reachabilityForInternetConnection]retain];
	    [internetReach startNotifier];
		netStatus = [internetReach currentReachabilityStatus];
        httpRequests = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (BOOL)checkNetwork:(NSString *)errorMessage
{
    Reachability *internetReached=[Reachability reachabilityForInternetConnection];
    //网络异常
    if([internetReached currentReachabilityStatus] == NotReachable){
		return NO;
	}
	return YES;
}

#pragma mark Reachability
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
        for (int i = 0; i < [httpRequests count]; ++i) {
            [self requestFailed:[httpRequests objectAtIndex:i]];
        }
        [self httpsCancel];
        //        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"网络不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
        //        [alert release];
	}
}


-(void)requestFinished:(STFormDataRequest *)request
{
    NSString *_contentLengend = [request.responseHeaders valueForKey:@"Content-Length"];
    NSLog(@"size:%.3fKB",[_contentLengend intValue]/1024.0);
    NSLog(@"%@",NSHomeDirectory());
    
    
	NSString *xmlString = [request responseString];
	NSLog(@"xmlString %@",xmlString);
    
	if (!xmlString)
	{
		//NSLog(@"xmlData %@",[request responseData]);
		//NSASCIIStringEncoding 1~30;
		for (int i = 1; i < 30; i++)
		{
			xmlString = [[[NSString alloc] initWithData:[request responseData] encoding:i] autorelease];
			NSLog(@"xml %@ %d",xmlString , i);
			if (xmlString)
			{
				break;
			}
		}
	}
    
	//解析数据
    HttpRequestType type = (HttpRequestType)[[request.userInfo objectForKey:@"type"] intValue];
    NSMutableDictionary *parsedData = [NSMutableDictionary dictionary];
    if (type == Http_UploadChatBigImage)
    {
        parsedData = [NSMutableDictionary dictionaryWithDictionary:[xmlString JSONValue]];
        //因为上传完大图要上传小图所以要将id和smallimagekey带过去
        [parsedData setValue:[request.userInfo objectForKey:@"small"] forKeyPath:@"small"];
        [parsedData setValue:[request.userInfo objectForKey:@"big"] forKeyPath:@"big"];
        [parsedData setValue:[request.userInfo objectForKey:@"date"] forKeyPath:@"date"];
        [parsedData setValue:[request.userInfo objectForKey:@"sendType"] forKey:@"sendType"];
    }
    else if(type == Http_UploadChatSmallImage)
    {
        parsedData = [NSMutableDictionary dictionaryWithDictionary:[xmlString JSONValue]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:request.userInfo];
        [dic removeObjectForKey:@"image"];
        for(NSString *key in dic)
        {
            [parsedData setValue:[dic objectForKey:key] forKeyPath:key];
        }
    }
    else if (type == Http_FretchAppVersion)
    {
        parsedData = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary httpDictionaryFromXML:xmlString withType:type]];
        //然后将userinfo里面的内容全部放到返回的字典里面去
        for(NSString *key in request.userInfo)
        {
            [parsedData setValue:[request.userInfo objectForKey:key] forKeyPath:key];
        }
    }

    else if (type == KQueryUserCalendarRight ||type==kQuerycourselist||type==kQuerycourselista||type==kQuerycourseFinancialDetial ||type==kQueryhumanResourceAllcategory||type==kQueryhumanResourcelist||type==kQuerycoursehumanResourceDetial||type== kQuerycourseCarManager||type ==kQuerycourseCarDetail||type ==kQuerycoursecarsq||type==kQuerycourseDocumentManage || type== kQuerycourseDocumentManageDownload||type==kQuerycourseDocumentSortMange||type==KQuerycoursedetail||type==kQueryallcategory||type==kQuerynews||type==kQuerynewsDetail||type==kQuerySecurityTips||type==kQuerySecurityTipsDetail||type== kQueryallcategorya){
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingAllowFragments error:&error];
        if (dic != nil && error == nil)
        {
            parsedData = [dic copy];
        }

    }
    
	NSDictionary *targetCallBack = [requests objectForKey:request.requestFlagMark];
	BOOL shouldTriggerErrorHandler = NO;
    
	//归档
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:parsedData];
	//解档
	[[SDDataCache sharedDataCache] storeData:data forKey:[request.url absoluteString] toDisk:YES];
	//
	if(shouldTriggerErrorHandler)
	{
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onfailed"]) withObject:@"auth error"];
	}
	else
	{
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onsuccess"]) withObject:parsedData];
	}
	[requests removeObjectForKey:request.requestFlagMark];
    
    [httpRequests removeObject:request];
}

-(void)requestFailed:(STFormDataRequest *)request
{
	NSDictionary *targetCallBack = [requests objectForKey:request.requestFlagMark];
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
    
	NSData *data = [[SDDataCache sharedDataCache] dataFromKey:[request.url absoluteString]];
	if (data)
	{
		NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onsuccess"]) withObject:dic];
		//NSLog(@"cache dic %@",dic);
	}
	else
	{
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onfailed"]) withObject:@"connection error"];
	}
	[requests removeObjectForKey:request.requestFlagMark];
    
    [httpRequests removeObject: request];
}

- (void)requestForType:(HttpRequestType)type info:(NSDictionary *)requestInfo target:(id)target successSel:(NSString *)successSelector failedSel:(NSString *)failedSelector;
{
	NSString *urlString = nil;
	NSString *storeString = nil;
    
	srand((unsigned)time(NULL)<<2);
    
	NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
    
	switch (type)
	{
		case Http_FretchAppVersion:
		{
            if ([domain hasPrefix:@"http"]) {
                storeString = [NSString stringWithFormat:@"%@/app/ios/upgrade/IosUpdateSoftware.xml",domain];
            }
            else
            {
                storeString = [NSString stringWithFormat:@"http://%@/app/ios/upgrade/IosUpdateSoftware.xml",domain];
            }
			urlString = storeString;
            
		}break;
            
        case Http_UploadChatBigImage:
        case Http_UploadChatSmallImage:
		{
            if ([domain hasPrefix:@"http"]) {
                storeString = [NSString stringWithFormat:@"%@/webimadmin/api/image/chat/",domain];
            }
            else
            {
                storeString = [NSString stringWithFormat:@"http://%@/webimadmin/api/image/chat",domain];
            }
			urlString = storeString;
            
		}break;
        case KQueryUserCalendarRight:
        {
            NSString *userName = [requestInfo objectForKey:@"UserName"];
            if ([domain isEqualToString:kQIXINSERVER_IP]) {
                storeString =[NSString stringWithFormat:@"%@/lschedulezq/phoneInterface.do?cmd=%@&username=%@",kCHEDLESERVER_IP,kQueryUserCalendarRight,userName];
            }
            else if([domain isEqualToString:kTESTSERVER_IP])
            {
                storeString =[NSString stringWithFormat:@"%@/lschedule/phoneInterface.do?cmd=%@&username=%@",kCHEDLESERVER_IP,kQueryUserCalendarRight,userName];
            }
            else if([domain isEqualToString:kTESTSERVERONLY_IP])
            {
                //                storeString =[NSString stringWithFormat:@"http://10.120.145.55:8088/lschedule/phoneInterface.do?cmd=%@&username=%@",kQueryUserCalendarRight,userName];
                storeString =[NSString stringWithFormat:@"http://%@/lschedule/phoneInterface.do?cmd=%@&username=%@",kTESTSERVERs_IP4,kQueryUserCalendarRight,userName];
            }
            else if([domain isEqualToString:kOTHERSERVER_IP]){
                storeString =[NSString stringWithFormat:@"%@/lschedule/phoneInterface.do?cmd=%@&username=%@",kOTHERSERVER_IP,kQueryUserCalendarRight,userName];
            }else if([domain isEqualToString:kOTHERSERVER_IP]){
                storeString =[NSString stringWithFormat:@"%@/lschedulezq/phoneInterface.do?cmd=%@&username=%@",kOTHERSERVER_IP,kQueryUserCalendarRight,userName];
            }
            urlString = storeString;
            
        }break;
        case kQueryallcategorya:{//党务视窗一级选择界面
            if([domain isEqualToString:kTESTSERVER_IP]||[domain isEqualToString:kQIXINSERVER_IP]){
                storeString=[NSString stringWithFormat:@"http://%@/partyViewzq/phoneInterface.action?cmd=queryallcategory",kTESTSERVER_IP2];
                
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/partyViewzq/phoneInterface.action?cmd=queryallcategory",kTESTSERVERONLY_IP];
            }
        }
        urlString=storeString;
        break;
        case kQuerycourselist:{//党务视窗
            if([domain isEqualToString:kTESTSERVER_IP]||[domain isEqualToString:kQIXINSERVER_IP]){
                storeString=[NSString stringWithFormat:@"http://%@/partyViewzq/phoneInterface.action?cmd=querycourselist",kTESTSERVER_IP2];
                
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/partyViewzq/phoneInterface.action?cmd=querycourselist",kTESTSERVERONLY_IP];
//                storeString=[NSString stringWithFormat:@"http://192.168.1.233:8080/partyView/phoneInterface.action?cmd=querycourselist"];
            }
                   }
            urlString=storeString;
            break;
        case KQuerycoursedetail:{//党务视窗内容
            if([domain isEqualToString:kTESTSERVER_IP]||[domain isEqualToString:kQIXINSERVER_IP]){
                storeString=[NSString stringWithFormat:@"http://%@/partyViewzq/phoneInterface.action?cmd=querycoursedetail&courseid=%@",kTESTSERVER_IP2,[requestInfo objectForKey:@"courseid"]];
                
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/partyViewzq/phoneInterface.action?cmd=querycoursedetail&courseid=%@",kTESTSERVERONLY_IP,[requestInfo objectForKey:@"courseid"]];
                
            }
           
        }
            urlString=storeString;
            break;
            
        case kQuerycourselista:{
            if([domain isEqualToString:kTESTSERVER_IP]||[domain isEqualToString:kQIXINSERVER_IP]){
                 storeString=[NSString stringWithFormat:@"http://%@/financialMzq/phoneInterface.action?cmd=querycourselist&category=%@&pageNumber=%@&pageCount=%@",kTESTSERVER_IP2,[requestInfo objectForKey:@"category"],[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/financialMzq/phoneInterface.action?cmd=querycourselist&category=%@&pageNumber=%@&pageCount=%@",kTESTSERVERONLY_IP,[requestInfo objectForKey:@"category"],[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }
           
        }
            urlString=storeString;
            break;
        case kQueryallcategory:{//财务管理界面列表
            if([domain isEqualToString:kQIXINSERVER_IP]){
            storeString=[NSString stringWithFormat:@"http://%@/financialMzq/phoneInterface.action?cmd=queryallcategory&pageNumber=%@&pageCount=%@",kTESTSERVER_IP2,[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/financialMzq/phoneInterface.action?cmd=queryallcategory&pageNumber=%@&pageCount=%@",kTESTSERVERONLY_IP,[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }
            
        }
            urlString=storeString;
            break;
        case kQuerycourseFinancialDetial:{
            NSString * str = [[NSString alloc]init];
            if ([domain isEqualToString:@"111.11.28.41"]) {
                str = @"111.11.28.9";
            }
            else{
                str = @"111.11.28.30";
            }
            storeString=[NSString stringWithFormat:@"http://%@:8087/financialMzq/phoneInterface.action?cmd=querycoursedetail&courseid=%@",str,[requestInfo objectForKey:@"courseid"]];
            
        }
            urlString=storeString;
            break;
        case kQueryhumanResourcelist:{//人力资源
            if([domain isEqualToString:kTESTSERVER_IP]||[domain isEqualToString:kQIXINSERVER_IP]){
                storeString=[NSString stringWithFormat:@"http://%@/%@/phoneInterface.action?cmd=querycourselist&category=%@&pageNumber=%@&pageCount=%@",kTESTSERVER_IP2,applyName,[requestInfo objectForKey:@"category"],[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/%@/phoneInterface.action?cmd=querycourselist&category=%@&pageNumber=%@&pageCount=%@",zhengshiIP,applyName,[requestInfo objectForKey:@"category"],[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }
            
        }
            urlString=storeString;
            break;
        case kQueryhumanResourceAllcategory:{
            if([domain isEqualToString:kQIXINSERVER_IP]){
                storeString=[NSString stringWithFormat:@"http://%@/%@/phoneInterface.action?cmd=queryallcategory&pageNumber=%@&pageCount=%@",kTESTSERVER_IP2,applyName,[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }else if([domain isEqualToString:kTESTSERVERONLY_IP]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/%@/phoneInterface.action?cmd=queryallcategory&pageNumber=%@&pageCount=%@",zhengshiIP,applyName,[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }
            
        }
            urlString=storeString;
            break;
        case kQuerycoursehumanResourceDetial:{
            NSString * str = [[NSString alloc]init];
            if ([domain isEqualToString:@"111.11.28.41"]) {
                str = @"111.11.28.9";
            }
            else{
                str = @"111.11.28.9";
            }
            storeString=[NSString stringWithFormat:@"http://%@:8087/%@/phoneInterface.action?cmd=querycoursedetail&courseid=%@",str,applyName,[requestInfo objectForKey:@"courseid"]];
            
        }
            urlString=storeString;
            break;
   
        case kQuerycourseCarManager:{
            storeString=[NSString stringWithFormat:@"http://%@/phone/phoneInterface.action?cmd=queryapplistadmin&nowPage=%@&cap=%@",kTESTSERVER_IP3,[requestInfo objectForKey:@"nowPage"],[requestInfo objectForKey:@"cap"]];
        }
            urlString=storeString;
            break;
            //        case kQuerycourseCarDetail:{
            //            storeString = [NSString stringWithFormat:@"http://%@/phone/phoneInterface.action?cmd=queryappdetail&id=%@",kTESTSERVER_IP3,[requestInfo objectForKey:@"id"]];
            //        }
            //            urlString = storeString;
            //
            //
            //        case kQuerycoursecarsq:{
            //            storeString = [NSString stringWithFormat:@"http://%@/phone/phoneInterface.action?cmd=queryforsubmit&userId=%@",kTESTSERVER_IP3,[requestInfo objectForKey:@"userId"]];
            //        }
            //            urlString = storeString;
            //            NSLog(@"%@",urlString);
        case kQuerycourseDocumentManage:{
            storeString=[NSString stringWithFormat:@"http://%@/FileShare/fileInfoList.action?groupId=0&isMyFile=0&page=1&proId=%@&rows=20&searchFileName=&status=readCount&userId=8889611",kdocumentMange_IP,[requestInfo objectForKey:@"proId"]];
            //  storeString=[NSString stringWithFormat:@"http://10.120.147.115:8080/PortalLet/addressList.action?userActionType=getAddressToAndroid&userId=18"];
            
        }
            urlString=storeString;
            break;
            
        case kQuerycourseDocumentSortMange:{
            storeString=[NSString stringWithFormat:@"http://%@/FileShare/Sections.action?upId=%@&groupId=%@",kdocumentMange_IP,[requestInfo objectForKey:@"upId"],[requestInfo objectForKey:@"groupId"]];
            
        }
            urlString=storeString;
            break;
        case kQuerycourseDocumentManageDownload:{
            storeString=[NSString stringWithFormat:@"http://%@/FileShare/fileDown.action?fileid=%@&upId=%@",kdocumentMange_IP,[requestInfo objectForKey:@"fileid"],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
        }
            urlString=storeString;
            break;
        case kQuerynews:{
            if ([domain isEqualToString:@"111.11.28.30"]) {
                storeString=[NSString stringWithFormat:@"http://%@:8087/newszq/phoneInterface.action?cmd=querycourselist&pageNumber=%@&pageCount=%@",@"111.11.28.30",[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
                

            }else if ([domain isEqualToString:@"111.11.28.41"]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/newszq/phoneInterface.action?cmd=querycourselist&pageNumber=%@&pageCount=%@",@"111.11.28.9",[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }
                   }
            urlString=storeString;
            break;
        case kQuerynewsDetail:{
            NSString* str = [NSString stringWithFormat:@"%@",domain];
            if([str isEqualToString:@"111.11.28.41"]){
                str = @"111.11.28.9";
            }
             if ([domain isEqualToString:kQIXINSERVER_IP]||[domain isEqualToString:kTESTSERVERONLY_IP]) {
            storeString=[NSString stringWithFormat:@"http://%@:8087/newszq/phoneInterface.action?cmd=querycoursedetail&courseid=%@",str,[requestInfo objectForKey:@"courseid"]];
             }
        }
            urlString=storeString;
            break;
            
        case kQuerySecurityTips:{
            if ([domain isEqualToString:@"111.11.28.30"]) {
                storeString=[NSString stringWithFormat:@"http://%@:8087/saferzq/phoneInterface.action?cmd=querycourselist&pageNumber=%@&pageCount=%@",@"111.11.28.30",[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
                
                
            }else if ([domain isEqualToString:@"111.11.28.41"]){
                storeString=[NSString stringWithFormat:@"http://%@:8087/saferzq/phoneInterface.action?cmd=querycourselist&pageNumber=%@&pageCount=%@",@"111.11.28.9",[requestInfo objectForKey:@"pageNumber"],[requestInfo objectForKey:@"pageCount"]];
            }
        }
            urlString=storeString;
            break;
        case kQuerySecurityTipsDetail:{
            NSString* str = [NSString stringWithFormat:@"%@",domain];
            if([str isEqualToString:@"111.11.28.41"]){
                str = @"111.11.28.9";
            }
            if ([domain isEqualToString:kQIXINSERVER_IP]||[domain isEqualToString:kTESTSERVERONLY_IP]) {
                storeString=[NSString stringWithFormat:@"http://%@:8087/saferzq/phoneInterface.action?cmd=querycoursedetail&courseid=%@",str,[requestInfo objectForKey:@"courseid"]];
            }
        }
            urlString=storeString;
            break;


		default:
			break;
        }
            
            if (![self checkNetwork:nil])
            {
                NSData *data = [[SDDataCache sharedDataCache] dataFromKey:storeString];
                if(data)
                {
                    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    [target performSelector:NSSelectorFromString(successSelector) withObject:dic];
                }
                else
                {
                    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    [target performSelector:NSSelectorFromString(failedSelector) withObject:dic];
                }
                return;
            }
            
            STFormDataRequest *request = [STFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
            request.requestFlagMark = [self getTimeStamp];
            [httpRequests addObject:request];
            request.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:type] forKey:@"type"];
            

            if (type == Http_UploadChatBigImage || type == Http_UploadChatSmallImage)
            {
                [request setRequestMethod:@"POST"];
                
                NSMutableData *imageFile = [requestInfo objectForKey:@"image"];
                NSString *imageName = nil;
                if (type == Http_UploadChatBigImage) {
                    imageName = [requestInfo objectForKey:@"big"];
                }
                else if(type == Http_UploadChatSmallImage)
                {
                    imageName = [requestInfo objectForKey:@"small"];
                }
                
                //添加请求内容
                [request setData:imageFile withFileName:imageName andContentType:@"/jpg" forKey:@"image"];
                NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
                [headerDic setValue:@"text/html" forKey:@"Accept"];
                request.requestHeaders = headerDic;//存放请求的头信息
                
                NSMutableDictionary *infoDic  = [NSMutableDictionary dictionaryWithDictionary:requestInfo];
                [infoDic setValue:[NSNumber numberWithInt:type]  forKeyPath:@"type"];
                request.userInfo = infoDic;
            }
    /**/
    
           if(type==kQuerycourselist){
               [request setRequestMethod:@"POST"];
               [request addPostValue:[requestInfo objectForKey:@"category"] forKey:@"category"];
               [request addPostValue:[requestInfo objectForKey:@"pageNumber"] forKey:@"pageNumber"];
               [request addPostValue:[requestInfo objectForKey:@"pageCount"] forKey:@"pageCount"];
               [request buildPostBody];
           }
            if (type == kQuerycoursecarsq)
            {
                
                [request setRequestMethod:@"POST"];
                
                [request addPostValue:[requestInfo objectForKey:@"userId"] forKey:@"userId"];
                [request addPostValue:[requestInfo objectForKey:@"department"] forKey:@"department"];
                [request addPostValue:[requestInfo objectForKey:@"userName"] forKey:@"userName"];
                [request addPostValue:[requestInfo objectForKey:@"peopleNum"] forKey:@"peopleNum"];
                [request addPostValue:[requestInfo objectForKey:@"carType"] forKey:@"carType"];
                [request addPostValue:[requestInfo objectForKey:@"userTime"] forKey:@"userTime"];
                [request addPostValue:[requestInfo objectForKey:@"drivePlace"] forKey:@"drivePlace"];
                [request addPostValue:[requestInfo objectForKey:@"returnTime"] forKey:@"returnTime"];
                [request addPostValue:[requestInfo objectForKey:@"returnPlace"] forKey:@"returnPlace"];
                [request addPostValue:[requestInfo objectForKey:@"reason"] forKey:@"reason"];
                [request addPostValue:[requestInfo objectForKey:@"require"] forKey:@"require"];
                [request addPostValue:[requestInfo objectForKey:@"leader"] forKey:@"leader"];
                [request buildPostBody];
            }
            
            [request setUseCookiePersistence:NO];
            NSData *oldData = [[SDDataCache sharedDataCache] dataFromKey:@"Cookie"];
            NSMutableArray *cookie = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
            request.requestCookies = cookie;
            [request setShouldAttemptPersistentConnection:NO];
            [request setTimeOutSeconds:60];
            if (type == KQueryUserCalendarRight) {
                [request setTimeOutSeconds:10];
            }
            [request setDelegate:self];
            [request setDownloadProgressDelegate:self];
            request.showAccurateProgress = YES;
            
            NSLog(@"%@",cookie);
            //	}
            if (target)
            {
                NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:target, @"delegate", successSelector, @"onsuccess", failedSelector, @"onfailed", nil];
                [requests setObject:tempDic forKey:request.requestFlagMark];
            }
            [request setDelegate:self];
            
            //异步
            [request startAsynchronous];
}
- (NSString *)getTimeStamp
{
    return [NSString createUUID];
}

- (NSUInteger)retainCount{
    return NSUIntegerMax;
}

- (oneway void)release{
}

- (id)retain{
    return _sharedInst;
}

- (id)autorelease{
    return _sharedInst;
}

- (void) restore{
    
}

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


-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [internetReach release];
    [requests release];
    [httpRequests release];
    [super dealloc];
}

@end

