//
//  SingleChatEditViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-7.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SingleChatEditViewController.h"
#import "ChatHistoryViewController.h"
#import "SynUserInfo.h"
#import "SynUserIcon.h"
#import "LinkDataHelper.h"
#import "LinkDateCenter.h"
#import "User.h"
#import "CustomAlertView.h"
#import "GroupSendMsgViewController.h"
#import "MailHelp.h"
#import "SynContacts.h"
#import "LinkMakeGroupViewController.h"

@interface SingleChatEditViewController ()<UIAlertViewDelegate,CustomeAlertViewDelegate>
@property (nonatomic, retain) UIView *membersView;
@property (nonatomic, retain) CustomAlertView *customAllertView;
@property (nonatomic, retain) SynContacts *synView;
@property (nonatomic, retain) User *userInfo;

@end

@implementation SingleChatEditViewController

- (void)dealloc
{
    self.conFeed = nil;
    self.membersView  = nil;
    self.customAllertView = nil;
    self.synView = nil;
    self.userInfo = nil;
    [super dealloc];
}

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
    
    [[LinkDataHelper sharedService] readDistanceDataBase];
    self.userInfo = [[LinkDataHelper sharedService] getUserWithUserId:[NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId]];
    [[LinkDataHelper sharedService] closeDistanceDatabase];

    self.view.backgroundColor = [UIColor whiteColor];
    [super createCustomNavBarWithoutLogo];

    [self loadSubviews];
    [self loadMemberView];
    // Do any additional setup after loading the view.
}

- (void)loadSubviews
{
    self.synView = [[[SynContacts alloc] init] autorelease];

    UIImageView *bgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.iosChangeFloat+44+10, 300, 10)];
    bgView1.image = [UIImage imageNamed:@"list_bg5-2.png"];
    bgView1.userInteractionEnabled = YES;
    [self.view addSubview:bgView1];
    [bgView1 release];
    
    UIImageView *bgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.iosChangeFloat+44+10+90, 300, 10)];
    bgView2.image = [UIImage imageNamed:@"list_bg5.png"];
    bgView2.userInteractionEnabled = YES;
    [self.view addSubview:bgView2];
    [bgView2 release];
    
    UIImageView *bgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.iosChangeFloat+44+10+10, 300, 80)];
    bgView3.image = [UIImage imageNamed:@"list_bg4.png"];
    bgView3.userInteractionEnabled = YES;
    [self.view addSubview:bgView3];
    [bgView3 release];
    
    self.membersView = [[[UIView alloc] initWithFrame:bgView3.bounds] autorelease];
    [bgView3 addSubview:_membersView];
    
    //右上角
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(280, self.iosChangeFloat+10, 30, 22.5);
    editBtn.tintColor = [UIColor clearColor];
    [editBtn setImage:[UIImage imageNamed:@"add_lxr.png"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(addPersonBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];

    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"聊天信息";
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //历史记录按钮
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(10, self.iosChangeFloat+44+120, 140, 45);
    [historyBtn setImage:[UIImage imageNamed:@"lishi_jilu.png"] forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(watchHistory:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyBtn];
    
    //清空聊天记录
    UIButton *clearMessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearMessBtn.frame = CGRectMake(170, self.iosChangeFloat+44+120, 140, 45);
    [clearMessBtn setImage:[UIImage imageNamed:@"clear_lishi.png"] forState:UIControlStateNormal];
    [clearMessBtn addTarget:self action:@selector(clearMess:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearMessBtn];
    
}

- (void)loadMemberView
{
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 5, 40, 40)];
    NSString *imageInfo = [self getImageFromInfo];
    if ([imageInfo hasSuffix:@"jpg"]) {
        logoView.image = [UIImage imageWithContentsOfFile:imageInfo];
      
    }
    else
    {
        logoView.image = UIImageWithName(imageInfo);
    }
    logoView.userInteractionEnabled = YES;
    [self.membersView addSubview:logoView];
    [logoView release];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPressRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)] autorelease];
    [logoView addGestureRecognizer:longPressRecognizer];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.5, 50, 40, 15)];
    titleLabel.text = _userInfo.nickname;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.membersView addSubview:titleLabel];
    [titleLabel release];
    
//    UIButton *addPersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addPersonBtn setImage:[UIImage imageNamed:@"addmem_normal.png"] forState:UIControlStateNormal];
//    [addPersonBtn setImage:[UIImage imageNamed:@"addmem_pressed.png"] forState:UIControlStateSelected];
//    addPersonBtn.frame = CGRectMake(65, 2, 56,  56);
//    [addPersonBtn addTarget:self action:@selector(addPersonBtnTap:) forControlEvents:UIControlEventTouchUpInside];
//    [self.membersView addSubview:addPersonBtn];
}



