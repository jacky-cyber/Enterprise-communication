//
//  ChatDetailViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-23.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "MsgCategoryVC.h"
#import "HeKaViewController.h"
#import "PhotoLibrary.h"
#import "LinkDateCenter.h"
#import "LinkDataHelper.h"
#import "SynUserInfo.h"
#import "SynUserIcon.h"
#import "HttpServiceHelper.h"
#import "ImageViewController.h"
#import "UIImage-Extensions.h"
#import "ScanImageView.h"
#import "EditHeKaViewController.h"
#import "NSDate-Helper.h"
#import "LongMsgFeed.h"
#import "LongMsgDataHelper.h"
#import "GroupSendMsgViewController.h"
#import "SynContacts.h"
#import "LinkMakeGroupViewController.h"
#import "HttpReachabilityHelper.h"
#import "LastChatMessageFeed.h"
#import "LastChatMessageDataHelper.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"
#import "MarkupParser.h"
#import "ImageDataHelper.h"
#import "CDATAEncode.h"
#import "FaceKeyBoardDeal.h"
#import "NotOnlineRemindView.h"
#import "SingleChatEditViewController.h"
#import "MailHelp.h"
#import "SendOtherViewController.h"
#import "BlockUI.h"
#import "ZYQAssetPickerController.h"
#import "ChatScanImageView.h"
#import "ISTChatImageDowmLoad.h"


#define KLongMessageSectionLength 200
#define kPhoneAlertTag  1001
#define kDuanXinAlertTag  1002
@interface ChatDetailViewController ()<MsgCategoryDelegate,PhotoLibraryDelegate,ChatImageDownloaderDelegate,SendCardDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomeAlertViewDelegate,OHAttributedLabelDelegate,UIAlertViewDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,ChatScanImageViewDelegate>

@property (nonatomic,assign) float iosChangeFloat;
@property (nonatomic, retain) NSString *toPhoneStr;
@property (nonatomic, retain) NSString *myPhoneStr;
@property (nonatomic, retain) NSDate *queryDate;
@property (nonatomic, assign) BOOL isFirstReloadData;
@property (nonatomic, retain) NSIndexPath *lastTimeShowIndexPath;
@property (nonatomic, assign) NSInteger nowReadDbSize;
@property (nonatomic, retain) NSString *firstMsgId;
@property (nonatomic, retain) NotOnlineRemindView *remindView;
@property (nonatomic, assign) NSInteger singalPersonStatus;
@property (nonatomic, copy)  NSString *nowSendMessage;
@property (nonatomic, copy)  NSString *switchToSMSSendStr;

@end

@implementation ChatDetailViewController
{
    BOOL _isNowSendDuanXin;
    NSInteger _bottomUnReadCount;
    SwitchSendType _switchSendType;
}
@synthesize titleLable;

- (void)dealloc
{
    for(ISTChatImageDowmLoad *downloader in self.downloadImages)
    {
        [downloader cancelDownLoad];
        downloader.delegate = nil;
    }

    self.downloadImages = nil;
    self.messageDetailList = nil;
    self.tableView.delegate = nil;
    self.toPhoneStr = nil;
    self.myPhoneStr = nil;
    self.queryDate = nil;
    self.sendOtherMessage = nil;
    self.lastTimeShowIndexPath = nil;
    self.firstMsgId = nil;
    self.remindView = nil;
    self.nowSendMessage = nil;
    self.switchToSMSSendStr = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[HttpServiceHelper sharedService] cancelRequestForDelegate:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(insertAMeesageToListTable:)
                                                     name:kInsertAMessageIntoNowChat
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deleteAllMessagesOperate)
                                                     name:kDeleteAllMessages
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveRenameNotification:)
                                                     name:kRenameGroupName object:nil];
        //获取群组成员
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupMemberDataNotification:)
                                                     name:kGroupMemberData
                                                   object:nil];
        //获取当前人的状态
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveStatusNotification:)
                                                     name:kGetUserStatus object:nil];

        //获取个人聊天内容
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveConDetailMsgNotification:)
                                                     name:kChatSyncinfomation
                                                   object:nil];

        //增加监听，获取发送成功数据的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveSmsDataNotification:)
                                                     name:kSendSMS
                                                   object:nil];
        //发送群组回执的指令
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveSmsDataNotification:)
                                                     name:kGroupMsg
                                                   object:nil];
        //发送个人回执的指令
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveSmsDataNotification:)
                                                     name:kPersonalMsg
                                                   object:nil];
        //发送长消息的回执
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveSendLongMessageDataNotification:)
                                                     name:kSendLongMsg
                                                   object:nil];
        //登录成功后再进行数据请求,和加载数据库数据
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSuccessfully)
                                                     name:kLoginSuccess
                                                   object:nil];

        [self initDefaultDatas];

    }
    return self;
}
- (void)initDefaultDatas
{
    self.downloadImages = [NSMutableArray array];
    self.messageDetailList = [NSMutableArray array];
    _bottomUnReadCount = 0;
    self.isFirstReloadData = YES;
    self.nowReadDbSize = 0;
    _isNowSendDuanXin = NO;
    _switchSendType = SwitchMessageSendType;
    if (IOSVersion >= 7.0)
    {
        self.iosChangeFloat = 20;
    }
    else
    {
        self.iosChangeFloat = 0;
    }
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubviews];
    [self initTableDatas];
    //申请当前聊天人的状态
    [self performSelector:@selector(requestNowChatPersonStatus) withObject:nil];

	// Do any additional setup after loading the view.
}

- (void)requestNowChatPersonStatus
{
    if (!_conFeed.isGroup) {
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSString *userid = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
        NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"getUserStatus"},@{@"userlist": userid}];
        NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
        [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    }
}
- (void)initTableDatas
{
    //首先获取数据库的数据 然后去同步  然后替换到当前读出来的12条  去 刷新界面
    if ([[HttpReachabilityHelper sharedService] checkNetwork:nil])
    {
        //进来去同步
        [self requestMoreDetailInfoWithTakeTime:nil];
    }
    else
    {
        [self readDbToReloadTableWithSeriodId:nil];
    }

    NSString *lastChatMessage = [[LastChatMessageDataHelper sharedService] queryChatLastMsgFromDB:_conFeed.relativeId];
    if (lastChatMessage && [lastChatMessage length])
    {
        self.messageInputView.textView.text = lastChatMessage;
        [self textViewDidChange:self.messageInputView.textView];
    }
}


- (void)requestMoreDetailInfoWithTakeTime:(NSString *)takeTime
{
    if (_isFirstReloadData)
    {
        takeTime = @"0";
    }
    else
    {
        if (self.firstMsgId) {
            takeTime = self.firstMsgId;
        }
        else
        {
            takeTime = @"0";
        }
    }
    NSString *fetchtype = nil;
    if (_isFirstReloadData) {
        //获取最新的
        fetchtype = @"0";
    }
    else
    {
        fetchtype = @"1";
    }
    NSString *messagetype = [NSString stringWithFormat:@"%d",200];
    if (_conFeed.isGroup == 1) {
        messagetype = [NSString stringWithFormat:@"%d",201];
    }
    NSString *sessionId = _conFeed.loginId;
    NSString *relativeid = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"ChatSyncinfomation"},@{@"takentime":takeTime},@{@"msgtype":messagetype},@{@"toid":relativeid},@{@"fetchtype":fetchtype}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (int)readDbToReloadTableWithSeriodId:(NSString *)seriod
{
    //如果请求回来是0的话 就默认12条
    if (self.nowReadDbSize == 0) {
        self.nowReadDbSize =kChatMsgPageSize;
    }
    NSString *sendDate = nil;
    if ([self.messageDetailList count]) {
        ChatMessagesFeed *feed = [self.messageDetailList firstObject];
        sendDate = feed.sendDate;
        seriod = feed.date;
    }
    else
    {
        //第一次读取很久以前的
        sendDate = @"2150-01-01 12:00:00";
        seriod = [self getFFFSeriodId:[NSDate date]];
    }
    NSMutableArray *arr = [[ChatDataHelper sharedService] queryMessagesWithRelativeId:_conFeed.relativeId withToUserId:[_conFeed.loginId integerValue] withSendDate:sendDate withSeriod:seriod withPageSize:_nowReadDbSize];
    for(ChatMessagesFeed *feed in arr)
    {
        feed = [self addAttributedLabelToChatMessageFeed:feed];
        [self.messageDetailList insertObject:feed atIndex:0];
    }
    [self.tableView reloadData];
    //如果查出来==12条
    if([arr count] > 0 && [self.messageDetailList count]>[arr count]) {
        CGRect frame = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:[arr count] inSection:0]];
        [self.tableView setContentOffset:CGPointMake(0, frame.origin.y) animated:NO];
    }
    return (int)[arr count];
}

//在数组里面添加AttributedLabel
- (ChatMessagesFeed *)addAttributedLabelToChatMessageFeed:(ChatMessagesFeed *)feed
{
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    [self creatAttributedLabel:feed Label:label];
    feed.attributedLabel = label;
    [CustomMethod drawImage:feed];
    [label release];
    return feed;
}

