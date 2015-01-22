//
//  GroupEditViewController.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-26.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "GroupEditViewController.h"
#import "LinkDateCenter.h"
#import "LinkDataHelper.h"
#import "User.h"
#import "GroupDataHelper.h"
#import "ChatHistoryViewController.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
#import "MailHelp.h"
#import "SynContacts.h"
#import "GroupSendMsgViewController.h"
#import "SynUserInfo.h"
#import "SynUserIcon.h"

#define page_Margin 0
#define Cell_Height 80
#define Cell_Width 75
#define Constant   4567
#define ScrollView_Width 300
#define AlertTag  5671

typedef enum{
    ADD_Operate = 1,
    DEL_Operate,
}operatorType;

@interface GroupEditViewController ()
{
    UIScrollView *_sv;
}

@property (nonatomic, retain) UITapGestureRecognizer *tapGestureTel2;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureTel;
@property (nonatomic, retain)     SynContacts *synView;


@end

@implementation GroupEditViewController
{
    BOOL _canDelete;
    BOOL _hasPower;   //是否为群主
}

@synthesize membersView;
@synthesize groupid,creatorid;
@synthesize editBtn,doneBtn;
@synthesize membersArr;
@synthesize pageControl;
@synthesize linkDepartmentView;
@synthesize personWillDelete;
@synthesize tapGestureTel;
@synthesize tapGestureTel2;
@synthesize titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.membersArr = [[[NSMutableArray alloc] init] autorelease];
        self.personWillDelete = [[[NSMutableArray alloc] init] autorelease];
        isCanSelect = NO;
        _canDelete = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupMemberDataNotification:)
                                                     name:kGroupMemberData
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupMemberChangeDataNotification:)
                                                     name:kGroupMemberChangesData
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeleteMasterNotification:)
                                                     name:kGroupDeleteMaster
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDeleteMassNotification:)
                                                     name:kGroupDeleteMass
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveStatusNotification:)
                                                     name:kGetUserStatus object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveRenameNotification:)
                                                     name:kRenameGroupName object:nil];
    }
    return self;
}

- (id)initWithGroupid:(NSString *)groupstr
{
    self = [super init];
    if (self) {
        self.groupid = groupstr;
        self.creatorid = [[GroupDataHelper sharedService] getGroupCreatorByid:groupid];
       
        groupType = [[GroupDataHelper sharedService] getGroupTypeByid:groupid];
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        if ([creatorid isEqualToString:sessionId]) {
            _hasPower = YES;
        }
        else
        {
            _hasPower = NO;
        }
    }
    return self;
}

- (void)loadSubviews
{
    _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, 320, kScreen_Height-20-44)];
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_sv];
    [_sv release];
    
    self.synView = [[[SynContacts alloc] init] autorelease];
    UIImageView *bgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 10)];
    bgView1.image = [UIImage imageNamed:@"list_bg5-2.png"];
    bgView1.userInteractionEnabled = YES;
    [_sv addSubview:bgView1];
    [bgView1 release];
    
    UIImageView *bgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+330, 300, 10)];
    bgView2.image = [UIImage imageNamed:@"list_bg5.png"];
    bgView2.userInteractionEnabled = YES;
    [_sv addSubview:bgView2];
    [bgView2 release];
    
    UIImageView *bgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+10, 300, 320)];
    bgView3.image = [UIImage imageNamed:@"list_bg4.png"];
    bgView3.userInteractionEnabled = YES;
    [_sv addSubview:bgView3];
    [bgView3 release];
    
    self.membersView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 340)] autorelease];
    membersView.showsVerticalScrollIndicator = NO;
    membersView.showsHorizontalScrollIndicator = NO;
    membersView.pagingEnabled = YES;
    membersView.delegate = self;
    [bgView3 addSubview:membersView];
   
    self.tapGestureTel2 = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)]autorelease];
    [tapGestureTel2 setNumberOfTapsRequired:2];
    [self.membersView addGestureRecognizer:tapGestureTel2];
    
    
    
    //右上角
   self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(280, self.iosChangeFloat+10, 30, 22.5);
    editBtn.tintColor = [UIColor clearColor];
    if (!_hasPower) {
        editBtn.hidden = YES;
    }
    [editBtn setImage:[UIImage imageNamed:@"add_lxr.png"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(changeMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    
    //右上角
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(270, self.iosChangeFloat+10, 50, 22.5);
//    doneBtn.tintColor = [UIColor clearColor];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [doneBtn setTitleColor:kMAIN_THEME_COLOR forState:UIControlStateNormal];
//    [doneBtn setImage:[UIImage imageNamed:@"add_lxr.png"] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(changeMemberDone:) forControlEvents:UIControlEventTouchUpInside];
    doneBtn.hidden = YES;
    [self.view addSubview:doneBtn];
    
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//<<<<<<< .mine
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.font = [UIFont boldSystemFontOfSize:16];
//=======
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 200, kNavHeight)] autorelease];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:16];
    
    titleLabel.text = @"群组资料";
    [self.view addSubview:titleLabel];
    
    //历史记录按钮
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(10, 200+160, 140, 45);
    [historyBtn setImage:[UIImage imageNamed:@"lishi_jilu.png"] forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(watchHistory:) forControlEvents:UIControlEventTouchUpInside];
    [_sv addSubview:historyBtn];
    
    //清空聊天记录
    UIButton *clearMessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearMessBtn.frame = CGRectMake(170, 200+160, 140, 45);
    [clearMessBtn setImage:[UIImage imageNamed:@"clear_lishi.png"] forState:UIControlStateNormal];
    [clearMessBtn addTarget:self action:@selector(clearMess:) forControlEvents:UIControlEventTouchUpInside];
    [_sv addSubview:clearMessBtn];
    
    //修改名称
    UIButton *renameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    renameBtn.frame = CGRectMake(10, 250+160, 300, 45);
    [renameBtn setImage:[UIImage imageNamed:@"xiugai_group.png"] forState:UIControlStateNormal];
