
//
//  BaseTabBarController.m
//  WoAiPhoneApp
//
//  Created by 雷克 on 10-11-19.
//  Copyright 2010 Sharppoint Group Ltd. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainStaticValue.h"
#import "ChatViewController.h"
#import "LinkViewController.h"
#import "UIViewCtrl_More.h"
#import "UIViewCtrl_News.h"
#import "SynUserInfo.h"
#import "SynUserIcon.h"
#import "VersionController.h"
#import "ConstantValue.h"
#import "CardApplyViewController.h"

//#import "DeeperOAForIphoneAppDelegate.h"

@implementation MainTabBarController
{
    BOOL _isRequest;
    BOOL _isMyRequestGroupList;
}
@synthesize customTabbarView;
@synthesize timer;
@synthesize currentBtn;
@synthesize leftIndicator,rightIndicator;
@synthesize btns;
@synthesize indicatorDic;

//@synthesize loginView;

- (id)init
{
    self = [super init];
    if(self)
    {
        _isRequest = NO;
        _isMyRequestGroupList = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doLogOut:)
                                                     name:NOTIFICATION_LOGOUT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataNotification:)
                                                     name:kLoginFinishData object:nil];
        //获取群组列表
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupListDataNotification:)
                                                     name:kGroupListData
                                                   object:nil];


        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOfflineMsg:) name:kPushUserStatus object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewBadgeValue:) name:SHOW_BADGEVALUE object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(receiveKickOffLineNsnotification:)
//                                                     name:kKickedOffline  object:nil];
        self.indicatorDic = [NSMutableDictionary dictionaryWithCapacity:0];
        
    }
    return self;
}

- (void)showNewBadgeValue:(NSNotification *)notification
{
    NSDictionary *info = [notification object];
    int index = [[info objectForKey:@"Index"] intValue];
    int count = [[info objectForKey:@"Count"] intValue];
    
    if(index < [self.btns count])
    {
        UIButton *btnItem = [self.btns objectAtIndex:index];
        if(btnItem)
        {
            UILabel *bvIv = (UILabel *)[btnItem viewWithTag:120];
            if(bvIv)
            {
                [bvIv removeFromSuperview];
            }
            
            if(count != 0)
            {
                UILabel *badgeValue =  [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(btnItem.frame)-20, 3, 10, 10)];
                badgeValue.layer.cornerRadius = 5;
                badgeValue.tag = 120;
                badgeValue.layer.masksToBounds = YES;
                [badgeValue setBackgroundColor:[UIColor redColor]];
                [btnItem addSubview:badgeValue];
                [badgeValue release];
            }
        }
    }

}

- (void)showBadgeValue:(NSNotification *)notification
{
    NSDictionary *info = [notification object];
    int index = [[info objectForKey:@"Index"] intValue];
    int count = [[info objectForKey:@"Count"] intValue];
    [indicatorDic setObject:[info objectForKey:@"Count"] forKey:[info objectForKey:@"Index"]];
    
    if(index < [self.btns count])
    {
        UIButton *btnItem = [self.btns objectAtIndex:index];
        if(btnItem)
        {
            UIImageView *bvIv = (UIImageView *)[btnItem viewWithTag:120];
            if(bvIv)
            {
                [bvIv removeFromSuperview];
            }
            
            if(count != 0)
            {
                UIImage *bvImage = UIImageGetImageFromName(@"iphone-tishi.png");
                bvIv = [[[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 25, 25)] autorelease];
                bvIv.tag = 120;
                bvIv.image = bvImage;
                
                UILabel *badgeValue =  [[[UILabel alloc] initWithFrame:bvIv.bounds] autorelease];
                [badgeValue setBackgroundColor:[UIColor clearColor]];
                [badgeValue setTextColor:[UIColor whiteColor]];
                [badgeValue setFont:[UIFont boldSystemFontOfSize:11.0f]];
                [badgeValue setTextAlignment:NSTextAlignmentCenter];
                [badgeValue setText:[NSString stringWithFormat:@"%d",count]];
                [bvIv addSubview:badgeValue];
                [btnItem addSubview:bvIv];
            }
        }
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_BADGEVALUEOnHomeView object:self.indicatorDic];
}