- (void)creatAttributedLabel:(ChatMessagesFeed *)feed Label:(OHAttributedLabel *)label
{
//    [label setNeedsDisplay];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionPlist" ofType:@"plist"];
    NSDictionary *m_emojiDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSString *text = [CustomMethod transformString:feed.message emojiDic:m_emojiDic];
    if (feed.fromUserId == [_conFeed.loginId integerValue])
    {
        text = [NSString stringWithFormat:@"<font color='gray' strokeColor='' face='Palatino-Roman'>%@",text];
    }
    else
    {
        text = [NSString stringWithFormat:@"<font color='darkGray' strokeColor='' face='Palatino-Roman'>%@",text];
    }
    
    NSMutableAttributedString *attString = [wk_markupParser attrStringFromMarkup:text];
    //行间距
    NSMutableParagraphStyle *paragStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
    [paragStyle setLineSpacing:4.0f];
    [attString addAttribute:(id)NSParagraphStyleAttributeName value:(id)paragStyle range:NSMakeRange(0, attString.length)];

    [attString addAttribute:(id)NSFontAttributeName value:(id)[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, attString.length)];

    [label setBackgroundColor:[UIColor clearColor]];
    [label setAttString:attString withImages:wk_markupParser.images];
    [wk_markupParser release];
    
    label.delegate = self;
    CGRect labelRect = label.frame;
    labelRect.size.width = [label sizeThatFits:CGSizeMake(kScreen_Width*0.7, CGFLOAT_MAX)].width;
    labelRect.size.height = [label sizeThatFits:CGSizeMake(kScreen_Width*0.7, CGFLOAT_MAX)].height;
    label.frame = labelRect;
    label.underlineLinks = NO;//链接是否带下划线
//    label.onlyCatchTouchesOnLinks = YES;
    [label.layer display];
}

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    NSString *requestString = [linkInfo.URL absoluteString];
    NSLog(@"%@",requestString);
    NSLog(@"%@",linkInfo.phoneNumber);
//    NSMutableArray *httpArr = [CustomMethod addHttpArr:requestString];
    NSMutableArray *phoneNumArr = [CustomMethod addPhoneNumArr:requestString];
    NSMutableArray *emailArr = [CustomMethod addEmailArr:requestString];
    if ([emailArr count])
    {
        [MailHelp sharedService].recipients = [NSArray arrayWithObjects:requestString, nil];
        [MailHelp sharedService].isShowScreenShot = NO;
        [[MailHelp sharedService] sendMailWithPresentViewController:self];

    }
    else if (linkInfo.phoneNumber) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",linkInfo.phoneNumber]]];
    }

    else if ([[UIApplication sharedApplication]canOpenURL:linkInfo.URL])
    {
        [[UIApplication sharedApplication]openURL:linkInfo.URL];
    }
    return NO;
}


- (NSString *)getNowQueryDateStr:(int)day
{
    if (!self.queryDate) {
        self.queryDate = [NSDate date];
    }
    //计算几天以前的date
    NSDate *date = [self.queryDate dateAfterDay:-day];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kEnterChatDetail
                                                        object:nil];
    if (_sendOtherMessage && [_sendOtherMessage length]) {
        [self sendMessageWithMsgType:_sendOtherMessage];
        self.sendOtherMessage = nil;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [AppDelegate shareDelegate].nowChatUserId = _conFeed.relativeId;

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [AppDelegate shareDelegate].nowChatUserId = -1;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
    [self handleTap:nil];
}

- (void)initSubviews
{
    if (IOSVersion >= 7.0) {
        UIView *stausBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
        stausBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:stausBarView];
        [stausBarView release];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.iosChangeFloat, kScreen_Width, kNavHeight)];
    header.image = UIImageWithName(@"top_bar_bg.png");
    header.userInteractionEnabled = YES;
    [self.view addSubview:header];
    [header release];
    
    //return btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(onReturnBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
    self.titleLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)] autorelease];
    if (_conFeed.isGroup) {
        titleLable.text = [[GroupDataHelper sharedService] getGroupNameByid:[NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId]];
    }
    else
    {
        titleLable.text = [[ChatDataHelper sharedService] getUserName:_conFeed.relativeId];
    }
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.center = CGPointMake(kScreen_Width/2, kNavHeight/2);
    [header addSubview:self.titleLable];

    if(_conFeed.isGroup != 1 )
    {
        UIButton *historyBt = [UIButton buttonWithType:UIButtonTypeCustom];
        historyBt.frame = CGRectMake(kScreen_Width-70, 0, 70, kNavHeight);
        [historyBt setImage:[UIImage imageNamed:@"chatHistory.png"] forState:UIControlStateNormal];
        [historyBt setImageEdgeInsets:UIEdgeInsetsMake(10, 34, 10, 11)];
        [historyBt addTarget:self action:@selector(readChatHistory) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:historyBt];
    }
    else
    {
        UIButton *groupBt = [UIButton buttonWithType:UIButtonTypeCustom];
        groupBt.frame = CGRectMake(275,8, 30, 25);
        [groupBt setImage:[UIImage imageNamed:@"group_file.png"] forState:UIControlStateNormal];
        [groupBt addTarget:self action:@selector(readGroupDetailInfo) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:groupBt];
    }
}
- (void)onReturnBtnPressed:(id)sender
{
    LastChatMessageFeed *feed = [[[LastChatMessageFeed alloc] init] autorelease];
    feed.relativeId = _conFeed.relativeId;
    //这里将最后输入的消息存到数据库
    if (self.messageInputView.textView.text && [self.messageInputView.textView.text length])
    {
        feed.msg = self.messageInputView.textView.text;
    }
    else
    {
        feed.msg = @"";
    }
    [[LastChatMessageDataHelper sharedService] insertAChatLastMsgToDB:feed];
    //读出数据库中最后一条不是自己发的消息
    NSString *msgUUID = nil;
    for (int i =[self.messageDetailList count]-1; i>=0; i--) {
        ChatMessagesFeed *feed = [self.messageDetailList objectAtIndex:i];
        if (feed.fromUserId != [feed.loginid integerValue]) {
            msgUUID = feed.date;
            break;
        }
    }
    if (msgUUID) {
        [self setHasReadToServer:msgUUID];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[AppDelegate shareDelegate] setSelectIndex:0];
}

- (void)readChatHistory
{
//    ChatHistoryViewController *chatHistory = [[ChatHistoryViewController alloc] initWithNibName:nil bundle:nil];
//    chatHistory.conFeed = _conFeed;
//    [self.navigationController pushViewController:chatHistory animated:YES];
//    [chatHistory release];
    SingleChatEditViewController *chatEdit = [[SingleChatEditViewController alloc] initWithNibName:nil bundle:nil];
    chatEdit.personStatus = self.singalPersonStatus;
    chatEdit.conFeed = _conFeed;
    [self.navigationController pushViewController:chatEdit animated:YES];
    [chatEdit release];
}

- (void)readGroupDetailInfo
{
    NSString *groupid = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    //跳转到群聊天页面
    GroupEditViewController *gevc = [[GroupEditViewController alloc] initWithGroupid:groupid];
    [self.navigationController pushViewController:gevc animated:YES];
    [gevc release];
}
#pragma mark - 登录成功 加载界面 并且请求数据
- (void)loginSuccessfully
{
    _isFirstReloadData = YES;
    [self requestMoreDetailInfoWithTakeTime:nil];
}
#pragma mark - 请求当前聊天本人的状态
- (void)receiveStatusNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {
        NSString *listString = [infoDic objectForKey:@"statuslist"];
        NSArray *usr = [listString componentsSeparatedByString:@";"];
        for (NSString *str in usr)
        {
            if ([str isEqualToString:@""]) {
                break;
            }
            NSArray *statusArr = [str componentsSeparatedByString:@","];
            NSInteger usrid = [[statusArr objectAtIndex:0] integerValue];
            if (usrid == _conFeed.relativeId)
            {
                self.singalPersonStatus = [[statusArr objectAtIndex:1] integerValue];
                //对方不在线
                if (_singalPersonStatus==Status_Offline || _singalPersonStatus==Status_Hidden) {
                    [self addNowChatNotOnlineRemind];
                    [self duanxinBtnTap];
                }
                break;
            }
        }
    }
}

- (void)addNowChatNotOnlineRemind
{
    [self removeNotOnlineRemindview];
    NotOnlineRemindView *remindView = [[NotOnlineRemindView alloc] initWithFrame:CGRectMake(0, kNavHeight+self.iosChangeFloat, kScreen_Width, 20)];
    self.remindView = remindView;
    [remindView release];
    [self.view addSubview:_remindView];
    [self performSelector:@selector(removeNotOnlineRemindview) withObject:nil afterDelay:5.0f];
}
- (void)removeNotOnlineRemindview
{
    if (self.remindView) {
        [self.remindView removeFromSuperview];
        self.remindView = nil;
    }
}

#pragma mark - 在线消息
- (void)insertAMeesageToListTable:(NSNotification *)notification
{
    ChatMessagesFeed *feed = [[notification userInfo] objectForKey:@"feed"];
    feed = [self addAttributedLabelToChatMessageFeed:feed];
    feed.showDate = [TimeChangeWithTimeStamp getMMTimeFromFFFTime:feed.sendDate];
    [self.messageDetailList addObject:feed];
    [self.tableView tableViewDidFinishedLoading];
    [self.tableView reloadData];
    
    NSArray *arr = [self.tableView indexPathsForVisibleRows];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[self.messageDetailList count]-2 inSection:0];
    if ([arr containsObject:indexpath]) {
        [self scrollToBottomAnimated:YES];
    }
    else
    {
        _bottomUnReadCount += 1;
        [self.messageInputView.msgBtnsView setUnReadCountView:_bottomUnReadCount];
    }
}