//    renameBtn.tintColor = [UIColor clearColor];
//    [renameBtn setBackgroundColor:[UIColor yellowColor]];
//    [renameBtn setTitle:@"修改群组名称" forState:UIControlStateNormal];
//    [renameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    if (![creatorid isEqualToString:sessionId])
    {
        renameBtn.hidden = YES;
    }
    [renameBtn addTarget:self action:@selector(renameBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_sv addSubview:renameBtn];

    
    //退出/解散群组按钮
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(10, 300+160, 300, 45);
    quitBtn.tintColor = [UIColor clearColor];
    if ([creatorid isEqualToString:sessionId])
    {
        [quitBtn setImage:[UIImage imageNamed:@"jiesan_group.png"] forState:UIControlStateNormal];
    }
    else
    {
        [quitBtn setImage:[UIImage imageNamed:@"tuichu_group.png"] forState:UIControlStateNormal];
        quitBtn.frame = CGRectMake(10, 250+160, 300, 45);
    }

    [quitBtn addTarget:self action:@selector(quitGroup:) forControlEvents:UIControlEventTouchUpInside];
    [_sv addSubview:quitBtn];
    
    [_sv setContentSize:CGSizeMake(320, CGRectGetMaxY(quitBtn.frame)+5)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [super createCustomNavBarWithoutLogo];
    [self loadSubviews];
    [self getGroupMembers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [personWillDelete removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark GroupMembers Methods

- (void)loadGroupMembers
{
    int memberCount = [membersArr count];
    int pages = (memberCount - 1)/16 + 1;
    membersView.contentSize = CGSizeMake(300*pages, 340);
    
    if (!pageControl)
    {
        self.pageControl = [[[UIPageControl alloc] init] autorelease];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        pageControl.frame = CGRectMake(0, 0, 20, 5);
        pageControl.center = CGPointMake(membersView.center.x,10+328);
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        pageControl.numberOfPages = pages;
        pageControl.currentPage = 0;
        [_sv addSubview:pageControl];
    }
    else
    {
        pageControl.numberOfPages = pages;
    }

    for (int i = 0; i < memberCount; ++i)
    {
        NSArray *coordinateArr = [NSArray arrayWithArray:[self getMemberRowAndRank:i]];
        //以下参数从0开始
        int page = [[coordinateArr objectAtIndex:0] intValue];
        int row = [[coordinateArr objectAtIndex:1] intValue];
        int rank = [[coordinateArr objectAtIndex:2] intValue];
        
        CGRect rect = CGRectZero;
        rect = CGRectMake(page_Margin*(2*page+1)+Cell_Width*rank+page*ScrollView_Width, page_Margin+row*Cell_Height, Cell_Width, Cell_Height);
        [self initCellView:rect andUserIndex:i];
    }
}

- (void)initCellView:(CGRect)rect andUserIndex:(int)index
{
    UIView *bgView = [[UIView alloc] initWithFrame:rect];
    bgView.tag = index + Constant;
    [membersView addSubview:bgView];

    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 5, 40, 40)];
    NSString *imageInfo = [self getImageFromInfo:[membersArr objectAtIndex:index]];
    if ([imageInfo hasSuffix:@"jpg"]) {
        logoView.image = [UIImage imageWithContentsOfFile:imageInfo];
        int status = [[[membersArr objectAtIndex:index] objectForKey:@"status"] intValue];
        if (status == 0 || status ==4)
        {
            logoView.image = [self convertToGrayStyle:logoView.image];
        }
    }
    else
    {
        logoView.image = UIImageWithName(imageInfo);
    }
    logoView.tag = index + Constant;
    logoView.userInteractionEnabled = YES;
    [bgView addSubview:logoView];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [logoView addGestureRecognizer:longPressRecognizer];
    
    self.tapGestureTel = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressGestureRecognizer:)]autorelease];
    [tapGestureTel setNumberOfTapsRequired:1];
    [logoView addGestureRecognizer:tapGestureTel];
    
    [tapGestureTel requireGestureRecognizerToFail:tapGestureTel2];
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(17.5, 50, 40, 15)];
    titleLabel2.text = [[membersArr objectAtIndex:index] objectForKey:@"nickname"];
    titleLabel2.font = [UIFont systemFontOfSize:12];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel2];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setTag:(index+Constant)];
    delBtn.frame = CGRectMake(17.5, 5, 40, 40);
    [delBtn addTarget:self action:@selector(deleteMember:) forControlEvents:UIControlEventTouchUpInside];