- (void)makeTabBarHidden:(BOOL)hide 
{
	// Custom code to hide TabBar
	if([self.view.subviews count] < 2) 
	{
		return;
	}
	
	UIView *contentView;
	if([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) 
	{
		contentView = [self.view.subviews objectAtIndex:1];
	} 
	else 
	{
		contentView = [self.view.subviews objectAtIndex:0];
	}
	//NSLog(@"%@,%@",NSStringFromCGRect(_mainTabBarVC.view.bounds),NSStringFromCGRect(contentView.bounds));
	if(hide) 
	{
		contentView.frame = self.view.bounds;
	}
	else 
	{
		contentView.frame = CGRectMake(self.view.bounds.origin.x,
									   self.view.bounds.origin.y,
									   self.view.bounds.size.width,
									   self.view.bounds.size.height - self.tabBar.frame.size.height);
	}
//
	self.tabBar.hidden = hide;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
  
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callOutCustomTabbar:) name:CALLOUT_CUSTOM_TABBAR object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideCustomTabbar:) name:HIDE_CUSTOM_TABBAR object:nil];
    //李军，返回第一页面的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goBackonebtn:)
                                                 name:@"goBackonebtn"
                                               object:nil];
	if(customTabbarView)
	{
		[self.customTabbarView removeFromSuperview];
		self.customTabbarView = nil;
	}
    if(IOSVersion <7.0)
    {
        [self makeTabBarHidden:YES];
    }
    
    
//    NSMutableArray *menuArray = [NSMutableArray array];
//    for(NSDictionary *dic in menuIndexs)
//    {
//        NSString *title = [dic objectForKey:@"Name"];
//        NSString *testImageName = [NSString stringWithFormat:@"%@-01.png",title];
//        UIImage *testImage = UIImageGetImageFromName(testImageName);
//        
//        NSString *imageNormal = nil;
//        NSString *imageSelected = nil;
//        NSDictionary *item = nil;
//        
//        if(testImage)
//        {
//            imageNormal = [NSString stringWithFormat:@"%@-01.png",title];
//            imageSelected = [NSString stringWithFormat:@"%@-02.png",title];
//            item = [NSDictionary dictionaryWithObjectsAndKeys:imageNormal,@"Nomal",imageSelected,@"Selected",title,@"Title", nil];
//        }
//        else
//        {
//            imageNormal = [NSString stringWithFormat:@"1-待办事宜-01.png"];
//            imageSelected = [NSString stringWithFormat:@"1-待办事宜-02.png"];
//            item = [NSDictionary dictionaryWithObjectsAndKeys:imageNormal,@"Nomal",imageSelected,@"Selected",title,@"Title", nil];        
//        }
//        [menuArray addObject:item];
//    }
    //第二套
    /*NSDictionary *item2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2-通知公告-01.png",@"Nomal",@"2-通知公告-02.png",@"Selected",@"通知公告",@"Title", nil];
    [menuArray addObject:item2];
    
    NSDictionary *item3 = [NSDictionary dictionaryWithObjectsAndKeys:@"3-日程安排-01.png",@"Nomal",@"3-日程安排-02.png",@"Selected",@"日程安排",@"Title", nil];    
    [menuArray addObject:item3];
    
    NSDictionary *item4 = [NSDictionary dictionaryWithObjectsAndKeys:@"4-会议资料-01.png",@"Nomal",@"4-会议资料-02.png",@"Selected",@"会议资料",@"Title", nil];
    [menuArray addObject:item4];
     */
    /*
    NSDictionary *item1 = [NSDictionary dictionaryWithObjectsAndKeys:@"menu-6.png",@"Nomal",@"menu-6_1.png",@"Selected",@"信息门户",@"Title", nil];
    [menuArray addObject:item1];
    
    NSDictionary *item4 = [NSDictionary dictionaryWithObjectsAndKeys:@"menu-1.png",@"Nomal",@"menu-1_1.png",@"Selected",@"OA系统",@"Title", nil];
    [menuArray addObject:item4];
    
    NSDictionary *item5 = [NSDictionary dictionaryWithObjectsAndKeys:@"menu-2.png",@"Nomal",@"menu-2_1.png",@"Selected",@"合同管理",@"Title", nil];
    [menuArray addObject:item5];
    
    NSDictionary *item3 = [NSDictionary dictionaryWithObjectsAndKeys:@"menu-4.png",@"Nomal",@"menu-4_1.png",@"Selected",@"石化报",@"Title", nil];
    [menuArray addObject:item3];
    
    NSDictionary *item2 = [NSDictionary dictionaryWithObjectsAndKeys:@"menu-3.png",@"Nomal",@"menu-3_1.png",@"Selected",@"生产经营",@"Title", nil];
    [menuArray addObject:item2];
        
    NSDictionary *item6 = [NSDictionary dictionaryWithObjectsAndKeys:@"menu-5.png",@"Nomal",@"menu-5_1.png",@"Selected",@"设置",@"Title", nil];
    [menuArray addObject:item6];
    
	[self settingCustomTabbar:menuArray];*/
}

