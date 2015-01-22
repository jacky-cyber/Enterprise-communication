//
//  LinkMakeGroupViewController.m
//  JieXinIphone
//
//  Created by tony on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkMakeGroupViewController.h"
#import "LinkDepartmentView.h"
#import "GroupDataHelper.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
#import "LinkDateCenter.h"
#import "GroupSendMsgViewController.h"
#import "SynUserInfo.h"
@interface LinkMakeGroupViewController ()

@end

@implementation LinkMakeGroupViewController
{
    LinkDepartmentView *_linkDepartmentView;
    NSString *groupid;
    BOOL _isRequested;
}
@synthesize personSelectedArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isRequested = NO;
        
        NSMutableArray *tempPersonSelectArray = [[NSMutableArray alloc] init];
        self.personSelectedArr = tempPersonSelectArray;
        [tempPersonSelectArray release];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataNotification:)
                                                     name:@"CreateTmpGroupRet"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [super createCustomNavBarWithoutLogo];
    
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    switch (self.sendType) {
        case MultiDuanxin_type:
            titleLabel.text = @"群发短信";
            break;
        case MultiChat_type:
            titleLabel.text = @"多人会话";
            break;
        case SendOther_type:
            titleLabel.text = @"转发";
            break;
  
        default:
            break;
    }
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //确定按钮✅
    if (_sendType == MultiDuanxin_type||_sendType == MultiChat_type) {
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [confirm setFrame:CGRectMake(275, self.iosChangeFloat, 40, 40)];
        [confirm setTitle:@"确定" forState:UIControlStateNormal];
        [confirm setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
        confirm.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:confirm];
    }
    
    if (_sendType == SendOther_type) {
        _linkDepartmentView = [[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, 65, kScreen_Width,kScreen_Height - kNavHeight  - 20) withLinkViewStyle:LinkDepartmentView_normal];
    }
    else
    {
        _linkDepartmentView = [[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, 65, kScreen_Width,kScreen_Height - kNavHeight  - 20) withLinkViewStyle:LinkDepartmentView_select];
        for(User *user in self.choosedUsers)
        {
            [_linkDepartmentView.choosedUsers addObject:user];
        }
    }
    _linkDepartmentView.sendOtherMessage = _sendOtherMessage;
    [self.view addSubview:_linkDepartmentView];
    _linkDepartmentView.delegate = self;
    
	// Do any additional setup after loading the view.
}

- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)confirm
{
    if([_linkDepartmentView.choosedUsers count] <1 )
    {
        [self showAlertViewWithMess:@"请选人！"];
        return;
    }
    if(_sendType == MultiDuanxin_type)
        [self groupSendMessage];
    else if (_sendType == MultiChat_type)
        [self groupChat];
}

-(void)groupSendMessage
{
//    NSMutableArray *arr = [NSMutableArray array];
//    for(User *elem in _linkDepartmentView.choosedUsers)
//    {
//        if(elem.mobile && ![elem.mobile isEqualToString:@""])
//            [arr addObject:elem.mobile];
//    }
    [self contactsListViewSendSMS:_linkDepartmentView.choosedUsers];
}

-(void)groupChat
{
    NSLog(@"你选了用户数目%ld",(long)[_linkDepartmentView.choosedUsers count]);
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *usrName = [[NSUserDefaults standardUserDefaults] objectForKey:User_NickName];
    NSString *name = [NSString string];
    
    for(User *elem in _linkDepartmentView.choosedUsers)
    {
        [personSelectedArr addObject:elem.userid];
    }
    
    NSMutableArray *idArr = [NSMutableArray array];
   
    if ([personSelectedArr count] == 0)
    {
        name = usrName;
    }
    else if([personSelectedArr count] >= 2)
    {
        [idArr addObject:[personSelectedArr objectAtIndex:0]];
        [idArr addObject:[personSelectedArr objectAtIndex:1]];
        NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
        name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],[nameArr objectAtIndex:1]];
    }
    else
    {
        [idArr addObject:[personSelectedArr objectAtIndex:0]];
        NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
        name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],usrName];
    }
    
    //拼接群组成员
    NSString *memberID = @"";
    for (int i = 0;i < [personSelectedArr count]-1;++i)
    {
        memberID = [[memberID stringByAppendingString:[personSelectedArr objectAtIndex:i]] stringByAppendingString:@","];
    }
    memberID = [memberID stringByAppendingString:[personSelectedArr lastObject]];
 
    
    NSArray *msg = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"CreateGroup"},@{@"GroupName":name},@{@"GroupType":@"2"},@{@"createId":sessionId},@{@"MemberId":memberID}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg]];
    _isRequested = YES;
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    [[STHUDManager sharedManager] showHUDInView:self.view];
}