#pragma mark - bubble delegate
- (void)clickOnHeadImage:(id)sender
{
    if (sender && [sender isKindOfClass:[NSString class]])
    {
        self.messageInputView.textView.text = [NSString stringWithFormat:@"%@@%@:",self.messageInputView.textView.text,sender];
        [self textViewDidChange:self.messageInputView.textView];
    }
}
- (void)longPressHeadImage:(id)sender
{
    if (sender && [sender isKindOfClass:[NSString class]])
    {
        User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:sender];
        CustomAlertView *customAllertView = [[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:user];
        [self.view addSubview:customAllertView];
        customAllertView.delegate = self;
        [customAllertView release];
    }
}

- (void)imageTap:(NSString *)imageStr
{
    if ([imageStr rangeOfString:@"%Greeting%"].location!=NSNotFound)
    {
        NSRange range = [imageStr rangeOfString:@"%Greeting%"];
        NSString *tempStr = [imageStr substringFromIndex:(range.location+range.length)];
        NSRange range1 = [tempStr rangeOfString:@"#"];
        NSString *image = [tempStr substringToIndex:range1.location];
        tempStr = [tempStr substringFromIndex:(range1.location+range1.length)];
        
        NSRange range3 = [tempStr rangeOfString:@"%Greeting%"];
        NSString *greetingStr = [tempStr substringToIndex:range3.location];
        //发现安卓穿过来的居然是big的图片
        NSRange nameRange = [image rangeOfString:@"card_big_"];
        if (nameRange.location != NSNotFound) {
            image = [NSString stringWithFormat:@"card_small_%@.jpg",[image substringFromIndex:(nameRange.location+nameRange.length)]];
        }
        
        EditHeKaViewController *edit = [[EditHeKaViewController alloc] initWithNibName:nil bundle:nil];
        edit.isCanEdit = NO;
        edit.imageName = [NSString stringWithFormat:@"%@.jpg",image];
        edit.greetingStr = greetingStr;
        [self.navigationController pushViewController:edit animated:YES];
        [edit release];
    }
    else
    {
        //过滤有图片的数据
        NSMutableArray *imageStrArr = [NSMutableArray array];
        NSInteger selectIndex =0;
        for(ChatMessagesFeed *tmpFeed in self.messageDetailList)
        {
            NSArray *imageArr = [CustomMethod getImageArrFromMessage:tmpFeed.message];
            for ( NSTextCheckingResult* result in imageArr)
            {
                NSRange range = NSMakeRange(result.range.location+StartImageContent.length, result.range.length-StartImageContent.length-EndImageContent.length);
                NSString *str = [tmpFeed.message substringWithRange:range];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:tmpFeed.date forKey:@"msgid"];
                [dic setValue:str forKey:@"image"];
                [imageStrArr addObject:dic];
                NSArray *arr = [imageStr componentsSeparatedByString:@";"];
                if ([arr count]==2) {
                    NSString *bigStr = [arr objectAtIndex:0];
                    NSString *smallStr = [arr objectAtIndex:1];
                    if ([str rangeOfString:bigStr].location != NSNotFound && [str rangeOfString:smallStr].location != NSNotFound) {
                        selectIndex = [imageStrArr count]-1;
                    }
                }
            }
        }
        ChatScanImageView *scan = [[ChatScanImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        scan.delegate = self;
        [scan setcontentImagesArr:imageStrArr withNowIndex:selectIndex];
        [[AppDelegate shareDelegate].window addSubview:scan];
        [scan release];
    }
}

- (void)onMenuItemTap:(NSDictionary *)infoDic
{
    MenuItemStyle style = (MenuItemStyle)[[infoDic objectForKey:@"menuItem"] intValue];
    int row = [[infoDic objectForKey:@"row"] intValue];
    switch (style)
    {
        case CopyStyle:
            [self copyCellAction:row];
            break;
        case DeleteOneStyle:
            [self deleteCellAction:row];
            break;
        case PhoneStyle:
            [self phoneCellAction:row];
            break;
        case DeleteAllStyle:
            [self deleteAllMsgs:row];
            break;
        case ReSendStyle:
            [self reSendMsg:row];
            break;
        case ToChatWithStyle:
            [self toChatWith:row];
            break;
        case SendOtherStyle:
            [self sendOther:row];
            break;
        case  SwitchSMSSendStyle:
            [self switchSMSSend:row];
            break;
        case  SwitchMessageSendStyle:
            [self switchMessageSend:row];
            break;

        default:
            break;
    }
}

#pragma mark - 弹出框的代理
-(void)contactAlertViewWith:(id)object withStyel:(ContactBtnStyle)style
{
    switch (style) {
        case ContactBtn_callPhone:
            [self contactsListViewCallMobilePhone:[(User *)object telephone]];
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
-(void)contactsListViewCallMobilePhone:(NSString *)mobile
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",mobile]]];
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
        [ShowAlertView showAlertViewStr:@"您的帐号还未绑定手机号码" andDlegate:self withTag:kPhoneAlertTag];
        return;
    }
    GroupSendMsgViewController *sendMsg = [[GroupSendMsgViewController alloc] initWithNibName:nil bundle:nil];
    if (_conFeed.isGroup) {
        sendMsg.groupid = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    }
    sendMsg.phoneStr = phoneStr;
    sendMsg.selectArr = [NSMutableArray arrayWithArray:array];
    [self.navigationController pushViewController:sendMsg animated:YES];
    [sendMsg release];
    
}
-(void)contactsAddPerson:(User *)user
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:user];
    SynContacts *synView = [[SynContacts alloc] init];
    [synView synContacts:array];
    [synView release];
}

#pragma mark - CellOpe
- (void)deleteCellAction:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    BOOL result = [[ChatDataHelper sharedService] deleteAMessage:feed.date];
    if (result)
    {
        [_messageDetailList removeObjectAtIndex:row];
        [self.tableView reloadData];
    }
}

- (void)copyCellAction:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    [UIPasteboard generalPasteboard].string = feed.message;
}

- (void)phoneCellAction:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    NSDictionary *dic = [[ChatDataHelper sharedService] getUserInfoDic:feed.fromUserId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[dic objectForKey:@"phone"]]]];
}
- (void)deleteAllMsgs:(int)row
{

    BOOL result = [[ChatDataHelper sharedService] deleteMessagesWithRelativeId:_conFeed.relativeId  withToUserId:[_conFeed.loginId integerValue]];
    if (result)
    {
        [self.messageDetailList removeAllObjects];
        [self.tableView reloadData];
        //清空了
        [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteAConversation object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId],@"groupid", nil]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)deleteAllMessagesOperate
{
    _isFirstReloadData = YES;
    [self.messageDetailList removeAllObjects];
    [self.tableView reloadData];
    [self requestMoreDetailInfoWithTakeTime:nil];
}
- (void)reSendMsg:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    BOOL result = [[ChatDataHelper sharedService] deleteAMessage:feed.date];
    if (result)
    {
        [_messageDetailList removeObjectAtIndex:row];
    }
    [self sendPressed:nil withText:feed.message];
}
- (void)sendOther:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    
    SendOtherViewController *sendOther = [[SendOtherViewController alloc] initWithNibName:nil bundle:nil];
    sendOther.sendOtherMessage = feed.message;
    [self.navigationController pushViewController:sendOther animated:YES];
    [sendOther release];
}
- (void)toChatWith:(int)row
{
    if (_conFeed.isGroup == 0 )
    {
        return;
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        ChatMessagesFeed *rowFeed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];

        ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
        ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        feed.isGroup = 0;
        feed.relativeId = rowFeed.fromUserId;
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        detail.conFeed = feed;
        [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
        [detail release];
    }
}

- (void)switchSMSSend:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    self.switchToSMSSendStr = feed.message;
    [self getSelfPhoneNumAndOthersNum];
}
- (void)switchMessageSend:(int)row
{
    ChatMessagesFeed *feed = (ChatMessagesFeed *)[_messageDetailList objectAtIndex:row];
    [self sendMessageWithMsgType:feed.message];
}

//以消息形式发送
- (void)sendMessageWithMsgType:(NSString *)message
{
    //先记录以前的选择的是哪种发送方式
    SwitchSendType beforeSendType = _switchSendType;
    _switchSendType = SwitchMessageSendType;
    [self sendPressed:nil withText:message];
    _switchSendType = beforeSendType;
}
#pragma mark - SendOtherImageDelegate
- (void)sendOtherImage:(NSString *)imageStr
{
    SendOtherViewController *sendOther = [[SendOtherViewController alloc] initWithNibName:nil bundle:nil];
    sendOther.sendOtherMessage = imageStr;
    [self.navigationController pushViewController:sendOther animated:YES];
    [sendOther release];
}

#pragma mark -
#pragma mark ImageDownloader delegate
- (void)imageDownloaderFinishWithImageData:(NSData *)imageDate withDownLoader:(ISTChatImageDowmLoad *)downLoader
{
    NSString *msgid = downLoader.msgid;
    for(ISTChatImageDowmLoad *aDownloader in self.downloadImages)
    {
        if(aDownloader.msgid == downLoader.msgid)
        {
            [self.downloadImages removeObject:downLoader];
            break;
        }
    }
    UIImage *image = [UIImage imageWithData:imageDate];
    if (![image isKindOfClass:[UIImage class]]) {
        return;
    }
    [[ImageDataHelper sharedService] storeWithImage:image imageName:downLoader.smallImageKey];
    [self getSmallImageBack:image witMsgId:msgid];
}

- (void)imageDownloaderFailWithError:(NSError *)error withDownLoader:(ISTChatImageDowmLoad *)downLoader
{
    [self.downloadImages removeObject:downLoader];
}