//    [delBtn setBackgroundColor:[UIColor yellowColor]];
    [delBtn setImage:[UIImage imageNamed:@"deleteTag.png"] forState:UIControlStateNormal];
    [delBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 20)];
    delBtn.hidden = YES;
    [bgView addSubview:delBtn];
    [bgView bringSubviewToFront:delBtn];
}

#pragma mark -
#pragma mark Wobble Methods

-(void)BeginWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in membersView.subviews)
    {
        srand([[NSDate date] timeIntervalSince1970]);
        float rand=(float)random();
        CFTimeInterval t=rand*0.0000000001;
        [UIView animateWithDuration:0.1 delay:t options:0  animations:^
         {
             view.transform=CGAffineTransformMakeRotation(-0.05);
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  view.transform=CGAffineTransformMakeRotation(0.05);
              } completion:^(BOOL finished) {}];
         }];
    }
    [pool release];
}

-(void)EndWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in membersView.subviews)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             view.transform=CGAffineTransformIdentity;
         } completion:^(BOOL finished) {}];
    }
    [pool release];
}


#pragma mark -
#pragma mark Handling long presses Methods

-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    NSLog(@"tag:%d",gr.view.tag);
    if (_hasPower || groupType == TempGroup)
    {
        _canDelete = !_canDelete;
        if (_canDelete)
        {
            for (UIView *view in membersView.subviews)
            {
                for (id elem in view.subviews) {
                    if ([elem isKindOfClass:[UIButton class]])
                    {
                        UIButton *btn = (UIButton *)elem;
                        btn.hidden = NO;
                    }
                }
            }
            
            [self BeginWobble];
        }
        else
        {
            
            for (UIView *view in membersView.subviews)
            {
                for (id elem in view.subviews)
                {
                    if ([elem isKindOfClass:[UIButton class]])
                    {
                        UIButton *btn = (UIButton *)elem;
                        btn.hidden = YES;
                    }
                }
            }
            [self EndWobble];
            [self changeMembers:personWillDelete andOperator:DEL_Operate];
        }
    }

}


#pragma mark -
#pragma mark Handling long presses Methods

-(void)handleLongPress:(UILongPressGestureRecognizer*)longPressRecognizer
{
    int index = longPressRecognizer.view.tag - Constant;
    NSString *userid = [[membersArr objectAtIndex:index] objectForKey:@"userid"];
    if (longPressRecognizer.state == UIGestureRecognizerStateBegan)
    {
        User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userid];
        self.customAllertView = [[[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:user] autorelease];
        [self.view addSubview:_customAllertView];
        _customAllertView.delegate = self;
    }
}


