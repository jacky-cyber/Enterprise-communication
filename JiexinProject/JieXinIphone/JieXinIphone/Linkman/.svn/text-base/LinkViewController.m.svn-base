//
//  LinkViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkViewController.h"
#import "ContactGroupView.h"
#import "LinkMakeGroupViewController.h"
#import "CreateGroupViewController.h"
#import "SynContacts.h"
#import "LinkContactsView.h"
#import "KxMenu.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
#import "GroupDataHelper.h"
//test
#import "GroupEditViewController.h"

#import "GroupSendMsgViewController.h"
#import "SynUserInfo.h"

#define Department_BTN  50001
#define Group_BTN 50002
#define Contact_BTN 50003

@interface LinkViewController ()
{
    LinkDepartmentView *_linkDepartmentView;
    ContactGroupView *_contactGroupView;
    LinkContactsView *_linkContactsView;
    LinkMakeGroupViewController *_linkMakeGroupViewController;
    
    UIButton *_searchBtn;
    UIButton *_addChatBtn;
    
    SynContacts *_synView;
    BOOL _isRequested;
}
@end

@implementation LinkViewController
@synthesize personSelectedArr;

#pragma mark -
#pragma mark Initialization Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        state = Dep_state;
        _isRequested = NO;
        
        NSMutableArray *tempPersonSelectArray = [[NSMutableArray alloc] init];
        self.personSelectedArr = tempPersonSelectArray;
        [tempPersonSelectArray release];
    }
    return self;
}