- (void)getSmallImageBack:(UIImage *)smallImage witMsgId:(NSString *)msgId
{
    NSString *msgid = msgId;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.date == %@",msgid];
        NSArray *filterArr = [self.messageDetailList filteredArrayUsingPredicate:predicate];
        if ([filterArr count]) {
            NSUInteger row = [self.messageDetailList indexOfObject:[filterArr objectAtIndex:0]];
            dispatch_async(dispatch_get_main_queue(), ^{
                ChatMessagesFeed *feed = [filterArr objectAtIndex:0];
                feed = [self addAttributedLabelToChatMessageFeed:feed];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [self.messageDetailList replaceObjectAtIndex:indexPath.row withObject:feed];
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
                NSInteger rows = [self.tableView numberOfRowsInSection:0];
                if (rows == indexPath.row) {
                    [self scrollToBottomAnimated:YES];
                }
            });
        }
    });
}


#pragma mark - Table view data source
// Override from superclass
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageDetailList count];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessagesFeed *feed = [self.messageDetailList objectAtIndex:indexPath.row];
    CGFloat timeHeight = [self timeHeightAtIndexPath:indexPath];
    CGFloat bubbleHeight = [BubbleView bubbleCellHeightForObject:feed];
    BOOL isShow = [self isShowTimeLabel:indexPath];
    if (isShow) {
        return bubbleHeight+timeHeight;
    }
    return bubbleHeight;
}

- (BOOL)isShowTimeLabel:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        self.lastTimeShowIndexPath = indexPath;
        return YES;
    }
    else
    {
        ChatMessagesFeed *feed = [self.messageDetailList objectAtIndex:indexPath.row-1];
        ChatMessagesFeed *feed1 = [self.messageDetailList objectAtIndex:indexPath.row];
        BOOL isTimeShow = [TimeChangeWithTimeStamp isBeyondMMWithTime:feed.showDate withOtherTime:feed1.showDate];
        return isTimeShow;
    }
}
- (CGFloat)timeHeightAtIndexPath:(NSIndexPath *)indexPath
{
    //时间
    return TIME_LABEL_HEIGHT;
}

- (void)selectBtnTap:(AddToDetailBtnTag)tag
{
    if (tag == duanXin_BtnType) {
        MsgCategoryVC *cate = [[MsgCategoryVC alloc] initWithNibName:nil bundle:nil];
        cate.delegate = self;
        [self.navigationController pushViewController:cate animated:YES];
        [cate release];
    }
    else if (tag == heKa_BtnType)
    {
        HeKaViewController *heka = [[HeKaViewController alloc] initWithNibName:nil bundle:nil];
        heka.delegate = self;
        [self.navigationController pushViewController:heka animated:YES];
        [heka release];
    }
    else if (tag == album_BtnType)
    {
//        PhotoLibrary *library = [PhotoLibrary allocWithZone:NSDefaultMallocZone()];
//        [library settingDelegate:self popAt:CGRectZero];
//        [library choosePhotoFromLibrary];
        ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
        picker.maximumNumberOfSelection = 10;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups=NO;
        picker.delegate=self;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                return duration >= 5;
            } else {
                return YES;
            }
        }];
        
        [self presentViewController:picker animated:YES completion:NULL];

    }
    else if (tag == camera_BtnType)
    {
        PhotoLibrary *library = [PhotoLibrary allocWithZone:NSDefaultMallocZone()];
        [library settingDelegate:self popAt:CGRectZero];
        [library takePhotoWithCamera];
    }
}


#pragma mark -选择图片
#pragma mark UIImagePickerControllerDelegate

- (void)selectImage:(UIImage *)image withInfo:(id)info
{
    [self.view endEditing:YES];
    [self sendImage:image];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i=0; i<assets.count; i++){
            ALAsset *asset=assets[i];
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self sendImage:tempImg];
            });
        }
    });
}
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishRotateImage:(UIImage *)image
{
    [self sendImage:image];
}

#pragma mark - msgSendDelegate
- (void)clearUnReadCountImageView
{
    [self scrollToBottomAnimated:YES];
    [self.messageInputView.msgBtnsView setUnReadCountView:0];
}
- (void)msgBtnTap
{
    _switchSendType = SwitchMessageSendType;
    self.messageInputView.msgBtnsView.msgBtn.selected = YES;
    self.messageInputView.msgBtnsView.duanxinBtn.selected = NO;
    [self.messageInputView.textView setPlaceholderStr:@"网络消息"];
}
- (void)duanxinBtnTap
{
    _switchSendType = SwitchSMSSendType;
    NSString *str = self.messageInputView.textView.text;
    if (!self.messageInputView.textView.markedTextRange && self.messageInputView.textView.text.length > kDuanXinLength) {
        str=[str substringToIndex:kDuanXinLength];
        self.messageInputView.textView.text= str;
    }
    self.messageInputView.msgBtnsView.msgBtn.selected = NO;
    self.messageInputView.msgBtnsView.duanxinBtn.selected = YES;
    [self.messageInputView.textView setPlaceholderStr:@"短信消息"];

    //因为短信发送要加上其他的电话号码
    [self getSelfPhoneNumAndOthersNum];
}

- (void)getSelfPhoneNumAndOthersNum
{
    if (self.myPhoneStr && self.toPhoneStr)
    {
        [self sendSwitchToSMSStr];
        return;
    }
    self.myPhoneStr = @"";
    NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
    FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
    if(![distanceDataBase open]){//打开数据库
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select userid, nickname, sex, usersig, telephone, mobile, email, field_char1 from im_users where userid=?;"];
    FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]];
    if ([rs next])
    {
        self.myPhoneStr = [rs stringForColumn:@"mobile"];
    }
    [rs close];
    [distanceDataBase close];
    
    if (!_myPhoneStr || ![_myPhoneStr length])
    {
        [ShowAlertView showAlertViewStr:@"您的帐号还未绑定手机号码" andDlegate:self withTag:kPhoneAlertTag];
        [self msgBtnTap];
        return;
    }
    
    //不是群组的话
    if (_conFeed.isGroup == 0) {
        NSString *distanceDbPath = [[SynUserInfo sharedManager ]getCurrentUserDBPath];
        FMDatabase *distanceDataBase = [FMDatabase databaseWithPath:distanceDbPath];
        if(![distanceDataBase open]){//打开数据库
        }
        NSString *sqlStr = [NSString stringWithFormat:@"select userid, nickname, sex, usersig, telephone, mobile, email, field_char1 from im_users where userid=?;"];
        FMResultSet *rs = [distanceDataBase executeQuery:sqlStr,[NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId]];
        if ([rs next])
        {
            self.toPhoneStr = [rs stringForColumn:@"mobile"];
        }
        [rs close];
        [distanceDataBase close];
        
        if (![_toPhoneStr length])
        {
            [ShowAlertView showAlertViewStr:@"对方未绑定手机号码" andDlegate:self withTag:kPhoneAlertTag];
            [self msgBtnTap];
            return;
        }
        else
        {
            [self sendSwitchToSMSStr];
        }
    }
    //是群组的话  就去请求群组所有人的电话号码
    else
    {
        [self getGroupMembers];
    }
}

- (void)getGroupMembers
{
    [self addActivityViewToSendBtn];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"groupMember"},@{@"groupID": [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId]}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)receiveGroupMemberDataNotification:(NSNotification *)notification
{
    [self removeActivityViewFromSendBtn];
    NSDictionary *infoDic = [notification userInfo];
    NSMutableArray *membersArr = [NSMutableArray array];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {
        [membersArr removeAllObjects];
        NSString *listString = [infoDic objectForKey:@"list"];
        NSArray *usr = [listString componentsSeparatedByString:@";"];
        for (int i = 0; i < [usr count] - 1; ++i)
        {
            NSArray *status = [[usr objectAtIndex:i] componentsSeparatedByString:@","];
            [membersArr addObject:[status objectAtIndex:0]];
        }
        
        for (NSString *userid in membersArr)
        {
            User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userid];
            if (!user.mobile || ![user.mobile length]||[user.userid isEqualToString:_conFeed.loginId]) {
                continue;
            }
            if (self.toPhoneStr && [self.toPhoneStr length])
            {
                self.toPhoneStr = [NSString stringWithFormat:@"%@%@;",_toPhoneStr,user.mobile];
            }
            else
            {
                self.toPhoneStr = [NSString stringWithFormat:@"%@;",user.mobile];
            }
        }
        //群发短信加上自己
        User *userSelf = [[LinkDateCenter sharedCenter] getUserWithUserId:_conFeed.loginId];
        if (self.toPhoneStr && [self.toPhoneStr length])
        {
            self.toPhoneStr = [NSString stringWithFormat:@"%@%@;",_toPhoneStr,userSelf.mobile];
        }
        else
        {
            self.toPhoneStr = [NSString stringWithFormat:@"%@;",userSelf.mobile];
        }

        if (!self.toPhoneStr || ![self.toPhoneStr length])
        {
            [ShowAlertView showAlertViewStr:@"对方未绑定手机号码" andDlegate:self withTag:kPhoneAlertTag];
            [self msgBtnTap];
        }
        else
        {
            [self sendSwitchToSMSStr];
        }
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"请求群成员失败"];
        [self msgBtnTap];
    }
    self.messageInputView.sendButton.enabled = YES;
}

- (void)sendSwitchToSMSStr
{
    if (_switchToSMSSendStr && [_switchToSMSSendStr length]) {
        //先记录以前的选择的是哪种发送方式
        SwitchSendType beforeSendType = _switchSendType;
        _switchSendType = SwitchSMSSendType;
        [self sendPressed:nil withText:_switchToSMSSendStr];
        _switchSendType = beforeSendType;
        self.switchToSMSSendStr = nil;
    }
}