-(void)pressGestureRecognizer:(UIGestureRecognizer *)gr
{
    int index = gr.view.tag - Constant;
    NSString *userid = [[membersArr objectAtIndex:index] objectForKey:@"userid"];
    ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
    ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    feed.isGroup = 0;
    feed.relativeId = [userid intValue];
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    detail.conFeed = feed;
    [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
    [detail release];
}

- (NSArray *)getMemberRowAndRank:(int)usrIndex
{
    int page = usrIndex/16;
    int row = (usrIndex - page*16)/4;
    int rank = (usrIndex - page*16)%4;
    NSArray *cdnArr = [NSArray arrayWithObjects:[NSNumber numberWithInt:page],[NSNumber numberWithInt:row],[NSNumber numberWithInt:rank],nil];
    
    return cdnArr;
}

- (NSString *)getImageFromInfo:(NSDictionary *)member
{
    NSString *id = [member objectForKey:@"userid"];
    NSInteger sex = [[member objectForKey:@"sex"] integerValue];
    NSString *status = [member objectForKey:@"status"];
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
    }

    return status;
}

- (void)clearGroupMembers
{
    for (UIView *view in membersView.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark -
#pragma mark buttonPressed Methods

- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)renameBtnPressed
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改群组名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改",nil];
//    UITextField * txt = [[UITextField alloc] init];
//    txt.backgroundColor = [UIColor whiteColor];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 199999;
//    txt.frame = CGRectMake(alert.center.x+65,alert.center.y+48, 150,23);
//    [alert addSubview:txt];
    [alert show];
}

- (void)changeMember:(UIButton *)sender
{
    isCanSelect = !isCanSelect;
    doneBtn.hidden = !isCanSelect;
    editBtn.hidden = isCanSelect;
    
    self.linkDepartmentView = [[LinkDepartmentView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat+44, kScreen_Width, kScreen_Height-(self.iosChangeFloat+44)) withLinkViewStyle:LinkDepartmentView_select];
    [linkDepartmentView.tableListView configRefreshType:NoRefresh];
    NSMutableArray *usersArr = [NSMutableArray array];
    for (NSDictionary *dic in membersArr)
    {
        User *user = [[User alloc] initWithAttributes:dic];
        [usersArr addObject:user];
        [user release];
    }
    linkDepartmentView.choosedUsers = usersArr;
    [self.view addSubview:linkDepartmentView];
}

- (void)changeMemberDone:(UIButton *)sender
{
    isCanSelect = !isCanSelect;
    doneBtn.hidden = !isCanSelect;
    editBtn.hidden = isCanSelect;
    
    if (linkDepartmentView)
    {
        //1、取出源id数组和返回id数组
        NSMutableArray *addArr = [NSMutableArray array];
//        NSMutableArray *delArr = [NSMutableArray array];
        NSMutableArray *feedbackArr = [NSMutableArray array];
        NSMutableArray *sourceArr = [NSMutableArray array];
        
        for (User *user in linkDepartmentView.choosedUsers)
        {
            [feedbackArr addObject:user.userid];
        }
        
        for (NSDictionary *dic in membersArr)
        {
            [sourceArr addObject:[dic objectForKey:@"userid"]];
        }
        
        //2、分别请求增加成员和减少成员
//        for (NSString *mid in sourceArr)
//        {
//            if (![feedbackArr containsObject:mid])
//            {
//                [delArr addObject:mid];
//            }
//        }
        
        for (NSString *mid in feedbackArr)
        {
            if (![sourceArr containsObject:mid])
            {
                [addArr addObject:mid];
            }
        }
        
        if ([addArr count] == 0) {
            [linkDepartmentView removeFromSuperview];
            return;
        }
        if ([addArr count]!=0)
        {
            [self changeMembers:addArr andOperator:ADD_Operate];
        }
        
//        if ([delArr count]!=0)
//        {
//            [self changeMembers:delArr andOperator:DEL_Operate];
//        }
        
        [linkDepartmentView removeFromSuperview];
    }
}