- (void)loadSubViews
{
     _synView = [[SynContacts alloc] init];
    
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_bg1.png"]];
    topView = tmpView;
    topView.frame = CGRectMake(0, self.iosChangeFloat +44, kScreen_Width, 45);
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    [tmpView release];
    
    //下面加一条线
    UIImageView *footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line2.png"]];
    footerView.frame = CGRectMake(0, 44, kScreen_Width, 1);
    footerView.backgroundColor = [UIColor redColor];
    footerView.userInteractionEnabled = YES;
    [topView addSubview:footerView];
    [footerView release];

    //部门选项
    depBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    depBtn.frame = CGRectMake(0, 0, 320/3, 45);
    depBtn.selected = YES;
    depBtn.tag = Department_BTN;
    [depBtn setTitle:@"部门" forState:UIControlStateNormal];
    [depBtn setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
    [depBtn setTitleColor:kDarkerGray forState:UIControlStateNormal];
    [depBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
    [depBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    depBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:kCommonFont + 4];
    [topView addSubview:depBtn];
    [topView bringSubviewToFront:depBtn.titleLabel];
    
    //群组选项
    groupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    groupBtn.frame = CGRectMake(320/3, 0, 320/3, 44);
    groupBtn.tag = Group_BTN;
    [groupBtn setTitle:@"群组" forState:UIControlStateNormal];
//    groupBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:kCommonFont+4];
    [groupBtn setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
    [groupBtn setTitleColor:kDarkerGray forState:UIControlStateNormal];
    [groupBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
    [groupBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    groupBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:kCommonFont + 4];
    [topView addSubview:groupBtn];
    
    //联系人选项
    contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contactBtn.frame = CGRectMake(640/3, 0, 320/3, 44);
    contactBtn.tag = Contact_BTN;
    [contactBtn setTitle:@"通讯录" forState:UIControlStateNormal];
    contactBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:kCommonFont + 4];
    [contactBtn setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
    [contactBtn setTitleColor:kDarkerGray forState:UIControlStateNormal];
    [contactBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
    [contactBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:contactBtn];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat +44+45, kScreen_Width, self.view.bounds.size.height - (self.iosChangeFloat +44) - kTabbarHeight- 45)];
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    
    //加载初始化页面
    _linkDepartmentView = [[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,bgView.bounds.size.height) withLinkViewStyle:LinkDepartmentView_search];
    _linkDepartmentView.delegate = self;
    [bgView addSubview:_linkDepartmentView];
    [_linkDepartmentView release];
//    _linkContactsView = [[LinkContactsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,bgView.bounds.size.height)];
//    [bgView addSubview:_linkContactsView];
    
    
    //搜索按钮
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setFrame:CGRectMake(225, self.iosChangeFloat+10, 25, 25)];
    [_searchBtn setImage:[UIImage imageNamed:@"searchLink.png"] forState:UIControlStateNormal];
    _searchBtn.selected = NO;
    [self.view addSubview:_searchBtn];
    [_searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    _addChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addChatBtn setFrame:CGRectMake(270, self.iosChangeFloat+8, 35, 25)];
    [_addChatBtn setImage:[UIImage imageNamed:@"chat_add.png"] forState:UIControlStateNormal];
    [self.view addSubview:_addChatBtn];
    [_addChatBtn addTarget:self action:@selector(addChat:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadRelatedBtn
{
    createGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createGroupBtn.frame = CGRectMake(225, self.iosChangeFloat+10, 25, 25);
    createGroupBtn.tintColor = [UIColor clearColor];
    [createGroupBtn setImage:[UIImage imageNamed:@"add_group.png"] forState:UIControlStateNormal];
//    [createGroupBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 17, 0, 17)];
    [createGroupBtn addTarget:self action:@selector(createNewGroup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createGroupBtn];
    createGroupBtn.hidden = YES;
    
    deleteBatch = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBatch.frame = CGRectMake(270, self.iosChangeFloat+8, 35, 25);
    deleteBatch.tintColor = [UIColor clearColor];
    [deleteBatch setImage:[UIImage imageNamed:@"exit_batch.png"] forState:UIControlStateNormal];
    [deleteBatch addTarget:self action:@selector(deleteBatch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBatch];
    deleteBatch.hidden = YES;
    
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(270, self.iosChangeFloat+8, 35, 25);
    doneBtn.tintColor = [UIColor clearColor];
    [doneBtn setImage:[UIImage imageNamed:@"exit_batch.png"] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    doneBtn.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDataNotification:)
                                                 name:@"CreateTmpGroupRet"
                                               object:nil];
    
    [super createCustomNavBar];
    
    [self loadSubViews];
    [self loadRelatedBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
//    
//    if (_contactGroupView)
//    {
//        [_contactGroupView release];
//        _contactGroupView = nil;
//
//        _contactGroupView = [[ContactGroupView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,bgView.bounds.size.height)];
//        _contactGroupView.pushDelegate = self;
//        [bgView addSubview:_contactGroupView];
//        [_contactGroupView requestGroupList];
//        [_contactGroupView release];
//    }
    
    switch (state)
    {
        case Dep_state:
        {
            [bgView bringSubviewToFront:_linkDepartmentView];
        }break;
        case Group_state:
        {
            [bgView bringSubviewToFront:_contactGroupView];
        }break;
        case Contact_state:
        {
            [bgView bringSubviewToFront:_linkContactsView];
        }break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ButtonPressed Methods

- (void)buttonPressed:(UIButton *)btn
{
    switch (btn.tag) {
        case Department_BTN:
        {
            if (!btn.selected)
            {
                state = Dep_state;
                createGroupBtn.hidden = YES;
                _searchBtn.hidden = NO;
                _addChatBtn.hidden = NO;
                deleteBatch.hidden = YES;
                doneBtn.hidden = YES;
                if (_contactGroupView) {
                    _contactGroupView.isCanSelect = NO;
//                    [_contactGroupView requestGroupList];
                    [_contactGroupView.listView reloadData];
                }
                btn.selected = !btn.selected;
                groupBtn.selected = !btn.selected;
                contactBtn.selected = !btn.selected;
                if (!_linkDepartmentView)
                {
                    _linkDepartmentView = [[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,bgView.bounds.size.height) withLinkViewStyle:LinkDepartmentView_normal];
                    [bgView addSubview:_linkDepartmentView];
                    [_linkDepartmentView release];
                }
                else
                {
                    [bgView bringSubviewToFront:_linkDepartmentView];
                }
            }
        }break;
        case Group_BTN:
        {
            if (!btn.selected)
            {
                state = Group_state;
                createGroupBtn.hidden = NO;
                _searchBtn.hidden = YES;
                _addChatBtn.hidden = YES;
                deleteBatch.hidden = NO;
                doneBtn.hidden = YES;
                btn.selected = !btn.selected;
                depBtn.selected = !btn.selected;
                contactBtn.selected = !btn.selected;
                if (!_contactGroupView)
                {
                    _contactGroupView = [[ContactGroupView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,bgView.bounds.size.height)];
                    _contactGroupView.backgroundColor = [UIColor whiteColor];
                    _contactGroupView.pushDelegate = self;
                    [bgView addSubview:_contactGroupView];
                    [_contactGroupView release];
                }
                [bgView bringSubviewToFront:_contactGroupView];
                [_contactGroupView requestGroupList];
            }

        }break;
        case Contact_BTN:
        {
            if (!btn.selected)
            {
                state = Contact_state;
                createGroupBtn.hidden = YES;
                _searchBtn.hidden = YES;
                _addChatBtn.hidden = YES;
                deleteBatch.hidden = YES;
                doneBtn.hidden = YES;
                if (_contactGroupView) {
                    _contactGroupView.isCanSelect = NO;
                    [_contactGroupView.listView reloadData];
                }

                state = Contact_state;
                btn.selected = !btn.selected;
                depBtn.selected = !btn.selected;
                groupBtn.selected = !btn.selected;
                if (!_linkContactsView)
                {
                    _linkContactsView = [[LinkContactsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,bgView.bounds.size.height)];
                    _linkContactsView.delegate = self;
                    [bgView addSubview:_linkContactsView];
                    [_linkContactsView release];
                    //[_linkContactsView getAddressBookDataModel];
                    [_linkContactsView performSelector:@selector(getAddressBookDataModel) withObject:nil afterDelay:0.1];
                }
                else
                {
                    [bgView bringSubviewToFront:_linkContactsView];
                    [_linkContactsView whetherCanVisitAddressBook];
                }
            }
        }break;
            
        default:
            break;
    }
}

- (void)deleteBatch:(UIButton *)sender
{
    _contactGroupView.isCanSelect = YES;
    
    deleteBatch.hidden = YES;
    doneBtn.hidden = NO;
    
    [_contactGroupView.listView reloadData];
}

- (void)doneDeleteAction:(UIButton *)sender
{
    _contactGroupView.isCanSelect = NO;
    doneBtn.hidden = YES;
    deleteBatch.hidden = NO;

    if ([_contactGroupView.groupChoose count]!=0)
    {
        NSString *groupid = @"";
        for (int i = 0; i < [_contactGroupView.groupChoose count]-1; ++i)
        {
            groupid = [[groupid stringByAppendingString:[[_contactGroupView.groupChoose objectAtIndex:i] objectForKey:@"id"]] stringByAppendingString:@","];
        }
        groupid = [groupid stringByAppendingString:[[_contactGroupView.groupChoose lastObject] objectForKey:@"id"]];
        
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        
        NSArray *offLineArr = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"DelGroupBatch"},@{@"GroupId": groupid}];
        
        NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
        [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
        [[STHUDManager sharedManager] showHUDInView:_contactGroupView];
    }
    
    [_contactGroupView.listView reloadData];
}

- (void)createNewGroup:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"创建群组"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:) index:FormalGroup],
      
      [KxMenuItem menuItem:@"创建讨论组"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:) index:TempGroup]
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+15, sender.frame.size.width, sender.frame.size.height) menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {
        KxMenuItem *item = (KxMenuItem *)sender;
        GroupType grouptype = (GroupType)item.index;
        
        CreateGroupViewController *cgvc = [[CreateGroupViewController alloc] initWithType:grouptype];
        [self.navigationController pushViewController:cgvc animated:YES];
        [cgvc release];
    }
}

- (void)pushToGroupChatView:(NSDictionary *)dic
{
    NSString *groupid = [dic objectForKey:@"id"];
    [self.navigationController popToRootViewControllerAnimated:NO];
    //跳转到群聊天页面
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

- (void)pushToSendMess:(NSArray *)array withGroupId:(NSString *)groupid
{
    
    [self contactsListViewSendSMS:array withGroupId:groupid];
}

#pragma mark - button method
-(void)search:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(!sender.selected)
    {
        if([_linkDepartmentView viewWithTag:113122]&&_linkDepartmentView.linkSearchResultView)
        {
            [_linkDepartmentView.linkSearchResultView removeFromSuperview];

            [_linkDepartmentView.searchTextField resignFirstResponder];

        }
        [_linkDepartmentView.searchTextField resignFirstResponder];
    }
    
    if(_linkDepartmentView)
        [_linkDepartmentView showOrHideSearchViewWith:sender.isSelected];
}

-(void)addChat:(UIButton *)sender
{
//    [self groupChat:nil];
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"多人会话"
                     image:nil
                    target:self
                    action:@selector(pushChatItem:) index:0],
      
      [KxMenuItem menuItem:@"群发短信"
                     image:nil
                    target:self
                    action:@selector(pushChatItem:) index:1]
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+15, sender.frame.size.width, sender.frame.size.height) menuItems:menuItems];
}

