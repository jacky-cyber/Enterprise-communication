//
//  UIViewCtrl_More.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "NGLABAL_DEFINE.h"
#import "UIViewCtrl_More.h"
#import "UITableViewCell_01.h"
#import "UIViewCtrl_Software_Status.h"
#import "UIViewCtrl_User_Information.h"
#import "UIViewCtrl_Pic_Business_Card.h"
#import "UIViewCtrl_Privacy_Config.h"
#import "UIViewCtrl_Message_Config.h"
#import "UIViewCtrl_Voice_Config.h"
#import "UIViewCtrl_StatusBar_Config.h"
#import "UIViewCtrl_About.h"
#import "UIViewCtrl_User_Report.h"
#import "UIViewCtrl_Software_Help.h"
#import "HttpServiceHelper.h"
#import "SynUserIcon.h"

#define kAppUpdate        @"APPUpdateUrl"

@interface UIViewCtrl_More ()
{
    BOOL _isNotHint;
}

@end

@implementation UIViewCtrl_More

@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize view_03 = _view_03;
@synthesize view_04 = _view_04;
@synthesize button_01 = _button_01;
@synthesize imageview_01 = _imageview_01;
@synthesize imageview_02 = _imageview_02;
@synthesize label_01 = _label_01;
@synthesize label_02 = _label_02;
@synthesize label_03 = _label_03;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect = [[UIScreen mainScreen] bounds];
    if (rect.size.height < 568.0f) {
        CGFloat fwidth = self.view.frame.size.width;
        CGFloat fheight = self.view.frame.size.height - (568.0f - rect.size.height);
        [self.view setFrame:CGRectMake(0, 0, fwidth, fheight)];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
        [self.view_04 setFrame:CGRectMake(self.view_04.layer.frame.origin.x, self.view_04.layer.frame.origin.y, self.view_04.layer.frame.size.width, self.view.frame.size.height)];
    }
    
    
    [self.view_01.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_01.layer setBorderWidth:1.0f];
    [self.view_01.layer setCornerRadius:5.0f];
    
    [self.view_02.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_02.layer setBorderWidth:1.0f];
    [self.view_02.layer setCornerRadius:5.0f];
    
    [self.view_03.layer setBorderColor:[[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f] CGColor]];
    [self.view_03.layer setBorderWidth:1.0f];
    [self.view_03.layer setCornerRadius:5.0f];
    
    
    strStatus = kUserRunStatusOnline;
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Online) {
        strStatus = kUserRunStatusOnline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Busy) {
        strStatus = kUserRunStatusObusyline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Leave) {
        strStatus = kUserRunStatusLeave;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_Hidden) {
        strStatus = kUserRunStatusHidden;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_AndroidOnLine) {
        strStatus = kUserRunStatusOnline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_IosOnLine) {
        strStatus = kUserRunStatusOnline;
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kUserStatus] integerValue] == Status_WebOnLine) {
        strStatus = kUserRunStatusOnline;
    }
    
    
    if ([strStatus compare:kUserRunStatusOnline] == NSOrderedSame) {
        [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_online_01.png"]];
        [[self label_02] setText:@"在线"];
    }else if ([strStatus compare:kUserRunStatusObusyline] == NSOrderedSame){
        [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_busy_01.png"]];
        [[self label_02] setText:@"忙碌"];
    }else if ([strStatus compare:kUserRunStatusHidden] == NSOrderedSame){
        [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_invisible_01.png"]];
        [[self label_02] setText:@"隐身"];
    }else if ([strStatus compare:kUserRunStatusLeave] == NSOrderedSame){
        [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_leave_01.png"]];
        [[self label_02] setText:@"离开"];
    }
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_version = [infoDic valueForKey:@"CFBundleShortVersionString"];

    [self.label_03 setText:[NSString stringWithFormat:@"V %@", app_version]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:PARAMTER_KEY_NOTIFY_RELOAD_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ON_NOTIFICATION:) name:@"pushUserStatus" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    NSString *smallmimage = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserSmallIconPath],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:smallmimage] == YES) {
        UIImage *image_01 = [UIImage imageWithContentsOfFile:smallmimage];
        [[self imageview_01] setImage:image_01];
    }else{
        if ([((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserSex]) compare:@"女"] == NSOrderedSame ) {
            UIImage *image_01 = [UIImage imageNamed:@"user_picture_girl.png"];
            [[self imageview_01] setImage:image_01];
        }else{
            UIImage *image_01 = [UIImage imageNamed:@"user_picture.png"];
            [[self imageview_01] setImage:image_01];
        }
    }
    [[self label_01] setText:[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName]];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

#pragma label -
#pragma label UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 456789)
    {
        if(buttonIndex == 1)
        {
            NSString *downloadUrl = [[NSUserDefaults standardUserDefaults] stringForKey:kAppUpdate];
            [self doUpdate:downloadUrl];
        }
    }
    else
    {
        if (buttonIndex == 1 && [alertView.message compare:@"您将要退出当前用户，返回登录界面！"] == NSOrderedSame) {
            NSLog(@"%@", alertView.message);
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLoginStatus];
            //        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsExecuteAutoLogin];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGOUT object:nil];
            return;
        }
    }
    
}