- (void)watchHistory:(UIButton *)sender
{
    ChatHistoryViewController *chatHistory = [[ChatHistoryViewController alloc] initWithNibName:nil bundle:nil];
    ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    feed.relativeId = [groupid intValue];
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    chatHistory.conFeed = feed;
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

- (void)quitGroup:(UIButton *)sender
{
    [self quitGroup];
}

- (void)deleteMember:(UIButton *)sender
{
    int index = sender.tag - Constant;
    __block CGRect newframe;
    for (int i = index; i < [membersArr count]; i++)
    {
        UIView *obj = [membersView viewWithTag:i + Constant];
        
        //抖动后重置Frame
        NSArray *coordinateArr = [NSArray arrayWithArray:[self getMemberRowAndRank:i]];
        //以下参数从0开始
        int page = [[coordinateArr objectAtIndex:0] intValue];
        int row = [[coordinateArr objectAtIndex:1] intValue];
        int rank = [[coordinateArr objectAtIndex:2] intValue];
        
        CGRect rect = CGRectMake(page_Margin*(2*page+1)+Cell_Width*rank+page*ScrollView_Width, page_Margin+row*Cell_Height, Cell_Width, Cell_Height);
        
        __block CGRect nextframe = rect;
        if (i == index)
        {
            //删除这个view
            [obj removeFromSuperview];
        }
        else
        {
            //重新设置后面view的tag
            obj.tag = i+Constant-1;
            for (UIView *v in obj.subviews)
            {
                int count = 0;
                if ([v isKindOfClass:[UIImageView class]]) {
                    v.tag = i+Constant - 1;
                    count++;
                }
                //把每个按钮的tag重新设置
                if ([v isMemberOfClass:[UIButton class]])
                {
                    v.tag = i+Constant - 1;
                    count++;
                }
                
                if (count == 2) {
                    break;
                }
            }
            //并且位置动画改变
            [UIView animateWithDuration:0.6 animations:^
             {
                 obj.frame = newframe;
             } completion:^(BOOL finished)
             {
                 
             }];
        }
        //记住上一个view的位置
        newframe = nextframe;
    }
    
     [personWillDelete addObject:[[membersArr objectAtIndex:index] objectForKey:@"userid"]];
    
//    [membersArr removeObjectAtIndex:index];
    int pages = ([membersArr count] - 1)/8 + 1;
    if ([membersArr count] == 0)
    {
        pages = 1;
    }
    [membersView setContentSize:CGSizeMake(pages*ScrollView_Width, 160)];
    
    if (!pageControl)
    {
        self.pageControl = [[[UIPageControl alloc] init] autorelease];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        pageControl.frame = CGRectMake(0, 0, 20, 5);
        pageControl.center = CGPointMake(membersView.center.x,10+328);
        pageControl.numberOfPages = pages;
        pageControl.currentPage = 0;
        [_sv addSubview:pageControl];
    }
    else
    {
        pageControl.numberOfPages = pages;
    }
       
}

#pragma mark -
#pragma mark socketConnection Methods

- (void)getGroupMembers
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"groupMember"},@{@"groupID": groupid}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)quitGroup
{
    [[STHUDManager sharedManager] showHUDInView:self.view];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    
    NSString *type = @"";
    if ([creatorid isEqualToString:sessionId]) //群主
    {
        type = @"1";
    }
    else  //非群主
    {
       type = @"2";
    }
    
    NSArray *offLineArr = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"DelGroup"},@{@"GroupId": groupid},@{@"Type": type}];
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)changeMembers:(NSMutableArray *)list andOperator:(operatorType)type  //1增加，2删除
{
    if ([list count]==0) {
        return;
    }
    [[STHUDManager sharedManager] showHUDInView:self.view];
    NSString *operate = [NSString stringWithFormat:@"%d",type];
    NSString *memberlist = @"";
    for (int i = 0; i < [list count]-1; ++i)
    {
        memberlist = [[memberlist stringByAppendingString:[list objectAtIndex:i]] stringByAppendingString:@","];
    }
    memberlist = [memberlist stringByAppendingString:[list lastObject]];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msgArr = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"GroupMem"},@{@"GroupId": groupid},@{@"Type": operate},@{@"MemberId": memberlist}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

#pragma mark -
#pragma mark NotificationReturnDatas