- (void) pushChatItem:(id)sender
{
    if([sender isKindOfClass:[KxMenuItem class]])
    {
        KxMenuItem *item = (KxMenuItem *)sender;
        int buttonIndex = item.index;
        
        switch (buttonIndex) {
            case 0:
            {
                LinkMakeGroupViewController *linkMakeGroupView = [[LinkMakeGroupViewController alloc] init];
//                [self.navigationController pushViewController:linkMakeGroupView animated:YES];
                [[AppDelegate shareDelegate].rootNavigation pushViewController:linkMakeGroupView animated:YES];
                linkMakeGroupView.sendType = MultiChat_type;
                [linkMakeGroupView release];
            }break;
            case 1:
            {
                LinkMakeGroupViewController *linkMakeGroupView = [[LinkMakeGroupViewController alloc] init];
                linkMakeGroupView.sendType = MultiDuanxin_type;
                [[AppDelegate shareDelegate].rootNavigation pushViewController:linkMakeGroupView animated:YES];
                [linkMakeGroupView release];
            }break;
                
            default:
                break;
        }
    }
}


#pragma mark - LinkContactsView Delegate method
-(void)linkContactsCallPhone:(ContactsBt *)sender
{
    [self contactsListViewCallMobilePhone:sender.btStr];
}

