//
//  UIViewCtrl_News.m
//  JieXinIphone
//
//  Created by gabriella on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewCtrl_News.h"
#import "UIViewCtrl_System_Notify.h"
#import "pullVC.h"
#import "JLeadPlanViewController.h"
#import "JMainCommunistVCs.h"
#import "JFinanciaManagementListVC.h"
#import "DocumentViewController.h"
#import "CarManagementVC.h"
#import "CombatVC.h"
#import "integratedVC.h"
#import "SearchRecordVC_01.h"
#import "companyNewsViewController.h"
#import "SecurityTipsViewController.h"
#import "UIViewCtrl_Channel_Show_01.h"
#import "documentDataHelp.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PlaySound.h"
#import "myLib.h"

#import "CardMainViewController.h"

#import "CardApplyViewController.h"

#import "humanResourceListsVC.h"
#import "JReceiceLeadPlan.h"
@interface UIViewCtrl_News ()

@property(nonatomic,retain)JCheckUser * userInfo;

@end

@implementation UIViewCtrl_News

@synthesize view_01 = _view_01;
@synthesize view_02 = _view_02;
@synthesize scrollview_01 =_scrollview_01;
@synthesize userInfo;

@synthesize array_fun = _array_fun;
@synthesize unReadCountLabel;
@synthesize bntDic;
@synthesize pageControl=_pageControl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        bntDic = [[NSMutableDictionary alloc]init];
        // Custom initialization
        //在线推送消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(SerNews:)
                                                     name:@"RadioBroadcast" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(SendRadioNews:)
                                                     name:@"SendRadio" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newsShow)
                                                     name:@"newsShow" object:nil];
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
    
    self.array_fun = [NSMutableArray array];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
        [self.view_02 setFrame:CGRectMake(self.view_02.layer.frame.origin.x, self.view_02.layer.frame.origin.y, self.view_02.layer.frame.size.width, self.view.frame.size.height)];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}

//消息通知
-(void)Sound:(NSString *)soundName Type:(NSString *)type
{
    NSString *soundPath=[[NSBundle mainBundle] pathForResource:soundName ofType:type] ;
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:soundPath];
   AVAudioPlayer* player=[[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil] autorelease];
    [player prepareToPlay];
    [soundUrl release];
    [player play];
}

//设置底部提醒
-(void)newsShow{
    
    NSArray*arr = [[documentDataHelp sharedService] readDocModelItem:@"NewsTable"];
    if ([self newsShowCheck:arr]) {
        NSDictionary *dicc = @{@"Index": [NSNumber numberWithInt:2],@"Count":[NSNumber numberWithInt:1]};
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_BADGEVALUE object:dicc];
    }
    else{
        NSDictionary *dicc = @{@"Index": [NSNumber numberWithInt:2],@"Count":[NSNumber numberWithInt:0]};
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_BADGEVALUE object:dicc];
    }

}
//检查数据库里边有没有服务消息
-(BOOL)newsShowCheck:(NSArray*)arr{
    for (int i=0; i<[arr count]; i++) {
        NSDictionary* dic = [arr objectAtIndex:i];
        NSString* str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sysid"]];
        if([self isNews:str]){
            return YES;
        }
        else{
            [[documentDataHelp sharedService]deleteTestList:str];
        }
    }
      return NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"newsShow" object:nil];
        if ([AppDelegate shareDelegate].sameUserName==YES&&self.userInfo!=nil&&[AppDelegate shareDelegate].sameIP) {
        //账户没有改变不做申请
            [self setNews];
        
    }else{
        [[STHUDManager sharedManager] showHUDInView:self.view];
        self.userInfo=[[JCheckUser alloc]init];
        self.userInfo.calendarDelegate = self;
       
        [AppDelegate shareDelegate].sameUserName = YES;
        [AppDelegate shareDelegate].sameIP = YES;
    }
    

}
//服务器主动推送服务模块信息
- (void)SerNews:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    NSLog(@"SerNews:%@",dic);
    UIViewCtrl_NewsModel * model = [[UIViewCtrl_NewsModel alloc]init];
    model.type = [dic objectForKey:@"type"];
    model.cmd = [dic objectForKey:@"cmd"];
    model.SerialID = [dic objectForKey:@"SerialID"];
    model.Sysid = [dic objectForKey:@"Sysid"];
    model.Category = [dic objectForKey:@"Category"];
    model.Title = [dic objectForKey:@"Title"];
    model.Summary = [dic objectForKey:@"Summary"];
    model.Msg = [dic objectForKey:@"Msg"];
    if ([model.Sysid isKindOfClass:[NSArray class]]) {
        return;
    }
    if(![self isNews:model.Sysid]){
        NSLog(@"yichang");
        return;
    }
    if ([model.Sysid isEqualToString:@"06"]) {
        if (![JReceiceLeadPlan isTrueDateForString:model.Category]) {
            return;
        }
    }
    //如果数组里存有上次的内容ID，要进行比较