#pragma mark -
#pragma mark NotificationReturnDatas

- (void)receiveDataNotification:(NSNotification *)notification
{
    if (!_isRequested) {
        return;
    }
    [[STHUDManager sharedManager] hideHUDInView:self.view];

    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        groupid = [infoDic objectForKey:@"GroupId"];
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:User_NickName];
        NSInteger gtype = [[infoDic objectForKey:@"GroupType"] integerValue];
        NSString *name = [NSString string];
        
        NSMutableArray *idArr = [NSMutableArray array];
        if ([personSelectedArr count] == 0)
        {
            name = userName;
        }
        else if([personSelectedArr count] >= 2)
        {
            [idArr addObject:[personSelectedArr objectAtIndex:0]];
            [idArr addObject:[personSelectedArr objectAtIndex:1]];
            NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
            name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],[nameArr objectAtIndex:1]];
        }
        else
        {
            [idArr addObject:[personSelectedArr objectAtIndex:0]];
            NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
            name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],userName];
        }
        
//        NSDictionary *dic = @{@"gtype": [NSString stringWithFormat:@"%ld",(long)gtype],@"name":name,@"groupid":groupid,@"sessionId":sessionId};
       
        NSString *queryStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (groupType,groupId,groupName,creatorID) VALUES (%d,'%@','%@','%@')",(int)gtype,groupid,name,sessionId];
        [[GroupDataHelper sharedService] operateGroupDB:queryStr];
//        [[GroupDataHelper sharedService] insertAGroupToDb:infoDic];

        
        NSDictionary *groupInfo = @{@"groupid":groupid,@"groupname":name};
        [[NSNotificationCenter defaultCenter] postNotificationName:kForumCreateSucceed
                                                            object:nil
                                                          userInfo:groupInfo];
        ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
        ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        feed.isGroup = 1;
        feed.relativeId = [groupid intValue];
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        detail.conFeed = feed;
        [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
        [detail release];
        
//        NSString *notiInfo = [NSString stringWithFormat:@"您创建了多人会话"];
//        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:notiInfo delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [aler show];
//        [aler release];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"创建多人会话失败"];
    }
    _isRequested = NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag != 12132){
        //跳转到群聊页面
        ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
        ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        //这里要传群组的id
        feed.relativeId = [groupid intValue];
        feed.isGroup = 1;
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        detail.conFeed = feed;
        [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
        [detail release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.sendOtherMessage = nil;
    self.personSelectedArr = nil;
    self.choosedUsers = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateTmpGroupRet" object:nil];
    [super dealloc];
}

-(void)contactsListViewSendSMS:(NSArray *)array
{
//    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
//    if (canSendSMS) {
//        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
//        picker.messageComposeDelegate = self;
//        picker.body = @"";
//        picker.recipients = [NSArray arrayWithArray:array];
//        [self presentModalViewController:picker animated:YES];
//        [picker release];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打开短信失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//        
//    }

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

#pragma mark - messagedelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    NSString *msg;
    
    switch (result) {
        case MessageComposeResultCancelled:
            msg = @"发送取消";
            break;
        case MessageComposeResultSent:
            msg = @"发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MessageComposeResultFailed:
            msg = @"发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    NSLog(@"发送结果：%@", msg);
    
    [self dismissModalViewControllerAnimated:YES];
}
- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:title
                                                   message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)showAlertViewWithMess:(NSString *)mess
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:mess delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alertView.tag = 12132;
    [alertView show];
    [alertView release];
}
@end