- (void)receiveSmsDataNotification:(NSNotification *)notification
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    //根据毫秒时间戳  去跟新状态
    NSDictionary *dic = [notification userInfo];
    [self resetServerTimeAndLocalTime:[dic objectForKey:@"time"]];
    
    if ([notification.name compare:kSendSMS] == NSOrderedSame) {
        if ([[dic objectForKey:@"result"] isEqualToString:@"0"]) {
            [self updateSendStatusWithSeriod:[dic objectForKey:@"SerialID"] withStatus:SendSuccess];
        }
        else
        {
            [self updateSendStatusWithSeriod:[dic objectForKey:@"SerialID"] withStatus:SendFailed];
        }
    }
    else
    {
        
        if ([[dic objectForKey:@"result"] isEqualToString:@"1"]) {
            [self updateSendStatusWithSeriod:[dic objectForKey:@"SerialID"] withStatus:SendSuccess];
        }
        else
        {
            [self updateSendStatusWithSeriod:[dic objectForKey:@"SerialID"] withStatus:SendFailed];
        }
        //当发完消息对方不在线时给出提示
        if ([[dic objectForKey:@"status"] isEqualToString:@"0"] && _switchSendType == SwitchMessageSendType && !_conFeed.isGroup) {
            [self insertANotOnLineMessage];
        }
    }
}

- (void)insertANotOnLineMessage
{
    ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
    feed.relativeId = _conFeed.relativeId;
    feed.type = _conFeed.isGroup;
    feed.fromUserId = _conFeed.relativeId;
    feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
    feed.message = @"对方已下线";
    feed.isMySendMessage = 1;
    feed.date  = [NSString createUUID];
    feed.loginid = _conFeed.loginId;
    feed.toUserId = [_conFeed.loginId integerValue];
    feed.isOffLineMessage = NO;
    feed.sendStatus = SendSuccess;
    feed.sendDate = [self getCurrentTimeString];
    feed = [self addAttributedLabelToChatMessageFeed:feed];
    //插入数据库是毫秒的时间  然后界面显示的是分钟格式
    feed.showDate = [TimeChangeWithTimeStamp getMMTimeFromFFFTime:feed.sendDate];
    [self.messageDetailList addObject:feed];
    [feed release];
    [self.tableView reloadData];
    [self scrollToBottomAnimated:YES];
}

- (void)resetServerTimeAndLocalTime:(NSString *)msgTime
{
    [AppDelegate shareDelegate].serverAndLocalDiff = [TimeChangeWithTimeStamp resetServerTimeAndLocalTime:msgTime];
}

- (void)receiveSendLongMessageDataNotification:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    if ([[dic objectForKey:@"result"] isEqualToString:@"0"])
    {
        [[LongMsgDataHelper sharedService] updateMessageSendStatusWithSerialID:[dic objectForKey:@"SerialID"] withSendorder:[dic objectForKey:@"sendorder"] withSendStatus:SendSuccess withRelateID:[NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId]];
        NSString *infoID = [[LongMsgDataHelper sharedService] getInfoIDFromSerialID:[dic objectForKey:@"SerialID"]];
        BOOL result = [[LongMsgDataHelper sharedService] querySendResultWithInfoID:infoID withRelativeId:_conFeed.relativeId];
        if (result)
        {
            [[LongMsgDataHelper sharedService] deleteLongMsgsWithInfoId:infoID];
            [self updateSendStatusWithSeriod:infoID withStatus:SendSuccess];
            
        }
    }
    else
    {
        [[LongMsgDataHelper sharedService] updateMessageSendStatusWithSerialID:[dic objectForKey:@"SerialID"] withSendorder:[dic objectForKey:@"sendorder"] withSendStatus:SendFailed withRelateID:[NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId]];
        NSString *infoID = [[LongMsgDataHelper sharedService] getInfoIDFromSerialID:[dic objectForKey:@"SerialID"]];
        [self updateSendStatusWithSeriod:infoID withStatus:SendFailed];
    }
}