#pragma label -
#pragma label Custom Methods

- (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:PARAMTER_KEY_NOTIFY_RELOAD_DATA] == NSOrderedSame){
        NSString *smallmimage = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserSmallIconPath],[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]]];
        NSFileManager *filemanager = [NSFileManager defaultManager];
        if ([filemanager fileExistsAtPath:smallmimage] == YES) {
            UIImage *image_01 = [UIImage imageWithContentsOfFile:smallmimage];
            [[self imageview_01] setImage:image_01];
        }else{
            if ([((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:kUserSex]) compare:@"女"] == NSOrderedSame ) {
                UIImage *image_01 = [UIImage imageNamed:@"user_picture_girl.png"];
                [[self imageview_01] setImage:image_01];
            }else{
                UIImage *image_01 = [UIImage imageNamed:@"user_picture.png"];
                [[self imageview_01] setImage:image_01];
            }
        }
        [[self label_01] setText:[[NSUserDefaults standardUserDefaults] objectForKey:User_NickName]];
        
        
        NSString *sStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kUserRunStatus];
        if (sStatus == nil) {
            sStatus = kUserRunStatusOnline;
        }
    }else if ([wParam.name compare:@"pushUserStatus"] == NSOrderedSame) {
        
        
        if ([((NSString *)[wParam.userInfo valueForKey:@"err"]) compare:@"0:succeed"] == NSOrderedSame) {
            NSString *sStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kUserRunStatus];
            if (sStatus == nil) {
                sStatus = kUserRunStatusOnline;
            }
            if ([sStatus compare:kUserRunStatusOnline] == NSOrderedSame) {
                [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_online_01.png"]];
                [[self label_02] setText:@"在线"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:Status_Online]] forKey:kUserStatus];
            }else if ([sStatus compare:kUserRunStatusObusyline] == NSOrderedSame){
                [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_busy_01.png"]];
                [[self label_02] setText:@"忙碌"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:Status_Busy]] forKey:kUserStatus];
            }else if ([sStatus compare:kUserRunStatusHidden] == NSOrderedSame){
                [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_invisible_01.png"]];
                [[self label_02] setText:@"隐身"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:Status_Hidden]] forKey:kUserStatus];
            }else if ([sStatus compare:kUserRunStatusLeave] == NSOrderedSame){
                [[self imageview_02] setImage:[UIImage imageNamed:@"onlinestatus_leave_01.png"]];
                [[self label_02] setText:@"离开"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:Status_Leave]] forKey:kUserStatus];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [[STHUDManager sharedManager] hideHUDInView:self.view];
    }
}