- (void)receiveGroupMemberDataNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {
        [membersArr removeAllObjects];
        NSString *listString = [infoDic objectForKey:@"list"];
        NSArray *usr = [listString componentsSeparatedByString:@";"];
        for (NSString *str in usr)
        {
            if ([str isEqualToString:@""]) {
                break;
            }
            NSMutableDictionary *dicTemp=[NSMutableDictionary dictionary];
            
            NSArray *status = [str componentsSeparatedByString:@","];
            [dicTemp setValue:[status objectAtIndex:0] forKey:@"userid"];
            [dicTemp setValue:[status objectAtIndex:1] forKey:@"status"];
            
            int statusValue = [[status objectAtIndex:1] intValue];
            if (statusValue == 1||statusValue == 5||statusValue == 6||statusValue == 7) {
                
                [membersArr insertObject:dicTemp atIndex:0];
            }
            else
            {
                [membersArr addObject:dicTemp];
            }
        }
        
        for (NSMutableDictionary *user in membersArr)
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic = [[LinkDateCenter sharedCenter] getUserNameByUserID:[user objectForKey:@"userid"]];
            [user setValue:[dic objectForKey:@"nickname"] forKey:@"nickname"];
            [user setValue:[dic objectForKey:@"usersig"] forKey:@"usersig"];
            [user setValue:[dic objectForKey:@"sex"] forKey:@"sex"];
        }
        
        //加载群组成员
        [self loadGroupMembers];
        self.titleLabel.text = [NSString stringWithFormat:@"群组资料(%d人)",[membersArr count]];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"获取群成员失败"];
    }
}

//改变群成员
- (void)receiveGroupMemberChangeDataNotification:(NSNotification *)notification
{
    [personWillDelete removeAllObjects];
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *str = [infoDic objectForKey:@"MemberId"];
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"getUserStatus"},@{@"userlist": str}];
        NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
        [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
        [[STHUDManager sharedManager] showHUDInView:self.view];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"更改群成员失败"];
    }
}

- (void)receiveDeleteMasterNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *gid = [infoDic objectForKey:@"GroupId"];
        NSString *gName = [[GroupDataHelper sharedService] getGroupNameByid:gid];
        NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM groupInfoTable WHERE groupId = '%@'",gid];
        [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
    
        NSString *msg = [NSString stringWithFormat:@"%@ 已经被解散",gName];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAConversation object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:gid,@"groupid", nil]];

        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        aler.tag = AlertTag;
        [aler show];
        [aler release];
                
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"操作失败"];
    }
}

- (void)receiveDeleteMassNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *gid = [infoDic objectForKey:@"GroupId"];
        NSString *gName = [[GroupDataHelper sharedService] getGroupNameByid:gid];
        NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM groupInfoTable WHERE groupId = '%@'",gid];
        [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
        
        NSString *nickName = [[[LinkDateCenter sharedCenter] getUserNameByUserID:[infoDic objectForKey:@"MemberId"]] objectForKey:@"nickname"];
        NSString *msg = [NSString stringWithFormat:@"%@已经退出 %@",nickName,gName];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAConversation object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:gid,@"groupid", nil]];
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        aler.tag = AlertTag;
        [aler show];
        [aler release];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"操作失败"];
    }
}

- (void)receiveStatusNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {
        NSMutableArray *memberChanged = [[NSMutableArray alloc] init];
        NSString *listString = [infoDic objectForKey:@"statuslist"];
        NSArray *usr = [listString componentsSeparatedByString:@";"];
        for (NSString *str in usr)
        {
            if ([str isEqualToString:@""]) {
                break;
            }
            NSMutableDictionary *dicTemp=[NSMutableDictionary dictionary];
            
            NSArray *status = [str componentsSeparatedByString:@","];
            [dicTemp setValue:[status objectAtIndex:0] forKey:@"userid"];
            [dicTemp setValue:[status objectAtIndex:1] forKey:@"status"];
            [memberChanged addObject:dicTemp];
        }
        
        for (NSMutableDictionary *user in memberChanged)
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic = [[LinkDateCenter sharedCenter] getUserNameByUserID:[user objectForKey:@"userid"]];
            [user setObject:[dic objectForKey:@"nickname"] forKey:@"nickname"];
            [user setObject:[dic objectForKey:@"usersig"] forKey:@"usersig"];
            [user setObject:[dic objectForKey:@"sex"] forKey:@"sex"];
        }
        
        for (NSDictionary *dic in memberChanged)
        {
            if ([membersArr containsObject:dic]) {
                [membersArr removeObject:dic];
            }
            else
            {
//                [membersArr addObject:dic];
                int statusValue = [[dic objectForKey:@"status"] intValue];
                if (statusValue == 1||statusValue == 5||statusValue == 6||statusValue == 7) {
                    
                    [membersArr insertObject:dic atIndex:0];
                }
                else
                {
                    [membersArr addObject:dic];
                }
            }
        }
        
        [self clearGroupMembers];
        [self loadGroupMembers];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"操作失败"];
    }
}

