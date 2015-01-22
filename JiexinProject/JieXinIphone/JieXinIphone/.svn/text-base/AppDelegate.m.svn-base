
//
//  AppDelegate.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-18.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "STFormDataRequest.h"
#import "GDataDefines.h"
#import "LinkDateCenter.h"
#import "SynUserInfo.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "HttpReachabilityHelper.h"
#define kDeviceTokenDefault         [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId],@"deviceToken"]
@implementation AppDelegate
{
    BOOL _isNotHint;
}

- (void)dealloc
{
    [_window release];
    [_rootNavigation release];
    [_mainTabBarVC release];
    [super dealloc];
}

+ (AppDelegate *)shareDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.sameUserName=YES;
    self.sameIP = YES;
    self.isLogin=NO;
    self.newsModelArray = [[NSMutableArray alloc]init];
    
    _isNotHint = [[NSUserDefaults standardUserDefaults] boolForKey:@"isnothint"];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [HttpReachabilityHelper  sharedService];
    NSLog(@"%@",NSHomeDirectory());
    application.applicationIconBadgeNumber = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置导航条
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    application.statusBarHidden = NO;
    
    [self initDefaultDatas];

//    //测试
//    [[LinkDateCenter sharedCenter] getAllDepartments];
//    [[LinkDateCenter sharedCenter] getRootDepartment];
      //[[LinkDateCenter sharedCenter] getAllSubUsersCountWithDepartmentId:@"351"];
//    [[LinkDateCenter sharedCenter] getSubUsersWithDepartmentId:@"385"];
    // Override point for customization after application launch.
    [self layoutMainView:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initDefaultDatas
{
    self.nowChatUserId = -1;
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kIsExecuteAutoLogin];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kNOFirstEnterApp])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsPalySound];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain])
    {
        [[NSUserDefaults standardUserDefaults] setValue:kSERVER_IP forKey:Main_Domain];
    }
    
    //以后就不是第一次了
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kNOFirstEnterApp];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)layoutMainView:(id)sender
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    if(self.rootNavigation)
    {
        [self.rootNavigation.view removeFromSuperview];
        self.rootNavigation = nil;
    }
    UINavigationController *navigation = [[UINavigationController alloc] init];
	self.rootNavigation = navigation;
	self.rootNavigation.navigationBarHidden = YES;
	[navigation release];
    
    MainTabBarController *tabbar = [[MainTabBarController alloc] init];
	self.mainTabBarVC = tabbar;
    [tabbar release];
    //先加载模块 然后登录 登录成功发送通知加载数据
    [self.mainTabBarVC loadMenuItems];
    [_rootNavigation popToRootViewControllerAnimated:NO];
    NSArray *controllers2 = [NSArray arrayWithObject:_mainTabBarVC];
    _rootNavigation.viewControllers = controllers2;
    [self.window setRootViewController:_rootNavigation];
    [self.window makeKeyAndVisible];
    [self performSelector:@selector(showWelcomeOrLogin)];
}

- (void)showWelcomeOrLogin
{
    BOOL isHasShowWelcome = [[NSUserDefaults standardUserDefaults] boolForKey:kIsHasShowWelcome];
    if (!isHasShowWelcome) {
        [_mainTabBarVC showWelcomeView];
    }
    else
    {
        [_mainTabBarVC doLogin];
    }

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //关闭连接
    [[YiXinScoketHelper sharedService] connectClose];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
    //打开连接
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus])
    {
        NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus];
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:User_Key];
        NSString *clientDbVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalVersion];
        if(!clientDbVersion)
        {
            clientDbVersion = @"0";
        }
        NSString *userPsw =  [[[NSUserDefaults standardUserDefaults] objectForKey:Password_Key] md5];
        NSDictionary *logDic = [NSDictionary dictionaryWithObjectsAndKeys:status,@"status",username,@"username",clientDbVersion,@"clientDbVersion",userPsw,@"userPsw", nil];
        [[YiXinScoketHelper sharedService] setLoginDatas:logDic];
        [[YiXinScoketHelper sharedService] connect];

    }
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 设置选中第几个
- (void)setSelectIndex:(int)index
{
    [self.mainTabBarVC.customTabbarView setSelectedIndex:0 animated:NO];
}


#pragma mark 推送
//请求获取动态令牌
- (void)registerForRemoteNotification:(id)sender
{
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound
     | UIRemoteNotificationTypeAlert];
}

// 请求令牌错误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    NSLog(@"获取devicetoken出错:%@",str);
}

//得到令牌
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *tokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *finalString = [tokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@==%@",deviceToken,finalString);
//    [ShowAlertView showAlertViewStr:finalString];

//    NSString *oldDevStr = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenDefault];
    //[self sendDeviceToken:finalString];
    //[self updateDeviceToken:finalString withOldToken:oldDevStr];
    //return;
    //第一次发
//    if(![oldDevStr length])
//    {
        [self sendDeviceToken:finalString];
//    }
//    //更新
//    else if (![finalString isEqualToString:oldDevStr])
//    {
//        NSLog(@"更换新的DeviceToken");
//        [self updateDeviceToken:finalString withOldToken:oldDevStr];
//    }
}


