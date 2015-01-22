//
//  CreateGroupViewController.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-24.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "User.h"
#import "LinkDateCenter.h"
#import "GroupDataHelper.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"

@interface CreateGroupViewController ()
{
    BOOL _isRequested;
}

@end

@implementation CreateGroupViewController
@synthesize groupName;
@synthesize linkDepartmentView;
@synthesize personSelectedArr;
@synthesize type;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        _isRequested = NO;
//        self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
//       self.personSelectedArr = [[[NSMutableArray alloc] init] autorelease];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(receiveDataNotification:)
//                                                     name:@"CreateTmpGroupRet"
//                                                   object:nil];
//    }
//    return self;
//}


- (id)initWithType:(GroupType)groupType
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isRequested = NO;
        type = groupType;
        self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
        
        NSMutableArray *tempPersonSelectedArray = [[NSMutableArray alloc] init];
        self.personSelectedArr = tempPersonSelectedArray;
        [tempPersonSelectedArray release];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataNotification:)
                                                     name:@"CreateTmpGroupRet"
                                                   object:nil];
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, kScreen_Width, 45)];
    bgView.image = [UIImage imageNamed:@"searchLink_bg.png"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    //输入群组名
    self.groupName = [[[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-20, 45)] autorelease];
    groupName.backgroundColor = [UIColor clearColor];
    groupName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    groupName.placeholder = @"请输入群组名称";
    groupName.delegate = self;
    [bgView addSubview:groupName];
    
    //选人页面
    self.linkDepartmentView = [[[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44+45, kScreen_Width, kScreen_Height-(self.iosChangeFloat+44)-45-45) withLinkViewStyle:LinkDepartmentView_select] autorelease];
    [self.view addSubview:linkDepartmentView];
    
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.textColor = kDarkGray;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];

//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
//    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
//    titleLabel.font = [UIFont systemFontOfSize:16];

    if (type == FormalGroup)
    {
        titleLabel.text = @"创建群组";
    }
    else
    {
        titleLabel.text = @"创建讨论组";
    }
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //确定按钮✅
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    [confirm setFrame:CGRectMake(270, self.iosChangeFloat+10, 50, 22.5)];

//    [confirm setFrame:CGRectMake(275, self.iosChangeFloat, 40, 40)];

    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirm];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super createCustomNavBarWithoutLogo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ButtonPressed Methods

- (void)confirm
{
    [groupName resignFirstResponder];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:User_NickName];
    //获取群组成员
    for(User *elem in self.linkDepartmentView.choosedUsers)
    {
        [personSelectedArr addObject:elem.userid];
    }
    
    NSString *name = groupName.text;
    if (type == FormalGroup)
    {
        if (!name || [name isEqualToString:@""])
        {
            UIAlertView *alv = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入群组名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alv show];
            [alv release];
            return;
        }
    }
    else
    {
        if (!name || [name isEqualToString:@""])
        {
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
        }
    }
   
    //拼接群组成员
    NSString *memberID = [NSString string];
    if ([personSelectedArr count] == 0)
    {
        memberID = @"";
    }
    else
    {
        for (int i = 0;i < [personSelectedArr count]-1;++i)
        {
            memberID = [[memberID stringByAppendingString:[personSelectedArr objectAtIndex:i]] stringByAppendingString:@","];
        }
        memberID = [memberID stringByAppendingString:[personSelectedArr lastObject]];
    }
    
    //获取群组类型
    NSString *grouptype = [NSString stringWithFormat:@"%d",type];
    
    NSArray *msg = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"CreateGroup"},@{@"GroupName":name},@{@"GroupType":grouptype},@{@"createId":sessionId},@{@"MemberId":memberID}];
    
    _isRequested = YES;
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    [[STHUDManager sharedManager] showHUDInView:self.view];
}

- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark NotificationReturnDatas

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
        NSString *name = groupName.text;
        
        if (type == TempGroup)
        {
            if (!name || [name isEqualToString:@""])
            {
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

        ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
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

#pragma mark -
#pragma mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark TextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    groupName.text = @"";
    CGRect frame = textField.frame;
    int offset = self.view.frame.origin.y + frame.origin.y + 40 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [groupName resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark Touch Method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [groupName resignFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateTmpGroupRet" object:nil];
    [personSelectedArr release];
    [linkDepartmentView release];
    [groupName release];
    [super dealloc];
}

@end