//点注销后返回第一页面，并删除注销按钮。李军
-(void)goBackonebtn:(NSNotification *)notification
{
    self.selectedIndex = 0;
    if(currentBtn)
	{
		currentBtn.selected = NO;
	}
    
	self.currentBtn = btn1;
	self.currentBtn.selected = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removelogoutButton" object:nil];
}

- (void)loadMenuItems
{
    NSMutableArray *controllers = [NSMutableArray array];


    NSString *parh = [[NSBundle mainBundle] pathForResource:@"STTabBarSetting" ofType:@"plist"];
    NSMutableDictionary *settingDic = [[NSMutableDictionary dictionaryWithContentsOfFile:parh]objectForKey:@"STTabBarSetting"];
    NSArray *items = [settingDic objectForKey:@"Items"];
    
    for(NSDictionary *aItem in items)
    {
        NSString *type = [aItem objectForKey:@"Type"];
        NSString *titleString = [aItem objectForKey:@"Title"];
        //聊天
        if([type isEqualToString:@"Chat"])
        {
            ChatViewController *chatVC = [[[ChatViewController alloc]initWithNibName:nil bundle:nil] autorelease];
            chatVC.titleStr = titleString;
            UINavigationController *chatNavVC = [[[UINavigationController alloc]initWithRootViewController:chatVC] autorelease];
            chatNavVC.navigationBar.hidden = YES;
            [controllers addObject:chatNavVC];
        }
        //联系
        else if ([type isEqualToString:@"Link"])
        {
            LinkViewController *linkVC = [[[LinkViewController alloc]initWithNibName:nil bundle:nil] autorelease];
            linkVC.titleStr = titleString;
            UINavigationController *linkNavVC = [[[UINavigationController alloc]initWithRootViewController:linkVC] autorelease];
            linkNavVC.navigationBar.hidden = YES;
            [controllers addObject:linkNavVC];
        }
        //服务
        else if ([type isEqualToString:@"News"])
        {
            //            NewsViewController *newsVC = [[NewsViewController alloc]initWithNibName:nil bundle:nil];
            //            newsVC.titleStr = titleString;
        //            UINavigationController *newsNavVC = [[[UINavigationController alloc]initWithRootViewController:newsVC] autorelease];
        //            newsNavVC.navigationBar.hidden = YES;
            //            [controllers addObject:newsNavVC];
            
            UIViewCtrl_News *newVC = [[[UIViewCtrl_News alloc] initWithNibName:@"UIViewCtrl_News" bundle:nil] autorelease];
            newVC.index = [items indexOfObject:aItem];
            [controllers addObject:newVC];
            
            
        }
        //更多
        else if ([type isEqualToString:@"More"])
        {
            //            MoreViewController *moreVC = [[MoreViewController alloc]initWithNibName:nil bundle:nil];
            //            moreVC.titleStr = titleString;
            //            UINavigationController *moreNavVC = [[[UINavigationController alloc]initWithRootViewController:moreVC] autorelease];
            //            moreNavVC.navigationBar.hidden = YES;
            //            [controllers addObject:moreNavVC];
            
            UIViewCtrl_More *moreVC = [[[UIViewCtrl_More alloc] initWithNibName:@"UIViewCtrl_More" bundle:nil] autorelease];
            [controllers addObject:moreVC];
        }
        
    }
    self.viewControllers = controllers;

    NSString *backgroundImage = [settingDic objectForKey:@"Background"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundImage]];
    
    if(customTabbarView)
	{
		[self.customTabbarView removeFromSuperview];
		self.customTabbarView = nil;
	}
    NSMutableArray *menuArray = [NSMutableArray array];
    for(NSDictionary *aItem in [settingDic objectForKey:@"Items"])
    {
        NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:[aItem objectForKey:@"TabBarNormal"],@"Nomal",[aItem objectForKey:@"TabBarSelected"],@"Selected",[aItem objectForKey:@"Title"],@"Title", [aItem objectForKey:@"HomeNormal"], @"icon", nil];    
        [menuArray addObject:item];
    }

    
    self.btns = [NSMutableArray array];
    if(self.customTabbarView)
    {
        [self.customTabbarView removeFromSuperview];
        self.customTabbarView = nil;
    }
    
    
    STTabBarView *tabbar = [[STTabBarView alloc] initWithFrame:CGRectMake(0, kScreen_Height-49, kScreen_Width, 49) withContent:menuArray homeItemDic:nil];
    tabbar.delegate = self;
    [tabbar setSelectedIndex:0 animated:NO];
    self.customTabbarView = tabbar;
    
        //Raik add