#pragma mark 发送Devicetoken
- (void)sendDeviceToken:(NSString *)deviceToken
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kSessionId];
    
    if(userID && deviceToken)
    {
        NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
        NSString *urlString = [NSString stringWithFormat:@"http://%@/webimadmin/api/ios/device/",domain];
        STFormDataRequest *request = [STFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:deviceToken,@"devicetoken", nil];
        [request setRequestMethod:@"POST"];
        [request setPostValue:userID forKey:@"userid"];
        [request setPostValue:deviceToken forKey:@"deviceid"];
        [request setTimeOutSeconds:60.0f];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(sendTokenFinished:)];
        [request setDidFailSelector:@selector(sendTokenFailed:)];
        [request setShouldAttemptPersistentConnection:NO];
        [request addRequestHeader:@"Accept" value:@"text/html"];
        [request startAsynchronous];
    }
}

- (void)sendTokenFinished:(STFormDataRequest *)request
{
    NSString *resultString = [request responseString];
    NSLog(@"resultString %@",resultString);
    NSDictionary *resultDic = [resultString JSONValue];
    NSLog(@"%@",resultDic);
    //成功
    if([[resultDic objectForKey:@"status"] intValue] ==1)
    {
        [[NSUserDefaults standardUserDefaults] setValue:[request.userInfo objectForKey:@"devicetoken"] forKey:kDeviceTokenDefault];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

//    NSError *error = nil;
//    GDataXMLDocument *document      = [[[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:&error] autorelease];
//    GDataXMLElement *rootElement = [document rootElement];
//    NSString *str = [[[rootElement elementsForName:@"Message"] objectAtIndex:0] stringValue];
//    if([str isEqualToString:@"1"])
//    {
//        
//        //[[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"devicetoken"];
//        //[[NSUserDefaults standardUserDefaults] synchronize];
//        
//        
//    }
//    else
//    {
//        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        //        [alertView show];
//        //        [alertView release];
//        
//    }
}
- (void)sendTokenFailed:(STFormDataRequest *)request
{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kDeviceTokenDefault];
    NSString *xmlString = [request responseString];
    NSLog(@"xmlString %@",xmlString);
}


#pragma mark 更新Devicetoken
- (void)updateDeviceToken:(NSString *)deviceToken withOldToken:(NSString *)oldToken
{
//    deviceToken= [NSString stringWithFormat:@"2b4bd75979d45f6853c35c83b2a2d704835592ebc1588e01860a9203c0519a4e"];
//    oldToken = [NSString stringWithFormat:@"234bd75979d45f6853c35c83b2a2d704835592ebc1588e01860a9203c0519a4e"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kMain_DomainChanged];//域名未更改
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:kSessionId];
    if(userID && deviceToken)
    {
        NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:Main_Domain];
        NSString *urlString = [NSString stringWithFormat:@"http://%@/webimadmin/api/ios/device/",domain];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:deviceToken,@"newtoken",oldToken,@"oldtoken", nil];
        [request setRequestMethod:@"PUT"];
//        [request setPostValue:userID forKey:@"userid"];
//        [request setPostValue:deviceToken forKey:@"newdeviceid"];
//        [request setPostValue:oldToken forKey:@"olddeviceid"];
        [request setTimeOutSeconds:60.0f];
        [request setDelegate:self];
        [request setShouldAttemptPersistentConnection:NO];
        [request setDidFinishSelector:@selector(updateTokenFinished:)];
        [request setDidFailSelector:@selector(updateTokenFailed:)];
        [request addRequestHeader:@"Accept" value:@"text/html"];
        
        NSString *params = [NSString stringWithFormat:@"userid=%@&newdeviceid=%@&olddeviceid=%@",userID,deviceToken,oldToken];
        [request appendPostData:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request startAsynchronous];
    }
}

- (void)updateTokenFinished:(ASIFormDataRequest *)request
{
    NSString *resultString = [request responseString];
    NSLog(@"resultString %@",resultString);

    NSDictionary *resultDic = [resultString JSONValue];
    //成功
    if([[resultDic objectForKey:@"status"] intValue] ==1)
    {
        [[NSUserDefaults standardUserDefaults] setValue:[request.userInfo objectForKey:@"newtoken"] forKey:kDeviceTokenDefault];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}

- (void)updateTokenFailed:(ASIFormDataRequest *)request
{
    [[NSUserDefaults standardUserDefaults] setValue:[request.userInfo objectForKey:@"oldtoken"] forKey:kDeviceTokenDefault];
    NSString *xmlString = [request responseString];
    NSLog(@"xmlString %@",xmlString);

}


@end