//    if ([[AppDelegate shareDelegate].newsModelArray count]!=0) {
//       
//        UIViewCtrl_NewsModel * model1 = [[UIViewCtrl_NewsModel alloc]init];
//        //取出上次的内容ID
//         model1=[[AppDelegate shareDelegate].newsModelArray objectAtIndex:0];
//        if ([model.Category isEqualToString:model1.Category]&&[model.Sysid isEqualToString:model1.Sysid]) {
//            //如果一样的话，清空数组，存入新的ID，然后退出
//            NSLog(@"sameID");
//            [[AppDelegate shareDelegate].newsModelArray removeAllObjects];
//            [[AppDelegate shareDelegate].newsModelArray addObject:model];
//            return;
//        }
//        else{
//            [[AppDelegate shareDelegate].newsModelArray removeAllObjects];
//        }
//    }
    
     [[AppDelegate shareDelegate].newsModelArray addObject:model];
    //消息提醒
     NSArray*titleBnt = [[NSArray alloc]initWithObjects:@"通知公告",@"财务管理",@"党务视窗",@"综合服务",@"政企新闻",@"工作日程" ,@"安全小卫士",@"档案查询",@"人力资源",@"车辆预订",nil];
    NSMutableString* str = [[NSMutableString alloc]init];
   
    if ([model.Sysid isEqualToString:@"01"]) {
         [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"02"]) {
       [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"03"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"04"]) {
       [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"05"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"06"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"07"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];    }
    if ([model.Sysid isEqualToString:@"08"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"09"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    if ([model.Sysid isEqualToString:@"10"]) {
        [str appendFormat:@"%@,收到一条新的信息",[titleBnt objectAtIndex:[model.Sysid intValue]-1]];
    }
    
    NSDictionary*newsdic = [[NSDictionary alloc]initWithObjectsAndKeys:str,@"zhi", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newsLableShow" object:newsdic];
    [[documentDataHelp sharedService] insertDocModelItem:model];
    if ([model.Sysid isEqualToString:@"06"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NEWNOTIFACTIONMESSAGE" object:newsdic];

    }
       if([AppDelegate shareDelegate].sameUserName==YES)
    {
         //[self Sound:@"office" Type:@"mp3"];
         [[PlaySound sharedService] playMessageReceivedSound];
        [self setNews];
    }
    if ([AppDelegate shareDelegate].isLogin==YES) {
        [AppDelegate shareDelegate].isLogin=NO;
       // [self Sound:@"office" Type:@"mp3"];
         [[PlaySound sharedService] playMessageReceivedSound];
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:@"newsShow" object:nil];
  
    //收到信息包，给服务器回执信息
    NSString* contentID = [dic objectForKey:@"SerialID"];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *SerNewsArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"RadioBroadcastReply"},@{@"SerialID": contentID}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:SerNewsArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}
-(BOOL)isNews:(NSString*)sID{
    NSArray*arr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10"];
    for (int i=0; i<[arr count]; i++) {
        if ([sID isEqualToString:[arr objectAtIndex:i]]) {
            NSLog(@"yes");
            return YES;
        }
    }
    NSLog(@"no");
    return NO;
    
}
//给服务发送服务模块数据的请求
- (void)SendRadioNews:(NSNotification *)notification
{
    [AppDelegate shareDelegate].isLogin=YES;
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *SerNewsArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"RadioBroadcast"}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:SerNewsArr]];
    
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}
//给button上添加lable
-(void)unreadLable:(UIButton*)sender withHideFlag:(BOOL)falg{
    UILabel*lable = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    [lable setBackgroundColor:[UIColor redColor]];
    lable.layer.cornerRadius = CGRectGetHeight(lable.frame)/2;
    lable.layer.masksToBounds = YES;
    [lable setTextColor:[UIColor whiteColor]];
    [lable setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    lable.hidden = falg;
    CGSize badgeSize = CGSizeMake(10, 10);
    lable.frame = CGRectMake(CGRectGetWidth(sender.bounds)-badgeSize.width-3, CGRectGetMinX(sender.bounds)+5, badgeSize.width, badgeSize.height);
    lable.layer.cornerRadius = CGRectGetHeight(lable.frame)/2;
    sender.backgroundColor = [UIColor clearColor];
    [sender addSubview:lable];
}
- (void)initSubviews
{
    
    [self.array_fun removeAllObjects];
    for ( UIView *view in [self.scrollview_01 subviews]) {
        [view removeFromSuperview];
    }
    
    NSString *domain = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
    /*新的排版请按照 通知公告、工作日程、政企新闻、综合服务、财务管理、党务视窗、车辆预订、名片申请、办公用品申请、安全小卫士、档案查询、员工园地、图片墙*/
    //======================= 添加功能按钮
    
    
    NSMutableDictionary *tmp_dic = [NSMutableDictionary dictionary];
    
    UIButton *tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
    UILabel *tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
    [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_01_normal.png"] forState:UIControlStateNormal];
    [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_01_pressed.png"] forState:UIControlStateHighlighted];
    

    [tmp_button addTarget:self action:@selector(onBtn01_Click:) forControlEvents:UIControlEventTouchUpInside];
     [self unreadLable:tmp_button withHideFlag:YES];
    [tmp_label setText:@"通知公告"];
    [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
    [tmp_label setTextAlignment:NSTextAlignmentCenter];
    [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
    [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
    [self.array_fun addObject:tmp_dic];
    
    
    // *********************************************
    
    
    
    if( !([userInfo.userId isEqualToString:@""] ||userInfo.userId==nil)){
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_02_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_02_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn03_Click:) forControlEvents:UIControlEventTouchUpInside];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"工作日程"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
        
    }
    
    
    if ([domain isEqualToString:@"111.11.28.30"]||[domain isEqualToString:@"111.11.28.41"]){
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"service_icon_news"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"service_icon_news_p"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtnCompanyNews_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"政企新闻"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
        
    }
        // *********************************************
    if ([domain isEqualToString:@"111.11.28.41"]||[domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_09_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_09_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn09_Click:) forControlEvents:UIControlEventTouchUpInside];
        [tmp_label setText:@"综合服务"];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    
    // *********************************************
    if ([domain isEqualToString:@"111.11.28.41"]||[domain isEqualToString:@"111.11.29.65"]||[domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_03_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_03_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn05_Click:) forControlEvents:UIControlEventTouchUpInside];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"财务管理"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    
    // *********************************************
    
    if ([domain isEqualToString:@"111.11.28.41"]||[domain isEqualToString:@"111.11.28.30"]||[domain isEqualToString:@"111.11.29.65"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_04_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_04_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn04_Click:) forControlEvents:UIControlEventTouchUpInside];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"党务视窗"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    
    // *********************************************
    if ([domain isEqualToString:@"111.11.28.30"]||[domain isEqualToString:@"111.11.28.41"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_07_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_07_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn07_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"车辆预订"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }

     // *********************************************
    if ([domain isEqualToString:@"111.11.28.30"]||[domain isEqualToString:@"111.11.28.41"]) {
    tmp_dic = [NSMutableDictionary dictionary];
    
    tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
    tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
    
    [tmp_button setImage:[UIImage imageNamed:@"CardApply_normal"] forState:UIControlStateNormal];
    [tmp_button setImage:[UIImage imageNamed:@"CardApply_pressed"] forState:UIControlStateHighlighted];
    [tmp_button addTarget:self action:@selector(onBtnCard_Click:) forControlEvents:UIControlEventTouchUpInside];
    [self unreadLable:tmp_button withHideFlag:YES];
    [tmp_label setText:@"名片申请"];
    [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
    [tmp_label setTextAlignment:NSTextAlignmentCenter];
    
    [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
    [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
    [self.array_fun addObject:tmp_dic];
    }
        
    if ([domain isEqualToString:@"111.11.28.41"]||[domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"service_icon_safer"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"service_icon_safer_p"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(securityTips_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"安全小卫士"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    

       // *********************************************
    if ([domain isEqualToString:@"111.11.28.41"]||[domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_10_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_10_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn10_Click:) forControlEvents:UIControlEventTouchUpInside];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"档案查询"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    
    //************************************************
    
    if ([domain isEqualToString:@"111.11.28.41"]||[domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"service_icon_human"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"service_icon_huaman_p"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(humanResource_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"人力资源"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    
    

    
    tmp_dic = [NSMutableDictionary dictionary];
    
    tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
    tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
    
    [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_11_normal.png"] forState:UIControlStateNormal];
    [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_11_pressed.png"] forState:UIControlStateHighlighted];
    [tmp_button addTarget:self action:@selector(onBtn06_Click:) forControlEvents:UIControlEventTouchUpInside];
     [self unreadLable:tmp_button withHideFlag:YES];
    [tmp_label setText:@"员工园地"];
    [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
    [tmp_label setTextAlignment:NSTextAlignmentCenter];
    
    [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
    [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
    [self.array_fun addObject:tmp_dic];
    
    // *********************************************
    
    tmp_dic = [NSMutableDictionary dictionary];
    
    tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
    tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
    
    [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_06_normal.png"] forState:UIControlStateNormal];
    [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_06_pressed.png"] forState:UIControlStateHighlighted];
    [tmp_button addTarget:self action:@selector(onBtn02_Click:) forControlEvents:UIControlEventTouchUpInside];
     [self unreadLable:tmp_button withHideFlag:YES];
    [tmp_label setText:@"图片墙"];
    [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
    [tmp_label setTextAlignment:NSTextAlignmentCenter];
    
    [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
    [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
    
    [self.array_fun addObject:tmp_dic];
    
    
    
    // *********************************************
    
    if ([domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_08_normal.png"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"uiview_news_icon_08_pressed.png"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtn08_Click:) forControlEvents:UIControlEventTouchUpInside];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"反腐倡廉"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    // *********************************************
    if ([domain isEqualToString:@"111.11.28.30"]) {
        tmp_dic = [NSMutableDictionary dictionary];
        
        tmp_button = [[[UIButton alloc] initWithFrame:CGRectMake(12.0f, 6.0f, 75.0f, 75.0f)] autorelease];
        tmp_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 89.0f, 98.0f, 21.0f)] autorelease];
        
        [tmp_button setImage:[UIImage imageNamed:@"documentModel"] forState:UIControlStateNormal];
        [tmp_button setImage:[UIImage imageNamed:@"documentModel_pressed"] forState:UIControlStateHighlighted];
        [tmp_button addTarget:self action:@selector(onBtnDocument_Click:) forControlEvents:UIControlEventTouchUpInside];
         [self unreadLable:tmp_button withHideFlag:YES];
        [tmp_label setText:@"文档管理"];
        [tmp_label setFont:[UIFont systemFontOfSize:15.0f]];
        [tmp_label setTextAlignment:NSTextAlignmentCenter];
        
        [tmp_dic setObject:tmp_button forKey:@"FUN_ICON"];
        [tmp_dic setObject:tmp_label forKey:@"FUN_TITLE"];
        [self.array_fun addObject:tmp_dic];
    }
    
    
   
    
    
       // *********************************************
    NSInteger cell_cnt = ([self.array_fun count] + 2) / 3 * 3;
    int pageNumber;
    int iconCnt=0;
    if (iPhone5) {
        iconCnt=12;
    }
    else{
        iconCnt=9;
    }
    pageNumber = cell_cnt/(iconCnt+1)+1;
    self.scrollview_01.pagingEnabled = YES;
    self.scrollview_01.delegate = self;
    self.scrollview_01.contentSize = CGSizeMake(320*pageNumber, 300);
    self.scrollview_01.showsHorizontalScrollIndicator = YES;
    for (NSInteger i = 0; i < cell_cnt; i ++) {
        UIView *tmp_view = [[[UIView alloc] init] autorelease];
        //int index_x=i/9;
        int index_y;
        if (i>=iconCnt) {
            index_y=(i-iconCnt)/3;
        }
        else{
            index_y = i/3;
        }
        if (i % 3 == 0) {
            [tmp_view setFrame:CGRectMake(i/iconCnt*320+11.0f, 1.0f + index_y * 111.0f, 98.0f, 110.0f)];
        }else if (i % 3 == 1){
            [tmp_view setFrame:CGRectMake(i/iconCnt*320+110.0f, 1.0f + index_y * 111.0f, 98.0f, 110.0f)];
        }else if (i % 3 == 2){
            [tmp_view setFrame:CGRectMake(i/iconCnt*320+209.0f, 1.0f + index_y * 111.0f, 98.0f, 110.0f)];
        }
        [tmp_view setBackgroundColor:[UIColor whiteColor]];
        
        if ( i < [self.array_fun count]) {
            NSDictionary *tmp_dic = [self.array_fun objectAtIndex:i];
            [tmp_view addSubview:[tmp_dic objectForKey:@"FUN_ICON"]];
            [tmp_view addSubview:[tmp_dic objectForKey:@"FUN_TITLE"]];
            
            UIButton*bnt = [tmp_dic objectForKey:@"FUN_ICON"];
            UILabel*lable = [tmp_dic objectForKey:@"FUN_TITLE"];
            NSString * str = [NSString stringWithFormat:@"%@",lable.text];
            [bntDic setObject:bnt forKey:str];
        }
        [self.scrollview_01 addSubview:tmp_view];
            }
    
    if (self.pageControl==nil) {
        int h=0;
        if (iPhone5) {
            h=95;
        }
        if (IOSVersion>=7) {
            self.pageControl = [[[StyledPageControl alloc]initWithFrame:CGRectMake(0, 400+h, 320, 30)] autorelease];
        }
        else{
             self.pageControl = [[[StyledPageControl alloc]initWithFrame:CGRectMake(0, 400-20+h, 320, 30)] autorelease];
        }
        self.pageControl.numberOfPages = pageNumber;
        if (pageNumber==1) {
            self.pageControl.hidden = YES;
        }else{
            self.pageControl.hidden = NO;
        }
        int current = self.scrollview_01.contentOffset.x / 320;
        self.pageControl.currentPage = current;
        self.pageControl.tag = 200;
        [self.pageControl addTarget:self action:@selector(pageClick) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:self.pageControl];
    }else{
        self.pageControl.numberOfPages = pageNumber;
        if (pageNumber==1) {
            self.pageControl.hidden = YES;
        }else{
            self.pageControl.hidden = NO;
        }
        int current = self.scrollview_01.contentOffset.x / 320;
        self.pageControl.currentPage = current;
          }
    
    
}
-(void)pageClick{
    [self.scrollview_01 setContentOffset:CGPointMake(self.pageControl.currentPage * 320, 0) animated:YES];
    [self.pageControl setCurrentPage:self.pageControl.currentPage];
}
//设置消息提醒
-(void)setNews{
    
    NSArray*titleBnt = [[NSArray alloc]initWithObjects:@"通知公告",@"财务管理",@"党务视窗",@"综合服务",@"政企新闻",@"工作日程",@"安全小卫士",@"档案查询",@"人力资源",@"车辆预订", nil];
    for (int i=0; i<[titleBnt count]; i++) {
         UIButton*bnt = [bntDic objectForKey:[NSString stringWithFormat:@"%@",[titleBnt objectAtIndex:i]]];
        [self LableWithBnt:bnt hidden:YES];
    }
    NSArray*arr = [[documentDataHelp sharedService] readDocModelItem:@"NewsTable"];
    NSLog(@"newsCount===%@",arr );
    for (int i=0; i<[arr count]; i++) {
        NSString*str = [[arr objectAtIndex:i] objectForKey:@"sysid"];
        if ([str isEqualToString:@"01"]) {
            UIButton*bnt = [bntDic objectForKey:@"通知公告"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
            
        }else if ([str isEqualToString:@"02"]){
            UIButton*bnt = [bntDic objectForKey:@"财务管理"];
            if (bnt!=nil) {
                 [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }else if ([str isEqualToString:@"03"]){
            UIButton*bnt = [bntDic objectForKey:@"党务视窗"];
            if (bnt!=nil) {
                 [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }else if ([str isEqualToString:@"04"]){
            UIButton*bnt = [bntDic objectForKey:@"综合服务"];
            if (bnt!=nil) {
                 [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }else if ([str isEqualToString:@"05"]){
            UIButton*bnt = [bntDic objectForKey:@"政企新闻"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }else if ([str isEqualToString:@"06"]){
            UIButton*bnt = [bntDic objectForKey:@"工作日程"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
            else{
                //[[documentDataHelp sharedService]deleteTestList:@"06"];
            }

        }else if ([str isEqualToString:@"07"]){
            UIButton*bnt = [bntDic objectForKey:@"安全小卫士"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }else if ([str isEqualToString:@"08"]){
            UIButton*bnt = [bntDic objectForKey:@"档案查询"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }
        else if ([str isEqualToString:@"09"]){
            UIButton*bnt = [bntDic objectForKey:@"人力资源"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }
        else if ([str isEqualToString:@"10"]){
            UIButton*bnt = [bntDic objectForKey:@"车辆预订"];
            if (bnt!=nil) {
                [self LableWithBnt:bnt hidden:NO];
                //[self removeModel:model];
            }
        }

    }
    
}
- (void)userCalendar:(JCheckUser *)object
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    self.userInfo = object;
     [self initSubviews];
        [self setNews];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.array_fun removeAllObjects];
    self.array_fun = nil;
    self.userInfo = nil;
    self.pageControl=nil;
    [super dealloc];
}
//隐藏和显示消息提醒
-(void)LableWithBnt:(UIButton*)bnt hidden:(BOOL)hiddenFlag{
    NSArray*array = [[NSArray alloc]init] ;
    array = [bnt subviews];
    if ([array count]>0) {
            UILabel*lable = [array lastObject];
            lable.hidden = hiddenFlag;
       
    }
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int current = self.scrollview_01.contentOffset.x / 320;
//    GrayPageControl *pageControl1 = (GrayPageControl *)[self.view viewWithTag:200];
    self.pageControl.currentPage = current;
    
}


#pragma label -
#pragma label Custom Methods
//系统通知
- (IBAction)onBtn01_Click:(id)sender
{
    
   // [self LableWithBnt:sender hidden:YES];
    //[self removeSysModel:@"01" withSender:sender];
    [[documentDataHelp sharedService]deleteTestList:@"01"];
    [self LableWithBnt:sender hidden:YES];

    UIViewCtrl_System_Notify *tmp_view = [[[UIViewCtrl_System_Notify alloc] initWithNibName:@"UIViewCtrl_System_Notify" bundle:nil]autorelease];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}
//照片墙
- (IBAction)onBtn02_Click:(id)sender
{
   [self LableWithBnt:sender hidden:YES];
    pullVC *photoVC = [[pullVC alloc]initWithNibName:@"pullVC" bundle:nil];
    [self.navigationController pushViewController:photoVC animated:YES];
    [photoVC release];
}
//日程
- (IBAction)onBtn03_Click:(id)sender
{
//    [[documentDataHelp sharedService] deleteTestList:@"06"];
     [self LableWithBnt:sender hidden:YES];
    JLeadPlanViewController *jLVC = [[JLeadPlanViewController alloc]init];
    [self.navigationController pushViewController:jLVC animated:YES];
    [jLVC release];
}
//党务
- (IBAction)onBtn04_Click:(id)sender
{
    //[self removeSysModel:@"03" withSender:sender];
//    [[documentDataHelp sharedService] deleteTestList:@"03"];
    [self LableWithBnt:sender hidden:YES];
    JMainCommunistVCs *communist=[[JMainCommunistVCs alloc]init];
    [self.navigationController pushViewController:communist animated:YES];
    [communist release];
}
//财务
- (IBAction)onBtn05_Click:(id)sender
{
   // [self removeSysModel:@"02" withSender:sender];
    // [[documentDataHelp sharedService] deleteTestList:@"02"];
    [self LableWithBnt:sender hidden:YES];

    JFinanciaManagementListVC *financialList = [[JFinanciaManagementListVC alloc] init];
    [self.navigationController pushViewController:financialList animated:YES];
    [financialList release];
}
//员工园地
- (IBAction)onBtn06_Click:(id)sender
{
    [self LableWithBnt:sender hidden:YES];
    UIViewCtrl_Channel_Show_01 *tmp_view = [[[UIViewCtrl_Channel_Show_01 alloc] initWithNibName:@"UIViewCtrl_Channel_Show_01" bundle:nil]autorelease];
    tmp_view.from=TypeAll;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:tmp_view animated:YES];
}
//车辆预订
- (IBAction)onBtn07_Click:(id)sender
{
    [[documentDataHelp sharedService]deleteTestList:@"10"];
    [self LableWithBnt:sender hidden:YES];

    CarManagementVC *carManagement = [[CarManagementVC alloc] init];
    [self.navigationController pushViewController:carManagement animated:YES];
    [carManagement release];
//    CardApplyViewController *avc = [[CardApplyViewController alloc] init];
//    [self.navigationController pushViewController:avc animated:YES];
}
//
- (IBAction)onBtn08_Click:(id)sender
{  [self LableWithBnt:sender hidden:YES];
    CombatVC *comVC = [[CombatVC alloc]initWithNibName:@"CombatVC" bundle:nil];
    [self.navigationController pushViewController:comVC animated:YES];
    [comVC release];
    
    
}
//综合
- (IBAction)onBtn09_Click:(id)sender
{
    //[self removeSysModel:@"04" withSender:sender];
     [[documentDataHelp sharedService] deleteTestList:@"04"];
    [self LableWithBnt:sender hidden:YES];

    integratedVC *comVC = [[integratedVC alloc]initWithNibName:@"integratedVC" bundle:nil];
    [self.navigationController pushViewController:comVC animated:YES];
    [comVC release];
}
- (IBAction)onBtn10_Click:(id)sender
{
    [self LableWithBnt:sender hidden:YES];
    SearchRecordVC_01 *searchVC = [[SearchRecordVC_01 alloc]initWithNibName:@"SearchRecordVC_01" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
    return;
}

-(IBAction)onBtnDocument_Click:(id)sender{
    [self LableWithBnt:sender hidden:YES];  
    DocumentViewController *docController = [[DocumentViewController alloc] initWithNibName:@"DocumentViewController" bundle:Nil];
    [self.navigationController pushViewController:docController animated:YES];
   // [docController release];
    
}

-(void)onBtnCard_Click:(id)sender{
     [self LableWithBnt:sender hidden:YES];
    CardMainViewController *cardController = [[CardMainViewController alloc] init];
    [self.navigationController pushViewController:cardController animated:YES];
    [cardController release];
}

//政企新闻
-(IBAction)onBtnCompanyNews_Click:(id)sender{
    //[self removeSysModel:@"05" withSender:sender];
     [[documentDataHelp sharedService] deleteTestList:@"05"];
    [self LableWithBnt:sender hidden:YES];

    companyNewsViewController *companyView = [[companyNewsViewController alloc] init] ;
    [self.navigationController pushViewController:companyView animated:YES];
   
    
}
-(IBAction)securityTips_Click:(id)sender{
    [[documentDataHelp sharedService] deleteTestList:@"07"];
    [self LableWithBnt:sender hidden:YES];

    SecurityTipsViewController *secView = [[SecurityTipsViewController alloc] init];
    [self.navigationController pushViewController:secView animated:YES];
  
}
-(IBAction)humanResource_Click:(id)sender{

    [self LableWithBnt:sender hidden:YES];
    humanResourceListsVC *humanView = [[humanResourceListsVC alloc] init];
    [self.navigationController pushViewController:humanView animated:YES];
  
}
-(void)viewDidDisappear:(BOOL)animated{
}
@end