- (void)receiveRenameNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *groupName = [infoDic objectForKey:@"newname"];
        NSString *sqlStr = [NSString stringWithFormat:@"UPDATE groupInfoTable SET groupName='%@' WHERE  groupId='%@'",groupName,[infoDic objectForKey:@"groupid"]];
        [[GroupDataHelper sharedService] operateGroupDB:sqlStr];

    }
    else
    {
        [ShowAlertView showAlertViewStr:@"操作失败"];
    }
}


#pragma mark -
#pragma mark notificationErrorReturn

- (void)connectErrorNotification:(NSNotification *)notification
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    [ShowAlertView showAlertViewStr:@"连接错误"];
}


#pragma mark -
#pragma mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10086)
    {
        if (buttonIndex == 1) {
            NSString *loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
            BOOL result = [[ChatDataHelper sharedService] deleteMessagesWithRelativeId:[groupid intValue]  withToUserId:[loginId intValue]];
            if (result)
            {
                //清空了
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAllMessages object:nil];

                [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAConversation object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:groupid,@"groupid", nil]];
            }
        }
    }
    else if (alertView.tag == AlertTag)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (alertView.tag == 199999)
    {
        if (buttonIndex == 1) {
            
            UITextField *tf=[alertView textFieldAtIndex:0];
            
            if (tf.text.length > 0)
            {
                //发送新的群组名称
                [[STHUDManager sharedManager] showHUDInView:self.view];
                NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
                NSArray *msg = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"RENAME_GROUP"},@{@"groupid": self.groupid},@{@"newname": tf.text}];
                
                NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msg]];
                [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
            }
            else
            {
                return;
            }
        }
        else
        {
            return;
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


//#pragma mark -
//#pragma mark UIScrollView Delegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)sender
//{
//    int page = membersView.contentOffset.x / 300;
//    pageControl.currentPage = page;
//}

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

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = self.membersView.contentOffset.x / ScrollView_Width;
    
    pageControl.currentPage = page;
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

- (void)changePage:(id)sender {
    
    int page = pageControl.currentPage;
    [self.membersView setContentOffset:CGPointMake(ScrollView_Width * page, 0)];
    
}

#pragma mark -
#pragma mark UIView相关
/*
 此函数用于将图片变灰
 输入参数：(UIImage *)需要改变的图片
 输出参数：(UIImage *)变色后的图片
 */
- (UIImage *) convertToGrayStyle:(UIImage *)img
{
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    int colors = kGreen;
    int m_width = img.size.width;
    int m_height = img.size.height;
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [img CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count = 0;
            
            if (colors & kRed) {
                sum += (rgbPixel>>24) & 255;
                count++;
            }
            
            if (colors & kGreen) {
                sum += (rgbPixel>>16) & 255;
                count++;
            }
            
            if (colors & kBlue) {
                sum += (rgbPixel>>8) & 255;
                count++;
            }
            m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height * sizeof(uint8_t) * 4, 1);
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4] = 0;
        int val = m_imageData[i];
        result[i*4+1] = val;
        result[i*4+2] = val;
        result[i*4+3] = val;
    }
    free(m_imageData);
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    
    return resultUIImage;
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupMemberData object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupMemberChangesData object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupDeleteMaster object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupDeleteMass object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGetUserStatus object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRenameGroupName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.linkDepartmentView = nil;
    self.membersArr = nil;
    self.membersView = nil;
    self.groupid = nil;
    self.editBtn = nil;
    self.tapGestureTel = nil;
    self.tapGestureTel2 = nil;
    self.customAllertView = nil;
    self.personWillDelete = nil;
    self.synView = nil;
    [super dealloc];
}



@end