//    tabbar.backgroundColor = [UIColor whiteColor];
    
    self.btns = [NSMutableArray arrayWithArray:[tabbar getItemArray]];
    [self.view addSubview:self.customTabbarView];
    [self.view bringSubviewToFront:self.customTabbarView];
    self.customTabbarView.clipsToBounds = NO;
    
    UIImageView *menuImageView = [[UIImageView alloc] initWithFrame:tabbar.frame];
    menuImageView.image = [UIImage imageNamed:@"menu_bg.png"];
    [self.view insertSubview:menuImageView belowSubview:self.customTabbarView];
    [menuImageView release];

//    [tabbar performHomeButtonTapped];
    [tabbar release];
    self.tabBar.hidden = YES;
    
}
- (void)doLogOut:(NSNotification *)notification
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    if(self.loginView)
//    {
//        [self.loginView removeFromSuperview];
//        self.loginView = nil;
//    }
    
    [self offLineStatus];
    [[ASIHTTPRequest sharedQueue] cancelAllOperations];
    
     float iosChangeFloat = 20.0f;
     if (iOSVersion < 7.0) {
     iosChangeFloat = 20;
     }
     
     LoginView *aLoginView = [[LoginView alloc] initWithFrame:CGRectMake(0, iosChangeFloat, kScreen_Width, kScreen_Height-20)];
     self.loginView = aLoginView;
     _loginView.delegate = self;
     [self.view addSubview:_loginView];
     [aLoginView release];
}

- (void)offLineStatus
{
    /*
     <JoyIM>
     <type>req</type>
     <sessionID>5746100</sessionID>
     <cmd>pushUserStatus</cmd>
     <loginType>LOGIN_TYPE</loginType>
     <status>4</status>
     </JoyIM>
     */
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
     NSMutableArray *msg_packet = [NSMutableArray arrayWithObjects:@{@"type":@"req"}, @{@"sessionID":sessionId}, @{@"cmd":@"pushUserStatus"}, @{@"loginType": @"1"}, @{@"status":@"0"},nil];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg_packet]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    _isRequest = YES;
}

//显示欢迎界面
- (void)showWelcomeView
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    if (self.welcome) {
        [self.welcome removeFromSuperview];
        self.welcome = nil;
    }
    WelcomeView *aWelcome = [[WelcomeView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    aWelcome.delegate = self;
    self.welcome = aWelcome;
    [aWelcome release];
    [self.view addSubview:_welcome];
}

- (void)hideWelcomeView
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsHasShowWelcome];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.welcome) {
        [self.welcome removeFromSuperview];
        self.welcome = nil;
    }
    [self doLogin];
}