- (void)updateSendStatusWithSeriod:(NSString *)seriod withStatus:(SendStatus)sendStatus
{
    //更新界面后 再更新数据库
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.date == %@",seriod];
    NSArray *filterArr = [self.messageDetailList filteredArrayUsingPredicate:predicate];
    if ([filterArr count]) {
        NSUInteger row = [self.messageDetailList indexOfObject:[filterArr objectAtIndex:0]];
        ChatMessagesFeed *feed  = [self.messageDetailList objectAtIndex:row];
        feed.sendStatus = sendStatus;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        BubbleMessageCell *cell = (BubbleMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell.bubbleView setSendStatus:sendStatus];
    }
    //更新数据库
    [[ChatDataHelper sharedService] updateMessageSendStatusWithDate:seriod withSendStatus:sendStatus];
}
- (void)receiveConDetailMsgNotification:(NSNotification *)notification
{
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    NSDictionary *dic = [notification userInfo];
    NSLog(@"%@",dic);
    
    NSMutableArray *msgArr = [NSMutableArray array];
    if ([[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"] isKindOfClass:[NSDictionary class]])
    {
        [msgArr addObject:[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"]];
    }
    else if([[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"] isKindOfClass:[NSArray class]])
    {
        msgArr = [NSMutableArray arrayWithArray:[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"]];
    }
    
    //将要重置的消息id
    NSString *msgUUID = @"";
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSMutableArray *feedArr = [NSMutableArray array];
    for (int i = 0; i<[msgArr count]; i++)
    {
        NSDictionary *msgDic = [msgArr objectAtIndex:i];
        //首先要插入消息记录的数据库 然后如果有内容相同的就把这条消息废弃掉
        ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
        feed.type = 0;
        if ([[msgDic objectForKey:@"msgtype"] integerValue] == 201) {
            feed.type = 1;
        }
        feed.isOffLineMessage = 1;
        feed.isMySendMessage = 0;
        
        //离线群组
        if (feed.type) {
            feed.relativeId = [[msgDic objectForKey:@"relativeld"] integerValue];
            feed.fromUserId = [[msgDic objectForKey:@"fromid"] integerValue];
            feed.toUserId = [[msgDic objectForKey:@"to"] integerValue];
        }
        else
        {
            feed.relativeId = [[msgDic objectForKey:@"toid"] integerValue];
            feed.fromUserId = [[msgDic objectForKey:@"fromid"] integerValue];
    
            NSString *loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
            //如果是自己发的消息 fromid 是自己的 toid是对方
            if([[msgDic objectForKey:@"fromid"] isEqualToString:loginId])
            {
                feed.toUserId = [[msgDic objectForKey:@"toid"] integerValue];
            }
            //如果是对方发的消息 fromid toid都是是对方
            else
            {
                feed.toUserId = [loginId integerValue];
            }
        }
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        feed.date = [msgDic objectForKey:@"msgid"] ;
        feed.message = [msgDic objectForKey:@"msg"];
        feed.loginid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        if (feed.fromUserId != [feed.loginid integerValue]) {
            msgUUID = feed.date;
        }
        feed.sendDate = [msgDic objectForKey:@"msgtime"];
        feed.sendStatus = SendSuccess;
        //如果是长消息
        if ([[msgDic objectForKey:@"sumcount"] integerValue]) {
            feed  = [self receiveLongMsgNotification:msgDic];
        }
        if (feed) {
            [feedArr addObject:feed];
            [[ChatDataHelper sharedService] insertSynMessage:feed];
        }
        [feed release];
    }

    //确定下次请求的id
    if ([msgArr count]) {
        self.firstMsgId = [[msgArr firstObject] objectForKey:@"msgid"];
    }
    //这里判断读数据库 是多少条
    self.nowReadDbSize = [feedArr count];
    if (_isFirstReloadData) {
        if ([feedArr count]) {
            //第一次请求回来移除所有  然后读数据库
            [self readDbToReloadTableWithSeriodId:nil];
            ChatMessagesFeed *feed = [self.messageDetailList lastObject];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"synMsgs" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:feed,@"feed", nil]];
        }
        else if([msgArr count])
        {
            _isFirstReloadData = NO;
            [self requestMoreDetailInfoWithTakeTime:nil];
        }
        [self scrollToBottomAnimated:YES];
    }
    else
    {
        if([feedArr count])
        {
            [self readDbToReloadTableWithSeriodId:nil];
        }
        //当有消息但都是长消息时
        else if ([msgArr count])
        {
            [self requestMoreDetailInfoWithTakeTime:nil];
        }
    }
    [pool release];
    if(_isFirstReloadData)
    {
        _isFirstReloadData = NO;
        [self setHasReadToServer:msgUUID];
    }
    [self.tableView tableViewDidFinishedLoading];
}

//接收长消息
- (ChatMessagesFeed *)receiveLongMsgNotification:(NSDictionary *)msgDic
{
    //首先要插入消息记录的数据库
    LongMsgFeed *feed = [[LongMsgFeed alloc] init];
    feed.serialID = [msgDic objectForKey:@"msgid"];
    feed.infoID = [msgDic objectForKey:@"infoID"];
    if ([[msgDic objectForKey:@"msgtype"] isEqualToString:@"0"]) {
        feed.msgType = 200;
    }
    else if ([[msgDic objectForKey:@"msgtype"] isEqualToString:@"1"])
    {
        feed.msgType = 201;
    }
    else
    {
        feed.msgType = [[msgDic objectForKey:@"msgtype"] integerValue];
    }
    if (feed.msgType == 200) {
//        if([[msgDic objectForKey:@"fromid"] isEqualToString:_conFeed.loginId])
//        {
//            feed.relateId = [msgDic objectForKey:@"toid"];
//        }
//        else
//        {
//            feed.relateId = [msgDic objectForKey:@"fromid"];
//        }
        
        feed.relateId = [msgDic objectForKey:@"toid"];
        
        NSString *loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        //如果是自己发的消息 fromid 是自己的 toid是对方
        if([[msgDic objectForKey:@"fromid"] isEqualToString:loginId])
        {
            feed.to = [msgDic objectForKey:@"toid"];
        }
        //如果是对方发的消息 fromid toid都是是对方
        else
        {
            feed.to = loginId;
        }
    }
    else
    {
        feed.relateId = [msgDic objectForKey:@"relativeld"];
        feed.to = [msgDic objectForKey:@"relativeld"];
    }
    feed.sumCount = [[msgDic objectForKey:@"sumcount"] integerValue];
    feed.sendOrder = [[msgDic objectForKey:@"sendorder"] integerValue];
    feed.from = [msgDic objectForKey:@"fromid"];
    feed.msg = [msgDic objectForKey:@"msg"];
    feed.time = [msgDic objectForKey:@"msgtime"];
    feed.sendStatus = SendSuccess;
    [[LongMsgDataHelper sharedService] insertALongMsgToDB:feed];
    //看是否获取了全部
    BOOL result = [[LongMsgDataHelper sharedService] querySendResultWithInfoID:feed.infoID  withRelativeId:[feed.relateId integerValue]];
    ChatMessagesFeed *aFeed = nil;
    if (result)
    {
        aFeed = [self combineLongMsgsWithLongMsgFeed:feed];

    }
    [feed release];
    return aFeed;
}
- (ChatMessagesFeed *)combineLongMsgsWithLongMsgFeed:(LongMsgFeed *)longFeed
{
    NSMutableArray *arr = [[LongMsgDataHelper sharedService] combineLongMsgsWithInfoId:longFeed.infoID WithRelateID:longFeed.relateId];
    //取出最早的
    NSString *serialID = nil;
    NSString *msg = @"";
    for (int i=0; i<[arr count]; i++) {
        if (i == 0) {
            serialID = [[arr objectAtIndex:0] objectForKey:@"serialID"];
        }
        msg = [NSString stringWithFormat:@"%@%@",msg,[[arr objectAtIndex:i] objectForKey:@"msg"]];
    }
    [[LongMsgDataHelper sharedService] deleteLongMsgsWithInfoId:longFeed.infoID];

    ChatMessagesFeed *detailFeed = [[ChatMessagesFeed alloc] init];
    if (longFeed.msgType==201) {
        detailFeed.type = 1;
    }
    else
    {
        detailFeed.type = 0;
    }
    detailFeed.isOffLineMessage = 1;
    detailFeed.isMySendMessage = 0;
    NSInteger fromid = [longFeed.from integerValue];
    if (fromid == [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
    {
        fromid = [longFeed.to integerValue];
    }
    detailFeed.relativeId = [longFeed.relateId integerValue];
    detailFeed.fromUserId = [longFeed.from integerValue];
    detailFeed.fromUserName = [[ChatDataHelper sharedService] getUserName:detailFeed.fromUserId];
    detailFeed.message = msg;
    detailFeed.date = serialID;
    detailFeed.toUserId = [longFeed.to integerValue];
    detailFeed.loginid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    detailFeed.sendDate = longFeed.time;
    detailFeed.sendStatus = SendSuccess;
    return detailFeed;
}


#pragma mark - 标志已读的命令
- (void)setHasReadToServer:(NSString *)msgUUID
{
    //向服务器置为已读
    NSString *msgType = @"200";
    if (_conFeed.isGroup) {
        msgType = @"201";
    }
    NSString *relativeID = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *serialId = msgUUID;
    NSArray *hasReadArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"SerialID":serialId},@{@"cmd":@"sendmarkread"},@{@"msgtype":msgType},@{@"toid":relativeID}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:hasReadArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

#pragma mark - 在群组里发送短信需要获取群成员 这是要请求群成员
- (void)addActivityViewToSendBtn
{
    [self removeActivityViewFromSendBtn];
    UIView *aView = [[UIView alloc] initWithFrame:self.messageInputView.sendButton.bounds];
    aView.userInteractionEnabled = NO;
    aView.tag = 346;
    aView.backgroundColor = [UIColor blackColor];
    aView.alpha = 0.5;
    [self.messageInputView.sendButton addSubview:aView];
    [aView release];

    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.frame = CGRectMake(0, 0, CGRectGetHeight(self.messageInputView.sendButton.bounds), CGRectGetHeight(self.messageInputView.sendButton.bounds));
    active.center = CGPointMake(CGRectGetWidth(self.messageInputView.sendButton.bounds)/2,CGRectGetHeight(self.messageInputView.sendButton.bounds)/2);
    [aView addSubview:active];
    active.tag = 345;
    [active startAnimating];
    [active release];
}

- (void)removeActivityViewFromSendBtn
{
    UIView *aView = [self.messageInputView.sendButton viewWithTag:346];
    if (aView) {
        [aView removeFromSuperview];
    }
}

#pragma mark - Messages view controller
// Override from superclass
- (BubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessagesFeed *feed = [self.messageDetailList objectAtIndex:indexPath.row];
    if (!feed) {
        return 0;
    }
    if (feed.fromUserId == [_conFeed.loginId integerValue])
    {
        return BubbleMessageStyleOutgoing;
    }
    else
        return BubbleMessageStyleIncoming;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellID = [NSString stringWithFormat:@"MessageCell"];
    BubbleMessageCell *cell = (BubbleMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    if(!cell) {
        cell = [[[BubbleMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID] autorelease];
        cell.backgroundColor = tableView.backgroundColor;
        cell.bubbleView.delegate = self;
        cell.bubbleView.duanxinBtn = self.messageInputView.msgBtnsView.duanxinBtn;
    }

    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    BubbleMessageStyle style = [self messageStyleForRowAtIndexPath:indexPath];
    [cell.bubbleView setStyle:style];
    
    ChatMessagesFeed *feed = [self.messageDetailList objectAtIndex:indexPath.row];
    //时间：
    [cell setTimeLbText:feed.showDate];
    //传入行数
    cell.bubbleView.selectRow = row;
    //内容
    NSArray *imageArr = [CustomMethod getImageArrFromMessage:feed.message];
    for ( NSTextCheckingResult* result in imageArr)
    {
        NSRange range = NSMakeRange(result.range.location+StartImageContent.length, result.range.length-StartImageContent.length-EndImageContent.length);
        NSString *imageStr = [feed.message substringWithRange:range];
        NSArray *arr = [imageStr componentsSeparatedByString:@";"];
        NSString *smallImageKey = [arr objectAtIndex:1];
        UIImage *image = [[ImageDataHelper sharedService] getImageWithName:smallImageKey];
        if(!image)
        {
            ISTChatImageDowmLoad *theDownloader = nil;
            for(ISTChatImageDowmLoad *downloader in self.downloadImages)
            {
                if( downloader.msgid == feed.date)
                {
                    theDownloader = downloader;
                    break;
                }
            }
            NSString *urlStr = [BubbleView getImageDownLoadUrl:smallImageKey];
            
            if(!theDownloader)
            {//新下载器：
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //这里得用id 值
                    ISTChatImageDowmLoad *imageDownloader = [[ISTChatImageDowmLoad alloc] init];
                    imageDownloader.msgid = feed.date;
                    imageDownloader.smallImageKey = smallImageKey;
                    imageDownloader.delegate = self;
                    [imageDownloader startDownLoadImageData:urlStr];
                    [self.downloadImages addObject:imageDownloader];
                    [imageDownloader release];
                
//                });
            }
        }
    }
    //传入聊天的数据模型
    BOOL isShow = [self isShowTimeLabel:indexPath];
    [cell setBubbleViewWithChatMessageFeed:feed withIsShowTime:isShow];

    //然后计算下面还有多少条
    NSInteger num = [self.messageDetailList count] - row-1;
    if (_bottomUnReadCount > num)
    {
        _bottomUnReadCount = num;
        [self.messageInputView.msgBtnsView setUnReadCountView:_bottomUnReadCount];
    }
    return cell;
}

- (NSString *)getCurrentTimeString
{
    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"SSS"];
    NSString *  locationString=[dateformatter stringFromDate:[NSDate date]];
    //    date = [dateformatter dateFromString:locationString];
    long long int time = ((long long int)[[NSDate date] timeIntervalSince1970])*1000+[locationString intValue];
    long long int sendDate = time - [AppDelegate shareDelegate].serverAndLocalDiff;
    NSString *date=[TimeChangeWithTimeStamp timeStampToFFFTime:sendDate];
    return date;
}
//获取毫秒的时间戳
- (NSString *)getFFFSeriodId:(NSDate *)date
{
    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"SSS"];
    NSString *  locationString=[dateformatter stringFromDate:date];
    NSLog(@"locationString:%@",locationString);
//    date = [dateformatter dateFromString:locationString];
   long long int time = ((long long int)[date timeIntervalSince1970])*1000+[locationString intValue] - [AppDelegate shareDelegate].serverAndLocalDiff;
    return [NSString stringWithFormat:@"%lld",time
            ];
}
#pragma mark - Actions
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    NSString *messageStr= text;
    //消息
    if (_switchSendType == SwitchMessageSendType)
    {
        if ([text hasPrefix:@"[短信]"]) {
            messageStr = [text substringFromIndex:4];
        }
        [self sendMessageStr:messageStr];
    }
    //短信
    else if (_switchSendType == SwitchSMSSendType )
    {
        if (![text hasPrefix:@"[短信]"]) {
            messageStr = [NSString stringWithFormat:@"[短信]%@",text];
        }
        self.nowSendMessage = messageStr;
        NSArray *phoneArr = [_toPhoneStr componentsSeparatedByString:@";"];
        if (_conFeed.isGroup && [phoneArr count]>50) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"群发短信超过50人，确认是否发送。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = kDuanXinAlertTag;
            [alertView show];
            [alertView release];
        }
        else
        {
            [self sendMessageStr:self.nowSendMessage];
        }
    }
}

- (void)sendMessageStr:(NSString *)messageStr
{
    //如果是图片而且没有上传服务器的话就先上传图片  然后在发送  所以这里要先判断是否上传了图片
    if ([messageStr rangeOfString:StartImageContent].location != NSNotFound && [messageStr rangeOfString:EndImageContent].location != NSNotFound)
    {
        NSString *msg = [messageStr substringWithRange:NSMakeRange(StartImageContent.length, [messageStr length]-StartImageContent.length - EndImageContent.length)];
        NSString *bigImageKey = [[msg componentsSeparatedByString:@";"] objectAtIndex:1];
        if ([bigImageKey hasPrefix:kLocalImageStart]) {
            UIImage *image = [[ImageDataHelper sharedService] getImageWithName:bigImageKey];
            [self sendImage:image];
            return;
        }
    }
    NSString *serialID = [NSString createUUID];
    ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
    feed.relativeId = _conFeed.relativeId;
    feed.type = _conFeed.isGroup;
    feed.fromUserId = [_conFeed.loginId integerValue];
    feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
    feed.message = messageStr;
    feed.isMySendMessage = 1;
    feed.date = serialID;
    feed.loginid = _conFeed.loginId;
    feed.toUserId = _conFeed.relativeId;
    feed.isOffLineMessage = NO;
    feed.sendStatus = OnSending;
    feed.sendDate = [self getCurrentTimeString];
    feed = [self addAttributedLabelToChatMessageFeed:feed];
    //首先要插入消息记录的数据库 群组
    [[ChatDataHelper sharedService] insertAMessage:feed];
    //插入数据库是毫秒的时间  然后界面显示的是分钟格式
    feed.showDate = [TimeChangeWithTimeStamp getMMTimeFromFFFTime:feed.sendDate];
    [self.messageDetailList addObject:feed];
    [feed release];
    [self sendChatMessageFeed:feed];
}

- (void)sendChatMessageFeed:(ChatMessagesFeed *)feed
{
    [self finishSendText:nil];
    NSString *toSessionId = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    NSString *sessionId = _conFeed.loginId;
    
    NSString *tmpMessage = feed.message;
    
    //如果是短信发送的话 要只发[短信]和大图的路径  这样短信消息里图片路径可点
    if(_switchSendType == SwitchSMSSendType)
    {
        NSString *message = @"[短信]";
        //内容
        NSArray *imageArr = [CustomMethod getImageArrFromMessage:tmpMessage];
        for ( NSTextCheckingResult* result in imageArr)
        {
            NSRange range = NSMakeRange(result.range.location+StartImageContent.length, result.range.length-StartImageContent.length-EndImageContent.length);
            NSString *imageStr = [tmpMessage substringWithRange:range];
            NSArray *arr = [imageStr componentsSeparatedByString:@";"];
            NSString *bigImageKey = [arr objectAtIndex:0];
            if (bigImageKey) {
                message = [NSString stringWithFormat:@"%@ %@",message,[BubbleView getImageDownLoadUrl:bigImageKey]];
            }
        }
        if ([imageArr count]) {
            tmpMessage = message;
        }
    }
    
    NSString *sendMessage = [NSString stringWithFormat:@"<![CDATA[%@]]>",[CDATAEncode encodeCDATAStr:tmpMessage]];
    //这里要发通知
    NSString *time = [self getCurrentTimeString];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:toSessionId,@"relativeId",feed.message,@"msg",feed.date,@"date",time,@"time",[NSNumber numberWithBool:_conFeed.isGroup],@"isGroup",[NSNumber numberWithInt:TextMsg],@"messageType", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kMySendMeassage object:nil userInfo:dic];
    //要分段发送的话 1字节长度大于1段  2当前的_switchSendType为SwitchMessageSendType  或_switchSendType为SwitchNoneSendType 且消息发送按钮是选中的
    if ([feed.message length] > KLongMessageSectionLength && _switchSendType == SwitchMessageSendType )
    {
        [self sendLongMsgs:feed.message withSeriod:feed.date];
        return;
    }
    
    //消息
    NSArray *offLineArr = nil;
    if (_switchSendType == SwitchMessageSendType)
    {
        if (_conFeed.isGroup)
        {
            offLineArr = @[@{@"type": @"req"},@{@"cmd":@"groupMsg"},@{@"groupID":toSessionId},@{@"sessionID": sessionId},@{@"SerialID":feed.date},@{@"msg":sendMessage}];
        }
        else
        {
            offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"SerialID":feed.date},@{@"cmd":@"sendMsg"},@{@"toID":toSessionId},@{@"msg":sendMessage}];
        }
    }
    //短信
    else if (_switchSendType == SwitchSMSSendType)
    {
        offLineArr = @[@{@"type": @"rsp"},@{@"cmd":@"SendSMS"},@{@"sessionID": sessionId},@{@"fromphonenum":_myPhoneStr},@{@"SerialID":feed.date},@{@"tophonenum":_toPhoneStr},@{@"msmmsg":sendMessage}];
        if (_conFeed.isGroup) {
            NSString *groupid= [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
            offLineArr = @[@{@"type": @"rsp"},@{@"cmd":@"SendSMS"},@{@"sessionID": sessionId},@{@"fromphonenum":_myPhoneStr},@{@"SerialID":feed.date},@{@"tophonenum":_toPhoneStr},@{@"msmmsg":sendMessage},@{@"groupid": groupid}];
        }
    }
    
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)sendCardWith:(id)sender
{
    [self msgBtnTap];
    [self sendPressed:nil withText:(NSString *)sender];
}

//发送文本：
- (void)sendPressed:(UIButton *)sender
{
    NSString *sendStr = [FaceKeyBoardDeal faceSendStr:self.messageInputView.textView.text];
    [self sendPressed:sender
             withText:sendStr];
}

#pragma mark
- (void)sendLongMsgs:(NSString *)messageStr withSeriod:(NSString *)serialID
{
  
    LongMsgFeed *feed = [[LongMsgFeed alloc] init];
    feed.infoID = serialID;
    feed.sendStatus = OnSending;
    if ([messageStr length]%KLongMessageSectionLength)
    {
        feed.sumCount = (NSInteger)([messageStr length]/KLongMessageSectionLength +1);
    }
    else
    {
        feed.sumCount = (NSInteger)([messageStr length]/KLongMessageSectionLength);
    }

    for (int i = 0; i < feed.sumCount; i ++)
    {
        feed.sendOrder = i+1;
        if (([messageStr length]-KLongMessageSectionLength*i)>KLongMessageSectionLength) {
            NSString *str = [messageStr substringWithRange:NSMakeRange(KLongMessageSectionLength*i,KLongMessageSectionLength)];
            feed.msg = str;
        }
        else
        {
            NSString *str = [messageStr substringWithRange:NSMakeRange(KLongMessageSectionLength*i, [messageStr length]-KLongMessageSectionLength*i)];
            feed.msg = str;
        }
        [self sendSectionLongMsgs:feed];
    }
}
- (void)sendSectionLongMsgs:(LongMsgFeed *)feed
{
    //分段发送
    //    <JoyIM>
    //    <type>req</type>
    //    <sessionID>SESSIONID</sessionID>
    //    <SerialID>时间戳<SerialID>//
    //    <infoID>时间戳<infoID>//长消息群组ID
    //    <cmd>sendLongMsg</cmd>
    //    <sumcount>100</sumcount>总共多少分发条数
    //    <sendorder>1</sendorder>分发顺序
    //    <msgtype>201 群组 200 个人</msgtype>
    //    <toID>DESTINATION_USERID</toID> //是群组就是群组id 是个人用户就是个人id
    //    <msg><![CDATA[MSG_CONTENT]]></msg>
    //    </JoyIM>
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSString *serialID = [NSString createUUID];
    if (feed.sendOrder == 1) {
        serialID = feed.infoID;
    }
    NSString *sumCount = [NSString stringWithFormat:@"%ld",(long)feed.sumCount];
    NSString *sendorder = [NSString stringWithFormat:@"%ld",(long)feed.sendOrder];
    NSString *msgType = nil;
    if (_conFeed.isGroup) {
        feed.msgType = 201;
        msgType = [NSString stringWithFormat:@"%d",201];
    }
    else
    {
        feed.msgType = 200;
        msgType = [NSString stringWithFormat:@"%d",200];
    }
    feed.from = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    feed.serialID = serialID;
    feed.to = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    feed.relateId = feed.to;
    feed.time = [self getCurrentTimeString];
    NSString *msg = [NSString stringWithFormat:@"<![CDATA[%@]]>",[CDATAEncode encodeCDATAStr:feed.msg]];
    NSString *toID = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    NSArray  *offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionID},@{@"SerialID":serialID},@{@"infoID":feed.infoID},@{@"cmd":kSendLongMsg},@{@"sumcount":sumCount},@{@"sendorder":sendorder},@{@"msgtype":msgType},@{@"toID":toID},@{@"msg":msg}];
    [[LongMsgDataHelper sharedService] insertALongMsgToDB:feed];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

#pragma mark - 发送图片的操作
//发送图片：
- (void)sendImage:(UIImage *)image
{
    //本地化
    NSString *originImageKey = [NSString stringWithFormat:@"%@%@_big.jpg",kLocalImageStart,[NSString createUUID]];
    [[ImageDataHelper sharedService] storeWithImage:image imageName:originImageKey];
    NSString *smallImageKey = [NSString stringWithFormat:@"%@%@_small.jpg",kLocalImageStart,[NSString createUUID]];
    UIImage *smallImage= [UIImage getSmallImage:image];
    [[ImageDataHelper sharedService] storeWithImage:smallImage imageName:smallImageKey];
    NSString *seriodID = [NSString createUUID];
    NSString *sendMessage = [NSString stringWithFormat:@"<MsG-PiCtUre>%@;%@</MsG-PiCtUre>",originImageKey,smallImageKey];
    if (_switchSendType == SwitchSMSSendType) {
        sendMessage = [NSString stringWithFormat:@"[短信]%@",sendMessage];
    }

    //自己发送的图片
    ChatMessagesFeed *feed = [[ChatMessagesFeed alloc] init];
    feed.type = _conFeed.isGroup;
    feed.fromUserId = [_conFeed.loginId integerValue];
    feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
    feed.message = sendMessage;
    feed.isMySendMessage = 1;
    feed.date = seriodID;
    feed.loginid = _conFeed.loginId;
    feed.toUserId = _conFeed.relativeId;
    feed.isOffLineMessage = NO;
    feed.sendStatus = OnSending;
    feed.sendDate = [self getCurrentTimeString];
    feed.relativeId = _conFeed.relativeId;
    feed = [self addAttributedLabelToChatMessageFeed:feed];
    //这里先将要发送的图片放到里面去然后再去发送
    [self.tableView beginUpdates];
    [self.messageDetailList addObject:feed];
    [feed release];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:([self.messageDetailList count]-1) inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self scrollToBottomAnimated:YES];
    //这里进行数据库操作
    //首先要插入消息记录的数据库 群组
    [[ChatDataHelper sharedService] insertAMessage:feed];
    //发出通知
    NSString *toSessionId = [NSString stringWithFormat:@"%ld",(long)_conFeed.relativeId];
    NSString *time = [self getCurrentTimeString];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:toSessionId,@"relativeId",sendMessage,@"msg",seriodID,@"date",time,@"time",[NSNumber numberWithBool:_conFeed.isGroup],@"isGroup", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kMySendMeassage object:nil userInfo:dic];
//    NSNumber *idNum = [NSNumber numberWithInt:[[ChatDataHelper sharedService] getMaxIdFromNowChatMessage:_conFeed.relativeId]];
    //这里上传图片 这里之所以要带smallimagekey 是因为小图片要在大图片上传完上传
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:originImageKey,@"big",smallImageKey,@"small",seriodID,@"date", nil];
    [self postBigImageToSeverGetUrl:infoDic];
}
- (void)postBigImageToSeverGetUrl:(NSDictionary *)imageInfo
{
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:imageInfo];
    //首先传大图 然后传小图
    NSString *originImageKey = [imageInfo objectForKey:@"big"];
    UIImage *image = [[ImageDataHelper sharedService] getImageWithName:originImageKey];
    CGSize bigSize;
    if (image.size.height >= image.size.width) {
        bigSize = CGSizeMake(400*image.size.width/image.size.height,400);
    }
    else
    {
        bigSize = CGSizeMake(400,400*image.size.height/image.size.width);
    }
    
    image = [UIImage image:image fitInSize:bigSize];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    [infoDic setValue:imageData forKeyPath:@"image"];
    [infoDic setValue:[NSNumber numberWithInt:_switchSendType] forKey:@"sendType"];
    [[HttpServiceHelper sharedService] requestForType:Http_UploadChatBigImage info:infoDic target:self successSel:@"requestBigFinished:" failedSel:@"requestBigFailed:"];
}

- (void)requestBigFinished:(NSDictionary *)datas
{
    //服务器版本号
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:datas];
    if ([[datas objectForKey:@"status"] intValue] == 1 )
    {
        [returnDic removeObjectForKey:@"status"];
        [returnDic setValue:[returnDic objectForKey:@"info"] forKeyPath:@"bigUrl"];
        [returnDic removeObjectForKey:@"info"];
        [self postSmallImageToSeverGetUrl:returnDic];
    }
    else
    {
        [self updateSendStatusWithSeriod:[datas objectForKey:@"date"] withStatus:SendFailed];
    }
}