-(void)linkContactsSendSMS:(ContactsBt *)sender
{
//    [self contactsListViewSendSMS:[NSArray arrayWithObject:sender.user] withGroupId:nil];
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    if (canSendSMS) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body = @"";
        picker.recipients = [NSArray arrayWithObjects:sender.user.mobile, nil];
        [self presentViewController:picker animated:YES completion:NULL];
        [picker release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打开短信失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }

}

#pragma mark - LinkDepartmentDelegate method
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
            [self contactsListViewSendSMS:[NSArray arrayWithObject:(User *)object ] withGroupId:nil];
            break;
        default:
            break;
    }
}

-(void)contactsAddPerson:(User *)user
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:user];
    [_synView synContacts:array];
}

-(void)groupChat:(Department *)deparment
{
//    if(!_linkMakeGroupViewController)
//    {
//        _linkMakeGroupViewController = [[LinkMakeGroupViewController alloc] init];
//    }
//    [self.navigationController pushViewController:_linkMakeGroupViewController animated:YES];
    deparment.allSubUsers =[NSArray arrayWithArray:[[LinkDateCenter sharedCenter] getAllSubUsersArrayWithDepartmentId:deparment.departmentid]];
    [self createGroupChat:deparment];
}

-(void)sendGroupMess:(Department *)department
{
    //查询部门下所有的用户
    NSArray *userArrays = [[LinkDateCenter sharedCenter] getAllSubUsersArrayWithDepartmentId:department.departmentid];
//    NSMutableArray *mobileArray = [[NSMutableArray alloc] init];
//    for(User *user in userArrays)
//    {
//        if(user.mobile && ![user.mobile isEqualToString:@""])
//            [mobileArray addObject:user.mobile];
//    }
    [self contactsListViewSendSMS:userArrays withGroupId:nil];
//    [mobileArray release];
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

-(void)contactsListViewSendSMS:(NSArray *)array withGroupId:(NSString *)groupid
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
    if (groupid) {
        sendMsg.groupid = groupid;
    }
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
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:title
                                                   message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark - 创建多人会话
- (void)createGroupChat:(Department *)deparment
{
    NSString *depName = deparment.departmentname;
    [[NSUserDefaults standardUserDefaults] setObject:depName forKey:@"DEPNAME"];
    NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:deparment.allSubUsers];
    if ([tmpArray count]==0) {
        return;
    }

    for (User *user in tmpArray)
    {
        [personSelectedArr addObject:user.userid];
    }
    
    NSString *memberID = @"";
    for (int i = 0;i < [personSelectedArr count]-1;++i)
    {
        memberID = [[memberID stringByAppendingString:[personSelectedArr objectAtIndex:i]] stringByAppendingString:@","];
    }
    memberID = [memberID stringByAppendingString:[personSelectedArr lastObject]];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *offLineArr = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"CreateGroup"},@{@"GroupName":depName},@{@"GroupType":@"2"},@{@"createId":sessionId},@{@"MemberId":memberID}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
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
    
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *groupid = [infoDic objectForKey:@"GroupId"];
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSInteger gtype = [[infoDic objectForKey:@"GroupType"] integerValue];
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEPNAME"];
        
        //添加name
        NSString *queryStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (groupType,groupId,groupName,creatorID) VALUES (%d,'%@','%@','%@')",(int)gtype,groupid,name,sessionId];
        [[GroupDataHelper sharedService] operateGroupDB:queryStr];
        
        NSDictionary *groupInfo = @{@"groupid":groupid,@"groupname":name};
        [[NSNotificationCenter defaultCenter] postNotificationName:kForumCreateSucceed
                                                            object:nil
                                                          userInfo:groupInfo];
        [self.navigationController popToRootViewControllerAnimated:NO];
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
    else
    {
        [ShowAlertView showAlertViewStr:@"创建多人会话失败"];
    }
    _isRequested = NO;
}


#pragma mark -
#pragma mark Dealloc Method

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateTmpGroupRet" object:nil];
    [_synView release];
    [depBtn release];
    [groupBtn release];
    [contactBtn release];
    [_linkMakeGroupViewController release];
    [_linkDepartmentView release];
    [_contactGroupView release];
    [topView release];
    [bgView release];
    [super dealloc];
}

@end