- (NSString *)getImageFromInfo
{
    NSString *id = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    NSInteger sex = [_userInfo.sex integerValue];
    NSString *status = [NSString stringWithFormat:@"%ld",(long)_personStatus];
    if(![id isEqualToString:@""])
    {
        //看某文件是否存在
        NSString *filePath = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],id]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath] != NO)
        {
            return filePath;
        }
        else
        {
            if (sex == 0)
            {
                if ([status isEqualToString:@"0"])//离线
                {
                    status = @"fm_offline.png";
                }
                else if ([status isEqualToString:@"2"])//忙碌
                {
                    status = @"fm_busy.png";
                }
                else if ([status isEqualToString:@"3"])//离开
                {
                    status = @"fm_invisible.png";
                }
                else if ([status isEqualToString:@"4"])//隐身
                {
                    status = @"fm_offline.png";
                }
                else
                {
                    status = @"fm_online.png";
                }
            }
            else
            {
                if ([status isEqualToString:@"0"])//离线
                {
                    status = @"m_offline.png";
                }
                else if ([status isEqualToString:@"2"])//忙碌
                {
                    status = @"m_busy.png";
                }
                else if ([status isEqualToString:@"3"])//离开
                {
                    status = @"m_invisible.png";
                }
                else if ([status isEqualToString:@"4"])//隐身
                {
                    status = @"m_offline.png";
                }
                else
                {
                    status = @"m_online.png";
                }
            }
        }
        return status;
    }
    return nil;
}



#pragma mark -
#pragma mark buttonPressed Methods

- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)watchHistory:(UIButton *)sender
{
    ChatHistoryViewController *chatHistory = [[ChatHistoryViewController alloc] initWithNibName:nil bundle:nil];
    chatHistory.conFeed = _conFeed;
    [self.navigationController pushViewController:chatHistory animated:YES];
    [chatHistory release];
    
}

- (void)clearMess:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清空聊天记录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10086;
    [alertView show];
    [alertView release];
    
}


- (void)addPersonBtnTap:(id)sender
{
    LinkMakeGroupViewController *linkMakeGroupView = [[LinkMakeGroupViewController alloc] init];
    [[LinkDataHelper sharedService] readDistanceDataBase];
    User *selfUser = [[LinkDataHelper sharedService] getUserWithUserId:_conFeed.loginId];
    [[LinkDataHelper sharedService] closeDistanceDatabase];

    linkMakeGroupView.choosedUsers = [NSMutableArray arrayWithObjects:_userInfo,selfUser, nil];
    linkMakeGroupView.sendType = MultiChat_type;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:linkMakeGroupView animated:YES];
    [linkMakeGroupView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handling long presses Methods

-(void)handleLongPress:(UILongPressGestureRecognizer*)longPressRecognizer
{
    NSString *userid = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    if (longPressRecognizer.state == UIGestureRecognizerStateBegan)
    {
        User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userid];
        self.customAllertView = [[[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:user] autorelease];
        [self.view addSubview:_customAllertView];
        _customAllertView.delegate = self;
    }
}

-(void)contactAlertViewWith:(id)object withStyel:(ContactBtnStyle)style
{
    switch (style) {
        case ContactBtn_callPhone:
            [self contactsListViewCallPhone:[(User *)object telephone]];
            break;
        case ContactBtn_callMobile:
            [self contactsListViewCallMobilePhone:[(User *)object mobile]];
            break;
        case ContactBtn_addPerson:
        {
            [self contactsAddPerson:(User *)object];
        }
            break;
        case ContactBtn_sendMess:
            [self contactsListViewSendSMS:[NSArray arrayWithObject:(User *)object]];
            break;
        default:
            break;
    }
}

#pragma mark - contacts method
-(void)contactsListViewCallMobilePhone:(NSString *)mobile
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",mobile]]];
}

-(void)contactsListViewCallPhone:(NSString *)telPhone
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telPhone]]];
}

-(void)contactsListViewSendEmail:(User *)user
{
    [MailHelp sharedService].recipients = [NSArray arrayWithObjects:user.email, nil];
    [MailHelp sharedService].isShowScreenShot = NO;
    [[MailHelp sharedService] sendMailWithPresentViewController:self];
}

-(void)contactsListViewSendSMS:(NSArray *)array
{
    NSString *phoneStr = @"";
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select userid, nickname, sex, usersig, telephone, mobile, email, field_char1 from im_users where userid=?;"];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    if ([rs next])
    {
        phoneStr = [rs stringForColumn:@"mobile"];
    }
    [rs close];
    [distanceDataBase close];
    
    if (![phoneStr length])
    {
        [ShowAlertView showAlertViewStr:@"您的帐号还未绑定手机号码"];
        return;
    }
    GroupSendMsgViewController *sendMsg = [[GroupSendMsgViewController alloc] initWithNibName:nil bundle:nil];
    sendMsg.phoneStr = phoneStr;
    sendMsg.selectArr = [NSMutableArray arrayWithArray:array];
    [self.navigationController pushViewController:sendMsg animated:YES];
    [sendMsg release];
}

-(void)contactsAddPerson:(User *)user
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:user];
    [_synView synContacts:array];
}


#pragma mark -
#pragma mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10086)
    {
        if (buttonIndex == 1) {
            BOOL result = [[ChatDataHelper sharedService] deleteMessagesWithRelativeId:_conFeed.relativeId  withToUserId:[_conFeed.loginId intValue]];
            if (result)
            {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAllMessages object:nil];
            }

        }
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