- (void)requestBigFailed:(id)sender
{
    NSLog(@"failed:");
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:sender];
    [self updateSendStatusWithSeriod:[returnDic objectForKey:@"date"] withStatus:SendFailed];
}

- (void)postSmallImageToSeverGetUrl:(NSMutableDictionary *)imageInfo
{
    //首先传大图 然后传小图
    NSString *smallImageKey = [imageInfo objectForKey:@"small"];
     UIImage *image = [[ImageDataHelper sharedService] getImageWithName:smallImageKey];
    CGSize smallSize;
    if (image.size.height >= image.size.width) {
        smallSize = CGSizeMake(200*image.size.width/image.size.height,200);
    }
    else
    {
        smallSize = CGSizeMake(200,200*image.size.height/image.size.width);
    }
    
    image = [UIImage image:image fitInSize:smallSize];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    [imageInfo setValue:imageData forKeyPath:@"image"];
    [[HttpServiceHelper sharedService] requestForType:Http_UploadChatSmallImage info:imageInfo target:self successSel:@"requestSmallFinished:" failedSel:@"requestSmallFailed:"];
}

- (void)requestSmallFinished:(NSDictionary *)datas
{
    if ([[datas objectForKey:@"status"] intValue] == 1 )
    {
        [self uploadImageSuccess:datas];
    }
    else
    {
        [self updateSendStatusWithSeriod:[datas objectForKey:@"date"] withStatus:SendFailed];
    }
    //大图片 小图片
}

