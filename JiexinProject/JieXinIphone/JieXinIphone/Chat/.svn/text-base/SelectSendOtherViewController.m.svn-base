//
//  SelectSendOtherViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-13.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SelectSendOtherViewController.h"
#import "LinkDepartmentView.h"
#import "ContactGroupView.h"
#import "LinkDateCenter.h"
#import "ChatDetailViewController.h"

#define Department_BTN  50001
#define Group_BTN 50002

@interface SelectSendOtherViewController ()<LinkDepartmentViewDelegate,NavPushDelegate>
{
    BOOL _isRequested;
    GroupType type;

}

@property (nonatomic, retain) UIView *mainBgView;
@property (nonatomic, retain) UIButton *depBtn;
@property (nonatomic, retain) UIButton *groupBtn;
@property (nonatomic, retain) LinkDepartmentView *linkDepartmentView;
@property (nonatomic, retain)   ContactGroupView *contactGroupView;
@property (nonatomic, retain) UIButton *confirmBtn;


@end

@implementation SelectSendOtherViewController

- (void)dealloc
{
    self.mainBgView = nil;
    self.depBtn = nil;
    self.groupBtn = nil;
    self.confirmBtn = nil;
    self.linkDepartmentView = nil;
    self.contactGroupView = nil;
    self.personSelectedArr = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initDefaultDatas];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataNotification:)
                                                     name:@"CreateTmpGroupRet"
                                                   object:nil];
    }
    return self;
}

- (void)initDefaultDatas
{
    self.personSelectedArr = [NSMutableArray array];
    _isRequested = NO;
    type = TempGroup;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomNavBarWithoutLogo];
    [self initSubViews];
    // Do any additional setup after loading the view.
}
- (void)initSubViews
{
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    [btn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"转发";
    [self.view addSubview:titleLabel];
    [titleLabel release];
    //确定按钮✅
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_confirmBtn setFrame:CGRectMake(270, self.iosChangeFloat+10, 50, 22.5)];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];

    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat +44, kScreen_Width, kScreen_Height  -20-kNavHeight)];
    self.mainBgView = aView;
    [self.view addSubview:_mainBgView];
    [aView release];
    
    
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_bg1.png"]];
    topImageView.frame = CGRectMake(0, 0, kScreen_Width, 45);
    topImageView.userInteractionEnabled = YES;
    [_mainBgView addSubview:topImageView];
    [topImageView release];
    
    //下面加一条线
    UIImageView *footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line2.png"]];
    footerView.frame = CGRectMake(0, 44, kScreen_Width, 1);
    footerView.backgroundColor = [UIColor redColor];
    footerView.userInteractionEnabled = YES;
    [topImageView addSubview:footerView];
    [footerView release];

    //部门选项
    self.depBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _depBtn.frame = CGRectMake(0, 0, 320/2, 45);
    _depBtn.selected = YES;
    _depBtn.tag = Department_BTN;
    [_depBtn setTitle:@"部门" forState:UIControlStateNormal];
    [_depBtn setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
    [_depBtn setTitleColor:kDarkerGray forState:UIControlStateNormal];
    [_depBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
    [_depBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _depBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:kCommonFont + 4];
    [topImageView addSubview:_depBtn];
    
    //群组选项
    self.groupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _groupBtn.frame = CGRectMake(320/2, 0, 320/2, 44);
    _groupBtn.tag = Group_BTN;
    [_groupBtn setTitle:@"群组" forState:UIControlStateNormal];
    [_groupBtn setBackgroundImage:[UIImage imageNamed:@"erji_select.png"] forState:UIControlStateSelected];
    [_groupBtn setTitleColor:kDarkerGray forState:UIControlStateNormal];
    [_groupBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateSelected];
    [_groupBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _groupBtn.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:kCommonFont + 4];
    [topImageView addSubview:_groupBtn];
    
    

    self.linkDepartmentView = [[[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(topImageView.frame), kScreen_Width,_mainBgView.bounds.size.height-CGRectGetHeight(topImageView.frame)) withLinkViewStyle:LinkDepartmentView_select] autorelease];
    _linkDepartmentView.delegate = self;
    _linkDepartmentView.sendOtherMessage = _sendOtherMessage;
    [_mainBgView addSubview:_linkDepartmentView];
    
    self.contactGroupView = [[[ContactGroupView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(topImageView.frame), kScreen_Width,_mainBgView.bounds.size.height-CGRectGetHeight(topImageView.frame))] autorelease];
    _contactGroupView.backgroundColor = [UIColor whiteColor];
    _contactGroupView.isCanLongPress = NO;
    _contactGroupView.pushDelegate = self;
    _contactGroupView.hidden = YES;
    [_mainBgView addSubview:_contactGroupView];

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
                _depBtn.selected = !btn.selected;
                _groupBtn.selected = !btn.selected;
                _confirmBtn.hidden = NO;
                _contactGroupView.hidden = YES;
                _linkDepartmentView.hidden = NO;
            }
        }break;
        case Group_BTN:
        {
            if (!btn.selected)
            {
                _groupBtn.selected = !btn.selected;
                _depBtn.selected = !btn.selected;
                _confirmBtn.hidden = YES;
                _contactGroupView.hidden = NO;
                _linkDepartmentView.hidden = YES;
                [_contactGroupView requestGroupList];

            }
            
        }break;
        default:
            break;
    }
}

- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)confirm
{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:User_NickName];
    //获取群组成员
    for(User *elem in self.linkDepartmentView.choosedUsers)
    {
        [self.personSelectedArr addObject:elem.userid];
    }
    
    NSString *name = nil;
    
    if (!name || [name isEqualToString:@""])
    {
        NSMutableArray *idArr = [NSMutableArray array];
        if ([self.personSelectedArr count] == 0)
        {
            name = userName;
        }
        else if([self.personSelectedArr count] >= 2)
        {
            [idArr addObject:[_personSelectedArr objectAtIndex:0]];
            [idArr addObject:[_personSelectedArr objectAtIndex:1]];
            NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
            name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],[nameArr objectAtIndex:1]];
        }
        else
        {
            [idArr addObject:[_personSelectedArr objectAtIndex:0]];
            NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
            name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],userName];
        }
    }
    
    //拼接群组成员
    NSString *memberID = [NSString string];
    if ([_personSelectedArr count] == 0)
    {
        memberID = @"";
    }
    else
    {
        for (int i = 0;i < [_personSelectedArr count]-1;++i)
        {
            memberID = [[memberID stringByAppendingString:[_personSelectedArr objectAtIndex:i]] stringByAppendingString:@","];
        }
        memberID = [memberID stringByAppendingString:[_personSelectedArr lastObject]];
    }
    //获取群组类型
    NSString *grouptype = [NSString stringWithFormat:@"%d",TempGroup];
    
    NSArray *msg = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"CreateGroup"},@{@"GroupName":name},@{@"GroupType":grouptype},@{@"createId":sessionId},@{@"MemberId":memberID}];
    
    _isRequested = YES;
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    [[STHUDManager sharedManager] showHUDInView:self.view];
}


- (void)receiveDataNotification:(NSNotification *)notification
{
    if (!_isRequested)
    {
        return;
    }
    
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    _isRequested = NO;
    
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *groupid = [infoDic objectForKey:@"GroupId"];
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:User_NickName];
        NSInteger gtype = [[infoDic objectForKey:@"GroupType"] integerValue];
        NSString *name = @"";
        
        if (type == TempGroup)
        {
            if (!name || [name isEqualToString:@""])
            {
                NSMutableArray *idArr = [NSMutableArray array];
                if ([_personSelectedArr count] == 0)
                {
                    name = userName;
                }
                else if([_personSelectedArr count] >= 2)
                {
                    [idArr addObject:[_personSelectedArr objectAtIndex:0]];
                    [idArr addObject:[_personSelectedArr objectAtIndex:1]];
                    NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
                    name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],[nameArr objectAtIndex:1]];
                }
                else
                {
                    [idArr addObject:[_personSelectedArr objectAtIndex:0]];
                    NSMutableArray *nameArr = [[LinkDateCenter sharedCenter] getAllUserNameSelectedByID:idArr];
                    name = [NSString stringWithFormat:@"%@,%@",[nameArr objectAtIndex:0],userName];
                }
            }
        }
        
        NSString *queryStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (groupType,groupId,groupName,creatorID) VALUES (%d,'%@','%@','%@')",(int)gtype,groupid,name,sessionId];
        [[GroupDataHelper sharedService] operateGroupDB:queryStr];
        
        if (type == TempGroup)
        {
            NSDictionary *groupInfo = @{@"groupid":groupid,@"groupname":name};
            [[NSNotificationCenter defaultCenter] postNotificationName:kForumCreateSucceed
                                                                object:nil
                                                              userInfo:groupInfo];
        }
        [self.navigationController popToRootViewControllerAnimated:NO];
        ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
        detail.sendOtherMessage = _sendOtherMessage;
        ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        //这里要传群组的id
        feed.relativeId = [groupid intValue];
        feed.isGroup = 1;
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        detail.conFeed = feed;
        [self.navigationController popViewControllerAnimated:NO];
        [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
        [detail release];
        
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"创建群组失败"];
    }
}

#pragma mark - 群组群发短信
- (void)pushToGroupChatView:(NSDictionary *)dic
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    NSString *groupid = [dic objectForKey:@"id"];
    //跳转到群聊天页面
    ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
    detail.sendOtherMessage = _sendOtherMessage;
    ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    //这里要传群组的id
    feed.relativeId = [groupid intValue];
    feed.isGroup = 1;
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    
    detail.conFeed = feed;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
    [detail release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