- (IBAction)onBtn01_Click:(id)sender
{
    return;
    UIViewCtrl_Software_Status *uisoft = [[[UIViewCtrl_Software_Status alloc] initWithNibName:@"UIViewCtrl_Software_Status" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:uisoft animated:YES];
}

- (IBAction)onBtn02_Click:(id)sender
{
    UIViewCtrl_User_Information *tmp_view = [[[UIViewCtrl_User_Information alloc] initWithNibName:@"UIViewCtrl_User_Information" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn03_Click:(id)sender
{
    UIViewCtrl_Pic_Business_Card *tmp_view = [[[UIViewCtrl_Pic_Business_Card alloc] initWithNibName:@"UIViewCtrl_Pic_Business_Card" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn04_Click:(id)sender
{
    UIViewCtrl_Message_Config *tmp_view = [[[UIViewCtrl_Message_Config alloc] initWithNibName:@"UIViewCtrl_Message_Config" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn05_Click:(id)sender
{
    UIViewCtrl_Voice_Config *tmp_view = [[[UIViewCtrl_Voice_Config alloc] initWithNibName:@"UIViewCtrl_Voice_Config" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn06_Click:(id)sender
{
    UIViewCtrl_Privacy_Config *tmp_view = [[[UIViewCtrl_Privacy_Config alloc] initWithNibName:@"UIViewCtrl_Privacy_Config" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn07_Click:(id)sender
{
    UIViewCtrl_About *tmp_view = [[[UIViewCtrl_About alloc] initWithNibName:@"UIViewCtrl_About" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn08_Click:(id)sender
{
    UIViewCtrl_User_Report *tmp_view = [[[UIViewCtrl_User_Report alloc] initWithNibName:@"UIViewCtrl_User_Report" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn09_Click:(id)sender
{
    [self fretchAppVersion];
//    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"版本校验" message:@"您目前的软件已是最新版本，无需升级！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
//    [alert show];
}
- (void)fretchAppVersion
{
    [[HttpServiceHelper sharedService] requestForType:Http_FretchAppVersion info:nil target:self successSel:@"requestFinished:" failedSel:@"requestFailed:"];
}

- (void)requestFinished:(NSDictionary *)datas
{
    //服务器版本号
    NSString *postVersionString = [datas objectForKey:@"Version"];
    NSArray *postVersionarr = [postVersionString componentsSeparatedByString:@"."];
    
    //本地版本号
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSArray *versionarr = [versionString componentsSeparatedByString:@"."];
    int count = (int)MAX([postVersionarr count], [versionarr count]);
    BOOL isUpdate = NO;
    for (int i = 0; i < count; i++) {
        //服务器版本号
        int postVersion = 0;
        if (i < [postVersionarr count]) {
            postVersion = [[postVersionarr objectAtIndex:i] intValue];
        }
        
        //本地版本号
        int localVersion = 0;
        if (i < [versionarr count]) {
            localVersion = [[versionarr objectAtIndex:i] intValue];
        }
        
        //比对两个版本号
        if (postVersion != localVersion) {
            if (localVersion < postVersion) {
                //如果本地版本号小，更新
                isUpdate = YES;
            }
            break;  //已经比对出结果
        }
    }
    
    NSString *downloadUrl = [datas objectForKey:@"URL"];
    [[NSUserDefaults standardUserDefaults] setObject:downloadUrl forKey:kAppUpdate];
    
    if (![[datas objectForKey:@"MustUpdate"] isEqualToString:@"false"])//强制更新
    {
        if (isUpdate)
        {
            NSString *msg = [datas objectForKey:@"Info"];
            CustomAlertView *aler = [[[CustomAlertView alloc] initWithAlertStyle:MustUpdate_style withObject:msg] autorelease];
            aler.delegate = self;
            [[AppDelegate shareDelegate].window addSubview:aler];
            
        }
    }
    else
    {
        if (isUpdate)
        {
            _isNotHint = [[NSUserDefaults standardUserDefaults] boolForKey:@"isnothint"];
            
            if (!_isNotHint)
            {
                NSString *msg = [datas objectForKey:@"Info"];
                CustomAlertView *aler = [[[CustomAlertView alloc] initWithAlertStyle:Update_Style withObject:msg] autorelease];
                aler.delegate = self;
                [self.view addSubview:aler];
            }
            else
            {
                [self doUpdate:downloadUrl];
            }
        }
        else
        {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"版本校验" message:@"您目前的软件已是最新版本，无需升级！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil] autorelease];
            [alert show];

        }
    }
}

- (void)requestFailed:(id)sender
{
    NSLog(@"failed:");
}

- (void)update
{
    NSString *downloadUrl = [[NSUserDefaults standardUserDefaults] stringForKey:kAppUpdate];
    [self doUpdate:downloadUrl];
}


- (void)hintOrNotTransmission:(BOOL)status
{
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"isnothint"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)doUpdate:(NSString *)url
{
    NSString *downloadUrl = url;
    if(![url hasPrefix:@"itms-services:"])
    {
        downloadUrl = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",downloadUrl];
        
    }
    NSURL *appurl = [NSURL URLWithString:downloadUrl];
    
    if([[UIApplication sharedApplication] canOpenURL:appurl])
    {
        
        [[UIApplication sharedApplication] openURL:appurl];
    }
}

- (IBAction)onBtn10_Click:(id)sender
{
    UIViewCtrl_Software_Help *tmp_view = [[[UIViewCtrl_Software_Help alloc] initWithNibName:@"UIViewCtrl_Software_Help" bundle:nil] autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}

- (IBAction)onBtn11_Click:(id)sender
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您将要退出当前用户，返回登录界面！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] autorelease];
    [alert show];
}

- (void)receiveDataNotification:(NSNotification *)wParam
{
    if ([wParam.name compare:@"pushUserStatus"] == NSOrderedSame) {
        
        NSLog(@"%@", wParam.userInfo);
    }
}

@end
