//
//  FrameBaseViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-3-17.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "FrameBaseViewController.h"
#import "HttpReachabilityHelper.h"
#import  "NetworkSetViewController.h"

#define kOnConnecting       @"kOnConnecting"
@interface FrameBaseViewController ()

@end

@implementation FrameBaseViewController
@synthesize improvePersonalDataBt = _improvePersonalDataBt;
@synthesize iosChangeFloat = _iosChangeFloat;
@synthesize newsPersonalDataBt=_newsPersonalDataBt;
@synthesize showTimer=_showTimer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (iOSVersion < 7.0) {
            self.iosChangeFloat = 0;
        }else{
            self.iosChangeFloat = 20.f;
        }
        [self initReLoginBt];
        [self initNewsBt];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(disConnectNotifacation:)
                                                     name:kDisconnect
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reConnectNotifacation:)
                                                     name:kConnect
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reOnConnectNotifacation:)
                                                     name:kOnConnecting
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newsShowNotifacation:)
                                                     name:@"newsLableShow"
                                                   object:nil];
        

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(removeNewsBtn:)
                                                     name:@"removeNewsBtn"
                                                   object:nil];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disConnectNotifacation:(NSNotification *)notification
{
    [self addReloginBt];
}

- (void)reConnectNotifacation:(NSNotification *)notification
{
    [self removeReloginBt];
}
- (void)reOnConnectNotifacation:(NSNotification *)notification
{
//    _improvePersonalDataBt.enabled = NO;
//    [_improvePersonalDataBt setTitle:@"连接断开,点击重新登录" forState:UIControlStateNormal];
}
//有新消息的时候调用
-(void)newsShowNotifacation:(NSNotification *)notification{
     NSDictionary *dic = [notification object];
    [self addNewsBt:dic];
}
//点击新消息提示的话就移除掉
-(void)onNewsBtnTap{
    [_showTimer invalidate];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeNewsBtn" object:nil];
    }
-(void)removeNewsBtn:(NSNotification *)notification{
    [self removeNewsBt];

}
#pragma mark-消息提示
- (void)initNewsBt
{
    UIImage *improveImage = UIImageWithName(@"improveData.png");
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:improveImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(onNewsBtnTap) forControlEvents:UIControlEventTouchUpInside];
    aButton.frame = CGRectMake(0, _iosChangeFloat + kNavHeight, kScreen_Width, improveImage.size.height/2);
    self.newsPersonalDataBt = aButton;
    //
    NSString *improvStr = @"你有新消息";
    [aButton setTitle:improvStr forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    aButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    aButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    aButton.titleEdgeInsets =UIEdgeInsetsMake(3, 30, 0, 0);
}

- (void)addNewsBt:(NSDictionary*)dicc
{
  
    NSString *improvStr = nil;
    improvStr=[dicc objectForKey:@"zhi"];
        [_newsPersonalDataBt setTitle:improvStr forState:UIControlStateNormal];
    if (_newsPersonalDataBt.superview)
    {
        return;
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus]) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.view addSubview:_newsPersonalDataBt];
                         }completion:^(BOOL bl){
                         }];
    }
   _showTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(onNewsBtnTap) userInfo:nil repeats:NO];
   
}
- (void)removeNewsBt
{
    if (_newsPersonalDataBt.superview) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [_newsPersonalDataBt removeFromSuperview];
                             
                         }completion:^(BOOL bl){
                         }];
    }
}


#pragma mark- 当连接断开或掉线时显示
- (void)initReLoginBt
{
    UIImage *improveImage = UIImageWithName(@"improveData.png");
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:improveImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(onReLoginBtnTap) forControlEvents:UIControlEventTouchUpInside];
    aButton.frame = CGRectMake(0, _iosChangeFloat + kNavHeight, kScreen_Width, improveImage.size.height/2);
    self.improvePersonalDataBt = aButton;
    //
    NSString *improvStr = @"连接断开,点击重新登录";
    [aButton setTitle:improvStr forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    aButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    aButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    aButton.titleEdgeInsets =UIEdgeInsetsMake(3, 30, 0, 0);
}
- (void)addReloginBt
{
    //网络处于可用的状态
    NSString *improvStr = nil;
    if ([[HttpReachabilityHelper sharedService] checkNetwork:nil])
    {
        improvStr = @"连接断开,点击重新登录";
        [_improvePersonalDataBt removeTarget:self action:@selector(setNetWorkWarnning) forControlEvents:UIControlEventTouchUpInside];
        [_improvePersonalDataBt addTarget:self action:@selector(onReLoginBtnTap) forControlEvents:UIControlEventTouchUpInside];

    }
    //网络处于不可用的状态
    else
    {
        improvStr = @"网络不给力, 请检查网络";
        [_improvePersonalDataBt removeTarget:self action:@selector(onReLoginBtnTap) forControlEvents:UIControlEventTouchUpInside];
        [_improvePersonalDataBt addTarget:self action:@selector(setNetWorkWarnning) forControlEvents:UIControlEventTouchUpInside];
    }
    [_improvePersonalDataBt setTitle:improvStr forState:UIControlStateNormal];


     if (_improvePersonalDataBt.superview)
     {
         return;
     }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus]) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.view addSubview:_improvePersonalDataBt];
                         }completion:^(BOOL bl){
                         }];
    }
}
- (void)removeReloginBt
{
    if (_improvePersonalDataBt.superview) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [_improvePersonalDataBt removeFromSuperview];

                         }completion:^(BOOL bl){
                         }];
    }
}

- (void)onReLoginBtnTap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kOnConnecting object:nil];
    //    if ([[YiXinScoketHelper sharedService] isConnect] != HasConnected) {
//        [_improvePersonalDataBt setTitle:@"连接断开,点击重新登录" forState:UIControlStateNormal];
//        return;
//    }
    
    NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:User_Name];
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

- (void)setNetWorkWarnning
{
    NetworkSetViewController *network = [[NetworkSetViewController alloc] initWithNibName:nil bundle:nil];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:network animated:YES];
    [network release];
}



@end