//加载登录
- (void)doLogin
{
    if(self.loginView)
    {
        [self.loginView removeFromSuperview];
        self.loginView = nil;
    }
    
    //是否是自动登录
    if(![[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus])
    {
        float iosChangeFloat = 20.0f;
        if (iOSVersion < 7.0) {
            iosChangeFloat = 20;
        }
        
        LoginView *aLoginView = [[LoginView alloc] initWithFrame:CGRectMake(0, iosChangeFloat, kScreen_Width, kScreen_Height-20)];
        self.loginView = aLoginView;
        _loginView.delegate = self;
        [self.view addSubview:_loginView];
        [aLoginView release];
    }
    //自动登录
    else
    {

        NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus];
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:User_Key];
        NSString *clientDbVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalVersion];
        if(!clientDbVersion)
        {
            clientDbVersion = @"0";
        }
        NSString *userPsw =  [[[NSUserDefaults standardUserDefaults] objectForKey:Password_Key] md5];
        //    NSString *domain = [NSString stringWithFormat:@"%d",]
        //loginType  1代表iPhone 0 是安卓

        NSDictionary *logDic = [NSDictionary dictionaryWithObjectsAndKeys:status,@"status",username,@"username",clientDbVersion,@"clientDbVersion",userPsw,@"userPsw", nil];
        [[YiXinScoketHelper sharedService] setLoginDatas:logDic];
        [[YiXinScoketHelper sharedService] connect];
    }
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsExecuteAutoLogin];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - loginsuccessfully
- (void)loginSuccessfully:(NSDictionary *)info
{
    [UIView animateWithDuration:0.5f
                     animations:^{
						 _loginView.frame = CGRectMake(0, -_loginView.bounds.size.height, _loginView.bounds.size.width,_loginView.bounds.size.height);
					 }
                     completion:^(BOOL finished){
                         if(finished)
                         {
                             [self.loginView removeFromSuperview];
                             self.loginView = nil;
                         }
					 }];
    
}

#pragma mark - 离线消息返回
- (void)receiveOfflineMsg:(NSNotification *)notification
{
    if (!_isRequest) {
        return;
    }
    [[YiXinScoketHelper sharedService] connectClose];

    _isRequest = NO;
    NSDictionary *infoDic = [notification userInfo];
    NSLog(@"infoDic-->%@",infoDic);
//    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
//    {
//
//        float iosChangeFloat = 20.0f;
//        if (iOSVersion < 7.0) {
//            iosChangeFloat = 20;
//        }
//        
//        LoginView *aLoginView = [[LoginView alloc] initWithFrame:CGRectMake(0, iosChangeFloat, kScreen_Width, kScreen_Height-20)];
//        self.loginView = aLoginView;
//        _loginView.delegate = self;
//        [self.view addSubview:_loginView];
//        [aLoginView release];
//    }
}

#pragma mark - 登录成功，接受该通知方法
- (void)receiveDataNotification:(NSNotification *)notification
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus])
    {
//        [self setSelectedIndex:0];
        [self.customTabbarView setSelectedIndex:0 animated:NO];
    }
    NSDictionary *infoDic = [notification userInfo];
    NSLog(@"infoDic-->%@",infoDic);
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {
        [self setSeriodDiff:[infoDic objectForKey:@"servertime"]];
//        if (![[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] isEqualToString:[infoDic objectForKey:@"sessionID"]]) {
            [[NSUserDefaults standardUserDefaults] setValue:[infoDic objectForKey:@"sessionID"] forKey:kSessionId];
//
//        }
//
        [[NSUserDefaults standardUserDefaults] setValue:[infoDic objectForKey:@"nickName"] forKey:User_NickName];
         NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:User_Name];
        [[NSUserDefaults standardUserDefaults] setValue:[infoDic objectForKey:@"userName"] forKey:User_Name];
        NSString* username1 = [[NSUserDefaults standardUserDefaults] objectForKey:User_Name];
        NSLog(@"username=%@username1=%@",username,username1);
        if(![username isEqualToString:username1]){
            [AppDelegate shareDelegate].sameUserName=NO;
                   }
        [[NSUserDefaults standardUserDefaults] setValue:[infoDic objectForKey:@"departId"] forKey:kDepartId];
        [[NSUserDefaults standardUserDefaults] setValue:[infoDic objectForKey:@"sex"] forKey:kUserSex];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginStatus];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        //下载icon
        NSMutableDictionary *iconDic = [NSMutableDictionary dictionary];
        [iconDic setValue:[infoDic objectForKey:@"enterpriseID"] forKey:kIconEnterpriseID];
        [iconDic setValue:[infoDic objectForKey:@"PicZipVersion"] forKey:kIconUpdateVersion];
        [iconDic setValue:@"/app/HeadPic/" forKey:kIconDownloadURL];
        [iconDic setValue:@"/app/HeadPic/" forKey:kIconUpdateUrl];
        [[SynUserIcon sharedManager] downloadFileWithInfo:iconDic withDelegate:self];
        [[VersionController shareVersionControllerler] detectVersion];

        BOOL isExist = [[SynUserInfo sharedManager] isStoredLocalDB:[[NSUserDefaults standardUserDefaults] objectForKey:kEnterpriseID]];
        NSInteger isDownDb = [[infoDic objectForKey:@"isDownDB"] integerValue];
        NSInteger localIsDownDb = [[[NSUserDefaults standardUserDefaults] objectForKey:kLocalIsDownDb] integerValue];
        BOOL isShouldDownDb = isDownDb >localIsDownDb?YES:NO;
        if (isExist && !isShouldDownDb)
        {
            [self performSelector:@selector(sendPostNotification)];
        }
    
        //下载或者更新数据库：
        NSMutableDictionary *dbDic = [NSMutableDictionary dictionary];
        [dbDic setValue:[infoDic objectForKey:@"enterpriseID"] forKey:kEnterpriseID];
        [dbDic setValue:[infoDic objectForKey:@"dburl"] forKey:kDownloadURL];
        [dbDic setValue:[infoDic objectForKey:@"serverDbVersion"] forKey:kUpdateVersion];
        [dbDic setValue:[infoDic objectForKey:@"dburlDbVersion"] forKey:kDbUrlDbVersion];
        [dbDic setValue:[infoDic objectForKey:@"sqlurl"] forKey:kUpdateUrl];
        [dbDic setValue:[infoDic objectForKey:@"isDownDB"] forKey:@"isDownDB"];
        [[AppDelegate shareDelegate] registerForRemoteNotification:nil];
        [[SynUserInfo sharedManager] downloadFileWithInfo:dbDic withDelegate:self];
        
    }
    else
    {
        [[YiXinScoketHelper sharedService] connectClose];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDisconnect object:nil];
    }
}