- (void)requestSmallFailed:(id)sender
{
    NSLog(@"failed:");
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:sender];
    [self updateSendStatusWithSeriod:[returnDic objectForKey:@"date"] withStatus:SendFailed];
}
//上传成功
- (void)uploadImageSuccess:(NSDictionary *)infoDic
{
    //首先操作数据库 将下载的路径存到数据库
    NSString *sendMessage = [NSString stringWithFormat:@"<MsG-PiCtUre>%@;%@</MsG-PiCtUre>",[infoDic objectForKey:@"bigUrl"],[infoDic objectForKey:@"info"]];
    [[ChatDataHelper sharedService] updateMessageContentWithDate:[infoDic objectForKey:@"date"] withMessage:[NSString stringWithFormat:@"<![CDATA[%@]]>", [CDATAEncode encodeCDATAStr:sendMessage]]];

    
    NSString *smallImageKey = [infoDic objectForKey:@"small"];
    NSString *bigImageKey = [infoDic objectForKey:@"big"];
    UIImage *smallImage = [[ImageDataHelper sharedService] getImageWithName:smallImageKey];
    UIImage *bigImage = [[ImageDataHelper sharedService] getImageWithName:bigImageKey];
    [[ImageDataHelper sharedService] storeWithImage:smallImage imageName:[infoDic objectForKey:@"info"]];
    [[ImageDataHelper sharedService] storeWithImage:bigImage imageName:[infoDic objectForKey:@"bigUrl"]];

    //通过socket发送
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.date == %@",[infoDic objectForKey:@"date"]];
    NSArray *filterArr = [self.messageDetailList filteredArrayUsingPredicate:predicate];
    ChatMessagesFeed *feed = [filterArr lastObject];
    feed.message = sendMessage;
    [self sendChatMessageFeed:feed];
}

#pragma mark PullRefreshDelegate methods
//下拉刷新
- (void)pullingTableViewDidHeaderStartLoading:(ISTPullRefreshTableView *)tableView
{
    [self performSelector:@selector(headerReload) withObject:nil afterDelay:0.1];
}

//上拉加载
- (void)pullingTableViewDidFooterStartLoading:(ISTPullRefreshTableView *)tableView
{
    [self performSelector:@selector(footerReload) withObject:nil afterDelay:0.1];
}

- (void)headerReload
{
    //检查网络
    if ([[HttpReachabilityHelper sharedService] checkNetwork:nil]) {
        [self requestMoreDetailInfoWithTakeTime:nil];
    }
    else
    {
        self.nowReadDbSize = 0;
        [self readDbToReloadTableWithSeriodId:nil];
    }
}

- (void)footerReload
{
    [self.tableView tableViewDidFinishedLoading];
}

- (void)receiveRenameNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        [[GroupDataHelper sharedService] renameGroupNameWithName:[infoDic objectForKey:@"newname"] andGroupId:[infoDic objectForKey:@"groupid"]];
        NSString *groupName = [infoDic objectForKey:@"newname"];
        self.titleLable.text = groupName;
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - uialert
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kPhoneAlertTag) {
        [self removeNotOnlineRemindview];
    }
    else if (alertView.tag == kDuanXinAlertTag)
    {
        if (buttonIndex == 1) {
            [self sendMessageStr:self.nowSendMessage];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