- (void)downloadManagerDataDownloadFinished: (SynUserInfo *)downloader
{
    [self sendPostNotification];
}

- (void)sendPostNotification
{
    //登陆成功  请求群组列表
    [self requestGroupList];
    [[NSNotificationCenter defaultCenter] postNotificationName:ModuleDataRequest object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"N_ReloadData"
 object:nil];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"SendRadio" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newsShow" object:nil];

}


#pragma mark - 请求群组列表
- (void)requestGroupList
{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"group"},@{@"grouptype":@"1"}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    _isMyRequestGroupList = YES;
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)receiveGroupListDataNotification:(NSNotification *)notification
{
    if (!_isMyRequestGroupList) {
        return;
    }
    else
    {
        _isMyRequestGroupList = NO;
    }
    NSDictionary *infoDic = [notification userInfo];
    
    if ([[[infoDic objectForKey:@"list"] objectForKey:@"group"] isKindOfClass:[NSDictionary class]])//返回唯一数据
    {
        NSDictionary *groupDic = [[infoDic objectForKey:@"list"] objectForKey:@"group"];
        //查询当前数据库是否存在，不存在插入
        NSMutableArray *groupDBInfo = nil;
        groupDBInfo = [[GroupDataHelper sharedService] getAllGroupid];
        if (![groupDBInfo containsObject:[groupDic objectForKey:@"id"]])
        {
            [self insertGroupToDB:groupDic];
        }
        else
        {
            [self sendRenameGroupNostification:groupDic];
        }
    }
    else   //返回不唯一数据
    {
        NSMutableArray *sourceArr = [[infoDic objectForKey:@"list"] objectForKey:@"group"];
        for (NSMutableDictionary *dic in sourceArr)
        {
            //查询当前数据库是否存在，不存在插入
            NSMutableArray *groupDBInfo = nil;
            groupDBInfo = [[GroupDataHelper sharedService] getAllGroupid];
            if (![groupDBInfo containsObject:[dic objectForKey:@"id"]])
            {
                [self insertGroupToDB:dic];
            }
            else
            {
                [self sendRenameGroupNostification:dic];
            }
        }
    }
}

- (void)sendRenameGroupNostification:(NSDictionary *)infoDic
{
    BOOL isNameChanged = [[GroupDataHelper sharedService] isNameChanged:infoDic];
    if (isNameChanged) {
        [self updateDB:infoDic];
        [[ChatDataHelper sharedService] updateGroupName:[[infoDic objectForKey:@"id"] integerValue] withGroupName:[infoDic objectForKey:@"name"]];
        
        NSDictionary *dic = @{@"groupid": [infoDic objectForKey:@"id"],@"newname":[infoDic objectForKey:@"name"],@"result":@"0"};
        [[NSNotificationCenter defaultCenter] postNotificationName:kRenameGroupName object:nil userInfo:dic];
    }
}

#pragma mark -
#pragma mark operateDB Methods

- (void)insertGroupToDB:(NSDictionary *)dic
{
    NSInteger grouptype = 1;
    if ([[dic objectForKey:@"type"] integerValue]==1)
    {
        grouptype = 2;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (grouptype,groupId,groupName,creatorID,time,num) VALUES (%ld,'%@','%@','%@','%@',%ld)",(long)grouptype,[dic objectForKey:@"id"],[dic objectForKey:@"name"],[dic objectForKey:@"creatorID"],[dic objectForKey:@"time"],(long)[[dic objectForKey:@"num"] integerValue]];
    [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
}

- (void)updateDB:(NSDictionary *)dic
{
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE groupInfoTable SET groupName='%@',time ='%@',num=%ld WHERE  groupId='%@'",[dic objectForKey:@"name"],[dic objectForKey:@"time"],(long)[[dic objectForKey:@"num"] integerValue],[dic objectForKey:@"id"]];
    [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
}




//获取毫秒的时间戳
- (void)setSeriodDiff:(NSString *)date
{
    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"SSS"];
    NSString *  locationString=[dateformatter stringFromDate:[NSDate date]];
    NSLog(@"locationString:%@",locationString);
    //    date = [dateformatter dateFromString:locationString];
    long long int time = ((long long int)[[NSDate date] timeIntervalSince1970])*1000+[locationString intValue];
    [AppDelegate shareDelegate].serverAndLocalDiff = time - [date longLongValue];
}


////接收掉线的通知消息 这时候要调到登录界面
//- (void)receiveKickOffLineNsnotification:(NSNotification *)notification
//{
//    [self doLogOut:nil];
//}


- (void)callOutCustomTabbar:(NSNotification *)notification
{
	//self.customTabbarView.hidden = NO;
	/*
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3];
	customTabbarView.frame = CGRectMake(0, 768-64, 1024, self.tabBar.bounds.size.height);
	[UIView commitAnimations];

	if(self.timer)
	{
		[self.timer invalidate];
		self.timer = nil;
	}
	//self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(hideCustomTabbar:)  userInfo:@"HidesToolBar" repeats:NO];
	//[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	 */
}

- (void)hideCustomTabbar:(id)sender
{
	self.customTabbarView.hidden = YES;
	/*
	if(self.timer)
	{
		[self.timer invalidate];
		self.timer = nil;
	}
	if(customTabbarView.center.y < 768)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.3];
		customTabbarView.frame = CGRectMake(0, 768, 1024, self.tabBar.bounds.size.height);
		[UIView commitAnimations];
	}(*/
}

/*
- (void)doLogin
{
	if(!loginView)
	{
		LoginView *aLoginView = [[LoginView alloc] initWithFrame:CGRectMake(0, -675, 1024, 675)];
		self.loginView = aLoginView;
		loginView.delegate = self;
		[self.view addSubview:loginView];
		[aLoginView release];
	}
	BOOL loginStatus = [[NSUserDefaults standardUserDefaults] boolForKey:LoginStatus];
	if(loginStatus)
	{
		[loginView autoreLogin];
	}
	else
	{
		if(loginView.frame.origin.y < 0)
		{
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:0.5f];
			loginView.frame = CGRectMake(0, 0, 1024, 675);
			[UIView commitAnimations];
		}
	}
}

- (void)loginSuccess:(NSString *)responseString;
{
	[UIView animateWithDuration:1.0f delay:0.0 options:UIViewAnimationCurveEaseOut
					 animations:^{
						 loginView.frame = CGRectMake(0, -675, 1024, 675);
					 } completion:^(BOOL finished){
						if(finished)
						{
							[self.loginView removeFromSuperview];
							self.loginView = nil;
						}
					 }];
}
*/

- (void)choseTabbarItem:(id)sender
{
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"STOP PLAY" object:nil];
//	UIButton *btn = (UIButton *)sender;
////    if (btn.tag == 3) 
////    {
////        return ;
////    }
//	if(currentBtn == btn)
//	{
//		UINavigationController *aNav = [self.viewControllers objectAtIndex:btn.tag];
//		[aNav popToRootViewControllerAnimated:YES];
//		return;
//	}
//
//	if(currentBtn)
//	{
//		currentBtn.selected = NO;
//	}
//
//	self.currentBtn = btn;
//	btn.selected = YES;
//	
//	if(btn)
//	{
////		//全局刷新
////		if(btn.tag == [self.tabBar.items count]-1)
////		{
////			if(timer)
////			{
////				[timer invalidate];
////				self.timer = nil;
////			}
////			SunboxSoftAppDelegate *appDelegate = [SunboxSoftAppDelegate shareDelegate];
////			[appDelegate layoutOAView:nil];
////		}
////		else
////		{
//			self.selectedIndex = btn.tag;	
////		}
//        
//        
//        //当tabbar的item超过5个时，会自动在左上角显示more按钮，这时去掉more
//        self.moreNavigationController.viewControllers = [[[NSArray alloc] initWithObjects:self.moreNavigationController.visibleViewController, nil] autorelease];
//	}
	
}

#pragma mark -
#pragma mark Setting UITabBarController method
- (void)settingTabBarItemWithTitleArray:(NSArray *)titleArray
{
    return;
    
	if(!titleArray || [titleArray count] == 0)
	{
		return;
	}
	
	int i = 0;
	for(UITabBarItem *item in self.tabBar.items)
	{
		NSString *titleString = [titleArray objectAtIndex:i];
		//NSLog(@"%@",titleString);
		UINavigationController *controller = [self.viewControllers objectAtIndex:i];
		controller.topViewController.navigationItem.title = titleString;
		
		item.title = titleString;
		NSString *imageName = [NSString stringWithFormat:@"button%d@2x.png",++i];
		item.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
	}
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(UIInterfaceOrientationPortrait);//(interfaceOrientation == UIInterfaceOrientationLandscapeRight);//(interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
- (NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) shouldAutorotate {
    return NO;
}



- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma STTabBarTouchDelegate
- (void)didTabbarHomeButtonTouched:(id)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_BADGEVALUEOnHomeView object:self.indicatorDic];
    NSLog(@"%@",self.indicatorDic);
}
- (void)didTabbarViewButtonTouched:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"STOP PLAY" object:nil];
    UIControl *btn = (UIControl *)sender;

    if(currentBtn == btn)
	{
		//UINavigationController *aNav = [self.viewControllers objectAtIndex:btn.tag];
		//[aNav popToRootViewControllerAnimated:YES];
		return;
	}

    
    
	if(btn)
	{
        self.currentBtn = btn;
        self.selectedIndex = btn.tag;
        NSLog(@"%d",btn.tag);
        
        self.moreNavigationController.viewControllers = [[[NSArray alloc] initWithObjects:self.moreNavigationController.visibleViewController, nil] autorelease];
        self.moreNavigationController.navigationBarHidden = NO;
//        self.moreNavigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topIMG.png"]];
        [self.moreNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topIMG.png"] forBarMetrics:UIBarMetricsDefault];
	}
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat contentWith = scrollView.contentSize.width;
//    CGFloat contentOffsetx = scrollView.contentOffset.x;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    if(contentOffsetx <= 0)
//    {
//        self.leftIndicator.alpha = 0.0;
//    }
//    else
//    {
//        self.leftIndicator.alpha = 1.0;
//    }
//    if(contentOffsetx >= contentWith - scrollView.bounds.size.width)
//    {
//        self.rightIndicator.alpha = 0.0;
//    }
//    else
//    {
//        self.rightIndicator.alpha = 1.0;
//    }
//    [UIView commitAnimations];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGFloat contentWith = scrollView.contentSize.width;
//    CGFloat contentOffsetx = scrollView.contentOffset.x;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    if(contentOffsetx <= 0)
//    {
//        self.leftIndicator.alpha = 0.0;
//    }
//    else
//    {
//        self.leftIndicator.alpha = 1.0;
//    }
//    if(contentOffsetx >= contentWith - scrollView.bounds.size.width)
//    {
//        self.rightIndicator.alpha = 0.0;
//    }
//    else
//    {
//        self.rightIndicator.alpha = 1.0;
//    }
//    [UIView commitAnimations];
}

- (BOOL)prefersStatusBarHidden
{
    return NO; //返回NO表示要显示，返回YES将hiden
}


- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    self.btns = nil;
    self.welcome = nil;
	[customTabbarView release];
	[currentBtn release];
    [leftIndicator release];
    [rightIndicator release];
    [indicatorDic release];
    [_loginView release];
	if(timer)
	{
		[timer invalidate];
		self.timer = nil;
	}
	[super dealloc];
}


@end
