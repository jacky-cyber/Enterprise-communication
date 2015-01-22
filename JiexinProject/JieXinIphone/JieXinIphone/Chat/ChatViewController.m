//
//  ChatViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatConversationCell.h"
#import "PlaySound.h"
#import "GroupDataHelper.h"
#import "OnLoginConnect.h"

#import "KxMenu.h"
#import "LinkDepartmentView.h"
#import "LinkMakeGroupViewController.h"

#import "KxMenu.h"
#import "LinkMakeGroupViewController.h"
#import "LongMsgFeed.h"
#import "LongMsgDataHelper.h"
#import "CDATAEncode.h"
#import "GroupDataHelper.h"

#define kOnePageCount 12

@interface ChatViewController ()
{
    LinkMakeGroupViewController *_linkMakeGroupViewController;
}

@property (nonatomic, retain) PullTableView *listTableView;
@property (nonatomic, retain) UIView *mainBgView;
@property (nonatomic, retain) NSMutableArray *listArr;
@property (nonatomic, retain) ChatDetailViewController *chatDetail;

@end

@implementation ChatViewController
{
    UIButton *_addChatBtn;
}

- (void)dealloc
{
    self.listTableView = nil;
    self.mainBgView = nil;
    self.listArr = nil;
    self.chatDetail = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //同步消息列表
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveOfflineMsgNotification:)
                                                     name:kFetchOfflineMsg
                                                   object:nil];
   

        //登录成功后再进行数据请求,和加载数据库数据
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSuccessfully)
                                                     name:kLoginSuccess
                                                   object:nil];
        
        //在线消息获取
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveOnlineMsgNotification:)
                                                     name:kOnlineMsg
                                                   object:nil];
        //进入聊天详细的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(enterChatDetail:)
                                                     name:kEnterChatDetail object:nil];
        //当自己发消息时要更新界面
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeConversationList:)
                                                     name:kMySendMeassage object:nil];
        //同步消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateConversationList:)
                                                     name:@"synMsgs" object:nil];
        //当接收在线群组消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupOnlineMsgNotification:)
                                                     name:kGroupOnLineMsg object:nil];
        //接收长消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveLongMsgNotification:)
                                                     name:kFetchLongMsg object:nil];
        //删除一个对话
         [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(deleteAConversationByRelativeId:)
                                                      name:kDeleteAConversation object:nil];
        
        //创建群组成功的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(createTmpGroupSuccess:)
                                                     name:kForumCreateSucceed
                                                   object:nil];
        
        //删除所有会话
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deleteAllConversationsOperate)
                                                     name:kDeleteAllConversation object:nil];
        //获取群组的具体内容
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupDetailInfo:)
                                                     name:kFetchGroupInfo
                                                   object:nil];

        //重新命名群组
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveRenameNotification:)
                                                     name:kRenameGroupName object:nil];
//        //获取群组列表
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(receiveGroupListDataNotification:)
//                                                     name:kGroupListData
//                                                   object:nil];


        
        [self initDefaultDatas];
        
        // Custom initialization
    }
    return self;
}

- (void) initDefaultDatas
{
    self.listArr = [NSMutableArray array];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomNavBar];
    [self initSubViews];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kLoginStatus])
    {
        [self readMoreLastChatPersonsWithNewStart:YES];
    }
	// Do any additional setup after loading the view.
}
- (void)readMoreLastChatPersonsWithNewStart:(BOOL)newStart
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSInteger fromIndex =0;
        if (newStart)
        {
            fromIndex = 0;
        }
        else
        {
            fromIndex = [_listArr count];
        }
        NSMutableArray *arr = [[ChatDataHelper sharedService] readConversationsListWithFromIndex:fromIndex withPageSize:kOnePageCount];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if (newStart) {
                [_listArr removeAllObjects];
            }
            for(ChatConversationListFeed *feed in arr)
            {
                [_listArr addObject:feed];
            }
            [_listTableView reloadData];

        });

    });

}


- (void)initSubViews
{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat +44, kScreen_Width, kScreen_Height  -20-kNavHeight- kTabbarHeight)];
//    aView.backgroundColor = [UIColor redColor];
    self.mainBgView = aView;
    [self.view addSubview:_mainBgView];
    [aView release];
    
    PullTableView *aTableView = [[PullTableView alloc] initWithFrame:_mainBgView.bounds style:UITableViewStylePlain];
    [aTableView configRefreshType:BothRefresh];
    aTableView.pullTableIsLoadingMore = NO;
    aTableView.dataSource =self;
    aTableView.delegate = self;
    aTableView.pullDelegate= self;
//    aTableView.layer.borderWidth = 1;
//    aTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView = aTableView;
    [aTableView release];
    [_mainBgView addSubview:_listTableView];

    
    _addChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addChatBtn setFrame:CGRectMake(270, self.iosChangeFloat+8, 35, 25)];
    [_addChatBtn setImage:[UIImage imageNamed:@"chat_add.png"] forState:UIControlStateNormal];
    [self.view addSubview:_addChatBtn];
    [_addChatBtn addTarget:self action:@selector(addChat:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self initReLoginBt];

}


-(void)groupChat:(Department *)deparment
{
    if(!_linkMakeGroupViewController)
    {
        _linkMakeGroupViewController = [[LinkMakeGroupViewController alloc] init];
    }
    [self.navigationController pushViewController:_linkMakeGroupViewController animated:YES];
}


#pragma mark - 登录成功 加载界面 并且请求数据
- (void)loginSuccessfully
{
    [self getOffLineMessage];
    
}
- (void)getOffLineMessage
{
    NSString *timeStamp = [[NSUserDefaults standardUserDefaults] objectForKey:kRequestOfflineDate];
    if (!timeStamp) {
        timeStamp = @"0";
    }
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"CoversationSyncinfomation"},@{@"takentime":timeStamp},@{@"msgtype":@"200"}];
    NSArray *groupOffLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"CoversationSyncinfomation"},@{@"takentime":timeStamp},@{@"msgtype":@"201"}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    NSString *groupxmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:groupOffLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
    [[YiXinScoketHelper sharedService] sendDataToServer:groupxmlStr];
}


#pragma mark - 获取进入详细的通知
- (void)enterChatDetail:(NSNotification *)notification
{
    [[ChatDataHelper sharedService] upDateUnReadCount:[AppDelegate shareDelegate].nowChatUserId];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.relativeId == %d",[AppDelegate shareDelegate].nowChatUserId];
    NSArray *filterArr = [_listArr filteredArrayUsingPredicate:predicate];
    if ([filterArr count]) {
        NSInteger beforeRow = [_listArr indexOfObject:[filterArr objectAtIndex:0]];
        ChatConversationListFeed *feed  = [_listArr objectAtIndex:beforeRow];
        feed.unread_count = 0;
        
        [_listTableView beginUpdates];
        [_listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:beforeRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        [_listTableView endUpdates];
    }
}
#pragma mark - 获取离线消息
- (void)receiveOfflineMsgNotification:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    NSLog(@"%@",dic);
    self.listTableView.pullTableIsRefreshing = NO;
    NSMutableArray *msgArr = [NSMutableArray array];
    if ([[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"] isKindOfClass:[NSDictionary class]])
    {
        [msgArr addObject:[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"]];
    }
    else if([[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"] isKindOfClass:[NSArray class]])
    {
        msgArr = [NSMutableArray arrayWithArray:[[dic objectForKey:@"list"] objectForKey:@"Syncinfo"]];
    }
    
    //保存下次请求对话列表的时间
    if ([msgArr count])
    {
        NSString *timeStamp = [TimeChangeWithTimeStamp timeToTimeStamp:[NSDate date]];
        [[NSUserDefaults standardUserDefaults] setValue:timeStamp forKey:kRequestOfflineDate];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSMutableArray *relativeIdArr = [NSMutableArray array];
    BOOL isGroup = NO;
    for (NSInteger i = [msgArr count]-1; i>=0; i--)
    {
        NSDictionary *msgDic  = [msgArr objectAtIndex:i];
        //查询出原来的对话
        NSDictionary *beforeMsgDic  = nil;
        //群组
        if ([[msgDic objectForKey:@"msgtype"] integerValue] == 201)
        {
            NSInteger fromid = [[msgDic objectForKey:@"relativeld"] integerValue];
            beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:fromid];
        }
        else
        {
            NSInteger fromid = [[msgDic objectForKey:@"fromid"] integerValue];
            if (fromid == [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
            {
                fromid = [[msgDic objectForKey:@"toid"] integerValue];
            }
            beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:fromid];
        }

        ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        if ([[msgDic objectForKey:@"msgtype"] integerValue] == 201) {
            feed.isGroup = 1;
            feed.relativeId =[[msgDic objectForKey:@"relativeld"] integerValue];
            feed.relativeName = [[GroupDataHelper sharedService] getGroupNameByid:[NSString stringWithFormat:@"%ld",(long)feed.relativeId]];
        }
        else
        {
            feed.isGroup = 0;
            feed.relativeId =[[msgDic objectForKey:@"fromid"] integerValue];
            if (feed.relativeId == [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
            {
                feed.relativeId = [[msgDic objectForKey:@"toid"] integerValue];
            }
            feed.relativeName = [[ChatDataHelper sharedService] getUserName:feed.relativeId];
        };
        
        
        [relativeIdArr addObject:[NSString stringWithFormat:@"%ld",(long)feed.relativeId]];
        if (feed.isGroup) {
            isGroup = YES;
        }
        
        //这里还要查一下数据库  获取联系人的名字
        feed.last_message = [msgDic objectForKey:@"msg"];
        if (![msgDic objectForKey:@"msg"]) {
            feed.last_message = @"";
        }
        feed.msgDate =  [msgDic objectForKey:@"msgtime"] ;
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        feed.unread_count = [[msgDic objectForKey:@"unreadnum"] integerValue];
        //如果是处于当前的聊天  则把数目置0
        if (feed.relativeId == [AppDelegate shareDelegate].nowChatUserId) {
            feed.unread_count = 0;
        }
        else if([feed.last_message isEqualToString:[beforeMsgDic objectForKey:@"last_message"]] && [feed.msgDate isEqualToString:[beforeMsgDic objectForKey:@"msgDate"]])
        {
            feed.unread_count = [[beforeMsgDic objectForKey:@"unread_count"] integerValue];
        }
        else if([[msgDic objectForKey:@"readflag"] isEqualToString:@"1"])
        {
            feed.unread_count = 1;
        }
        else
        {
            feed.unread_count = 0;
        }
        feed.fromUserId = [[msgDic objectForKey:@"fromid"] integerValue];
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        //如果原来有就删除在添加 没有的话就直接添加
        if (beforeMsgDic)
        {
            [[ChatDataHelper sharedService] deleteConversation:feed.relativeId];
        }
        feed.last_message = [self transferMeaningFromMessage:feed.last_message];
        [[ChatDataHelper sharedService] insertConversation:feed];
    }
    //如果没出现在列表里面的则将数据库数据置为已经读过
    [self setHasReadConversation:relativeIdArr withIsGroup:isGroup];
    [self readMoreLastChatPersonsWithNewStart:YES];
}


- (void)receiveOnlineMsgNotification:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    
    NSMutableArray *msgArr = [NSMutableArray array];
    if ([[[dic objectForKey:@"chat"] objectForKey:@"item"] isKindOfClass:[NSDictionary class]])
    {
        [msgArr addObject:[[dic objectForKey:@"chat"] objectForKey:@"item"]];
    }
    else if([[[dic objectForKey:@"chat"] objectForKey:@"item"] isKindOfClass:[NSArray class]])
    {
        msgArr = [NSMutableArray arrayWithArray:[[dic objectForKey:@"chat"] objectForKey:@"item"]];
    }

    for(NSDictionary *msgDic in msgArr)
    {
        NSInteger fromid = [[msgDic objectForKey:@"from"] integerValue];
        if (fromid != [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
        {
            [[PlaySound sharedService] playMessageReceivedSound];
        }
        //首先要插入消息记录的数据库
        NSDictionary *otherDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],@"isGroup",[NSNumber numberWithBool:NO],@"isOffLine", [NSNumber numberWithBool:NO],@"isMySendMessage",nil];

       [self insertAMessageToDb:msgDic
                   withOtherInfo:otherDic];
        
    }
    
    //获取每个对话对象最后的消息 即没有重复的对话对象
    NSMutableArray *conversationArr = [NSMutableArray array];
    while ([msgArr count])
    {
        NSDictionary *msgDic = [msgArr objectAtIndex:0];
        NSString *relativeId = [msgDic objectForKey:@"from"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"from == %@",relativeId];
        NSArray *filterArr = [msgArr filteredArrayUsingPredicate:predicate];
        [conversationArr addObject:filterArr];
        for(NSDictionary *infoDic in filterArr)
        {
            [msgArr removeObject:infoDic];
        }
    }
    
    for(NSArray *converArr in conversationArr)
    {
        NSDictionary *msgDic = [converArr lastObject];
        
        //查询出原来的对话
        
        ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        NSInteger fromid = [[msgDic objectForKey:@"from"] integerValue];
        feed.relativeId = fromid;
        if (fromid == [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
        {
            if ([[msgDic objectForKey:@"RelateId"] integerValue]) {
                feed.relativeId = [[msgDic objectForKey:@"RelateId"] integerValue];
            }
        }
        NSDictionary *beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:feed.relativeId];
        feed.fromUserId = fromid;
        //这里还要查一下数据库  获取联系人的名字
        feed.relativeName = [[ChatDataHelper sharedService] getUserName:feed.relativeId];
        feed.last_message = [msgDic objectForKey:@"msg"];
        feed.msgDate = [msgDic objectForKey:@"time"];
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        feed.unread_count = (NSInteger)[converArr count]+[[beforeMsgDic objectForKey:@"unread_count"] integerValue];
        if (feed.relativeId == [AppDelegate shareDelegate].nowChatUserId || feed.fromUserId== [feed.loginId integerValue]) {
            feed.unread_count = 0;
        }
        feed.isGroup = 0;
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        [self dealToTableWithBeforeDic:beforeMsgDic withNowFeed:feed];
    }
    [[ChatDataHelper sharedService] closeDb];
}

//在线群组
- (void)receiveGroupOnlineMsgNotification:(NSNotification *)notification
{
    
    NSDictionary *dic = [notification userInfo];
    
    NSMutableArray *msgArr = [NSMutableArray array];
//    if ([[dic objectForKey:@"msg"] isKindOfClass:[NSString class]])
//    {
//        [msgArr addObject:[dic objectForKey:@"msg"]];
//    }
//    else if([[dic objectForKey:@"msg"] isKindOfClass:[NSArray class]])
//    {
//        msgArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"msg"]];
//    }
    [msgArr addObject:dic];
    
    //获取消息后分辨是否是图片或贺卡
    for (int i=0; i<[msgArr count]; i++)
    {
        NSDictionary *msgDic  = [msgArr objectAtIndex:i];
        MessageType type = [self dealMessage:[msgDic objectForKey:@"msg"]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:msgDic];
        [dic setValue:[NSNumber numberWithInt:type] forKey:@"messageType"];
        [msgArr replaceObjectAtIndex:i withObject:dic];
    }
    
    for(NSDictionary *msgDic in msgArr)
    {
        
        NSInteger fromid = [[msgDic objectForKey:@"fromid"] integerValue];
        if (fromid != [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
        {
            [[PlaySound sharedService] playMessageReceivedSound];
        }

        //首先要插入消息记录的数据库
        NSDictionary *otherDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"isGroup",[NSNumber numberWithBool:NO],@"isOffLine", [NSNumber numberWithBool:NO],@"isMySendMessage",nil];

        [self insertAMessageToDb:msgDic
                   withOtherInfo:otherDic];
    }
    
    //获取每个对话对象最后的消息 即没有重复的对话对象
    NSMutableArray *conversationArr = [NSMutableArray array];
    while ([msgArr count])
    {
        NSDictionary *msgDic = [msgArr objectAtIndex:0];
        NSString *relativeId = [msgDic objectForKey:@"groupid"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"groupid == %@",relativeId];
        NSArray *filterArr = [msgArr filteredArrayUsingPredicate:predicate];
        [conversationArr addObject:filterArr];
        for(NSDictionary *infoDic in filterArr)
        {
            [msgArr removeObject:infoDic];
        }
    }
    
    for(NSArray *converArr in conversationArr)
    {
        NSDictionary *msgDic = [converArr lastObject];
        
        //查询出原来的对话
        NSDictionary *beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:[[msgDic objectForKey:@"groupid"] integerValue]];
        
        ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
        feed.relativeId =[[msgDic objectForKey:@"groupid"] integerValue];
        //这里还要查一下数据库  获取联系人的名字
        feed.relativeName = [[GroupDataHelper sharedService] getGroupNameByid:[NSString stringWithFormat:@"%ld",(long)feed.relativeId]];
        feed.last_message = [msgDic objectForKey:@"msg"];
        feed.msgDate = [msgDic objectForKey:@"time"];
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        feed.unread_count = (NSInteger)[converArr count]+[[beforeMsgDic objectForKey:@"unread_count"] integerValue];
                feed.isGroup = 1;
        feed.fromUserId = [[msgDic objectForKey:@"fromid"] integerValue];
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        if (feed.relativeId == [AppDelegate shareDelegate].nowChatUserId||feed.fromUserId==[feed.loginId integerValue]) {
            feed.unread_count = 0;
        }

        [self dealToTableWithBeforeDic:beforeMsgDic withNowFeed:feed];
    }
}
//接收长消息
- (void)receiveLongMsgNotification:(NSNotification *)notification
{
    //这里首先插入数据库
    //然后判断个数
    //如果完整 就去拼字符串加入当前对话  并插入详细的数据库
    NSDictionary *dic = [notification userInfo];
    
    NSMutableArray *msgArr = [NSMutableArray array];
    if ([[[dic objectForKey:@"chat"] objectForKey:@"item"] isKindOfClass:[NSString class]])
    {
        [msgArr addObject:[[dic objectForKey:@"chat"] objectForKey:@"item"]];
    }
    else if([[[dic objectForKey:@"chat"] objectForKey:@"item"] isKindOfClass:[NSArray class]])
    {
        msgArr = [NSMutableArray arrayWithArray:[[dic objectForKey:@"chat"] objectForKey:@"item"]];
    }
    else if([[[dic objectForKey:@"chat"] objectForKey:@"item"] isKindOfClass:[NSDictionary class]])
    {
        [msgArr addObject:[[dic objectForKey:@"chat"] objectForKey:@"item"]];
    }
    
//    if ([msgArr count]) {
//        [[PlaySound sharedService] playMessageReceivedSound];
//    }
    for(NSDictionary *msgDic in msgArr)
    {
        //首先要插入消息记录的数据库
        LongMsgFeed *feed = [[LongMsgFeed alloc] init];
        feed.serialID = [msgDic objectForKey:@"SerialID"];
        feed.infoID = [msgDic objectForKey:@"infoID"];
        feed.from = [msgDic objectForKey:@"fromid"];
        feed.to = [msgDic objectForKey:@"toid"];

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
        
        if (feed.msgType == 200)
        {
            //如果是本人发的 就是relateID
            if ([feed.from isEqualToString:feed.to])
            {
                NSLog(@"%@",[msgDic objectForKey:@"RelateId"]);
                if (![[msgDic objectForKey:@"RelateId"] isEqualToString:@"0"]) {
                    feed.relateId = [msgDic objectForKey:@"RelateId"];
                }
                else
                {
                    feed.relateId = feed.from;
                }
            }
            else
            {
                feed.relateId = feed.from;
            }
        }
        else
        {
            feed.relateId = [msgDic objectForKey:@"toid"];
        }
        feed.sumCount = [[msgDic objectForKey:@"sumcount"] integerValue];
        feed.sendOrder = [[msgDic objectForKey:@"sendorder"] integerValue];
        feed.time = [msgDic objectForKey:@"time"];
        feed.msg = [msgDic objectForKey:@"msg"];
        feed.sendStatus = SendSuccess;
        [self sendHasReceivedLongMsg:feed];

        [[LongMsgDataHelper sharedService] insertALongMsgToDB:feed];
        
        if ([msgDic isEqualToDictionary:[msgArr lastObject]]) {
            //看是否获取了全部
            BOOL result = [[LongMsgDataHelper sharedService] querySendResultWithInfoID:feed.infoID withRelativeId:[feed.relateId integerValue]];
            if (result)
            {
                [self combineLongMsgsWithLongMsgFeed:feed];
            }
        }
        [feed release];
    }
}

- (void)setHasReadConversation:(NSArray *)msgRelativeIdArr withIsGroup:(BOOL)isGroup
{
    NSMutableArray *allIdArr = [[ChatDataHelper sharedService] readAllConversationIDWithIsGroup:isGroup];
    for(NSDictionary *dic in allIdArr)
    {
        NSString *relativeId = [dic objectForKey:@"relativeId"];
        NSString *unRead = [dic objectForKey:@"unread_count"];
        if (![msgRelativeIdArr containsObject:relativeId] && [unRead isEqualToString:@"1"]) {
            [[ChatDataHelper sharedService] upDateUnReadCount:[relativeId integerValue]];
        }
    }

}

- (void)sendHasReceivedLongMsg:(LongMsgFeed *)feed
{
    //    接收长消息后发给服务器的
    //    <JoyIM>
    //    <type>rsp</type>
    //    <cmd>fetchLongMsgReply</cmd>
    //    <SerialID>时间戳</SerialID>
    //    <infoID>时间戳<infoID>//
    //    <from>1545942</from>
    //    <sendorder>1</sendorder>分发顺序
    //    <to>3679757</to>
    //    </JoyIM>
    NSArray *arr = @[@{@"type": @"rsp"},@{@"cmd":@"fetchLongMsgReply"},@{@"SerialID":feed.serialID},@{@"infoID":feed.infoID},@{@"from":feed.from},@{@"sendorder":[NSNumber numberWithInteger:feed.sendOrder]},@{@"to":feed.to}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:arr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}
- (void)combineLongMsgsWithLongMsgFeed:(LongMsgFeed *)longFeed
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
    
    NSString *loginID = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    
    [[LongMsgDataHelper sharedService] deleteLongMsgsWithInfoId:longFeed.infoID];
    if (msg && [msg length]&&![longFeed.from isEqualToString:loginID]) {
        [[PlaySound sharedService] playMessageReceivedSound];
    }
//    for(NSDictionary *msgDic in msgArr)
//    {
//        //首先要插入消息记录的数据库
//        NSDictionary *otherDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],@"isGroup",[NSNumber numberWithBool:NO],@"isOffLine", [NSNumber numberWithBool:NO],@"isMySendMessage",nil];
//        [self insertAMessageToDb:msgDic
//                   withOtherInfo:otherDic];
//
//    }
    
    ChatMessagesFeed *detailFeed = [[[ChatMessagesFeed alloc] init] autorelease];
    if (longFeed.msgType == 201) {
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
    BOOL result = [[ChatDataHelper sharedService] inertOnlineMsg:detailFeed];
    if (result && detailFeed.relativeId == [AppDelegate shareDelegate].nowChatUserId)
    {
        [self insertAMsgIntoNowChat:detailFeed];
    }
    
    //查询出原来的对话
    NSDictionary *beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:[longFeed.relateId integerValue]];
    
    ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
//    int fromid = [longFeed.from integerValue];
//    if (fromid == [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue])
//    {
//        fromid = [longFeed.to integerValue];
//    }
    feed.relativeId = detailFeed.relativeId;
    feed.fromUserId = [longFeed.from integerValue];
    //这里还要查一下数据库  获取联系人的名字
    feed.relativeName = [[ChatDataHelper sharedService] getUserName:feed.relativeId];
    feed.last_message = msg;
    feed.msgDate = longFeed.time;
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    feed.unread_count = 1+[[beforeMsgDic objectForKey:@"unread_count"] integerValue];
    if (feed.relativeId == [AppDelegate shareDelegate].nowChatUserId||feed.fromUserId==[feed.loginId integerValue]) {
        feed.unread_count = 0;
    }
    feed.isGroup = 0;
    if (longFeed.msgType == 201) {
        feed.isGroup = 1;
        feed.relativeName = [[GroupDataHelper sharedService] getGroupNameByid:[NSString stringWithFormat:@"%ld",(long)feed.relativeId]];
    }
    feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
    [self dealToTableWithBeforeDic:beforeMsgDic withNowFeed:feed];
    [[ChatDataHelper sharedService] closeDb];
}

- (MessageType)dealMessage:(NSString *)oldStr
{
    if ([oldStr rangeOfString:@"Greeting"].location != NSNotFound)
    {
        return HeKaMsg;
    }
    else if ([oldStr rangeOfString:@"<MsG-PiCtUre"].location != NSNotFound)
    {
        return PicMsg;
    }
    else
    {
        return TextMsg;
    }
}

//插入一条聊天记录到数据库
- (BOOL)insertAMessageToDb:(NSDictionary *)msgDic
               withOtherInfo:(NSDictionary *)infoDic
{
    BOOL isGroup = [[infoDic objectForKey:@"isGroup"] boolValue];
    BOOL isOffLineMessage = [[infoDic objectForKey:@"isOffLine"] boolValue];
    BOOL isMySendMessage = [[infoDic objectForKey:@"isMySendMessage"] boolValue];
    
    ChatMessagesFeed *feed = [[[ChatMessagesFeed alloc] init] autorelease];
        //
    if (isGroup)
    {
        feed.type = 1;
    }
    else
    {
        feed.type = 0;
    }
    if (isOffLineMessage)
    {
        feed.isOffLineMessage = 1;
    }
    else
    {
        feed.isOffLineMessage = 0;
    }
    if (isMySendMessage)
    {
        feed.isMySendMessage = 1;
    }
    else
    {
        feed.isMySendMessage = 0;
    }
    

    //个人的在线消息
    if (!isGroup && !isOffLineMessage)
    {
        //消息类型
        feed.messageType = [[msgDic objectForKey:@"messageType"] integerValue];
        NSInteger fromid = [[msgDic objectForKey:@"from"] integerValue];
        if (fromid == [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue] && [[msgDic objectForKey:@"RelateId"] integerValue] != 0)
        {
            fromid = [[msgDic objectForKey:@"RelateId"] integerValue];
        }
        feed.relativeId = fromid;
        feed.fromUserId = [[msgDic objectForKey:@"from"] integerValue];
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        feed.message = [msgDic objectForKey:@"msg"];
        feed.date = [msgDic objectForKey:@"SerialID"];
        feed.toUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue];
        feed.loginid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        feed.sendDate = [msgDic objectForKey:@"time"];
        feed.sendStatus = 1;
        [self sendHasReceivePersonMsg:feed];
    }
    //离线消息
//    else if (!isGroup && isOffLineMessage)
    else if (isOffLineMessage)
    {
        //离线群组
        if (feed.type) {
            feed.relativeId = [[msgDic objectForKey:@"relativeld"] integerValue];

        }
        else
        {
            feed.relativeId = [AppDelegate shareDelegate].nowChatUserId;
        }
        feed.fromUserId = [[msgDic objectForKey:@"fromid"] integerValue];
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        feed.date = [msgDic objectForKey:@"msgid"];
        feed.message = [msgDic objectForKey:@"msg"];
        feed.toUserId = [[msgDic objectForKey:@"toid"] integerValue];
        feed.loginid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        feed.sendDate = [msgDic objectForKey:@"msgtime"];
        feed.sendStatus = 1;
    }
    // 群组在线消息
    else if (!isOffLineMessage)
    {
        feed.relativeId = [[msgDic objectForKey:@"groupid"] integerValue];
        feed.fromUserId = [[msgDic objectForKey:@"fromid"] integerValue];
        feed.fromUserName = [[ChatDataHelper sharedService] getUserName:feed.fromUserId];
        feed.message = [msgDic objectForKey:@"msg"];
//        feed.date = [TimeChangeWithTimeStamp timeStampToTime:[msgDic objectForKey:@"SerialID"]] ;
        feed.date = [msgDic objectForKey:@"SerialID"];
        if (!feed.date) {
            feed.date = @"";
        }
        feed.toUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId] integerValue];
        feed.loginid = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        feed.sendDate = [msgDic objectForKey:@"time"];
        feed.sendStatus = 1;
        [self sendHasReceiveGroupMsg:feed];
    }

    
    BOOL result = [[ChatDataHelper sharedService] inertOnlineMsg:feed];
    // 出入数据库成功 且详细页面存在 同时id相同
//    if( feed.isOffLineMessage)
//    {
//        [self insertAMsgIntoNowChat:feed];
//    }
//    else
//    {
        if (result && feed.relativeId == [AppDelegate shareDelegate].nowChatUserId)
        {
            [self insertAMsgIntoNowChat:feed];
        }
//    }
    
   return YES;
}


- (void)sendHasReceivePersonMsg:(ChatMessagesFeed *)feed
{
    //回执给个人
    //    <JoyIM>
    //    <type>rsp</type>
    //    <cmd>fetchMsgReply</cmd>
    //    <SerialID>时间戳</SerialID>
    //    <from>1545942</from>
    //    <to>3679757</to>
    //    </JoyIM>
    NSArray *arr = @[@{@"type": @"rsp"},@{@"cmd":@"fetchMsgReply"},@{@"SerialID":feed.date},@{@"from":[NSNumber numberWithInteger:feed.fromUserId]},@{@"to":[NSNumber numberWithInteger:feed.toUserId]}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:arr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];

}
- (void)sendHasReceiveGroupMsg:(ChatMessagesFeed *)feed
{
    //群组给服务器回执
    //    <JoyIM>
    //    <type>rsp</type>
    //    <cmd>fetchGroupMsgReply</cmd>
    //    <sessionID>SESSION_ID</sessionID>
    //    <SerialID>时间戳</SerialID>
    //    <from>1545942</from>
    //    <groupid>groupid</groupid>
    //    </JoyIM>
    NSArray *arr = @[@{@"type": @"rsp"},@{@"cmd":@"fetchGroupMsgReply"},@{@"SerialID":feed.date},@{@"from":[NSNumber numberWithInteger:feed.fromUserId]},@{@"to":[NSNumber numberWithInteger:feed.relativeId]}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:arr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

//插入当前聊天一条记录
- (void)insertAMsgIntoNowChat:(ChatMessagesFeed *)feed
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSInteger maxId = [[ChatDataHelper sharedService] getMaxIdFromNowChatMessage:feed.relativeId];
//        feed.Id = maxId;
        //发送条数据通知给当前的聊天界面
        [[NSNotificationCenter defaultCenter] postNotificationName:kInsertAMessageIntoNowChat
                                                            object:nil
                                                          userInfo:@{@"feed": feed}];

        
//    });

}

- (void)dealToTableWithBeforeDic:(NSDictionary *)beforeMsgDic withNowFeed:(ChatConversationListFeed *)feed
{
    feed.last_message = [self transferMeaningFromMessage:feed.last_message];
    //如果原来有就删除在添加 没有的话就直接添加
    if (beforeMsgDic)
    {
        [[ChatDataHelper sharedService] deleteConversation:feed.relativeId];
        [[ChatDataHelper sharedService] insertConversation:feed];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.relativeId == %ld",(long)feed.relativeId];
        NSArray *filterArr = [_listArr filteredArrayUsingPredicate:predicate];
        if ([filterArr count])
        {
            NSInteger beforeRow = [_listArr indexOfObject:[filterArr objectAtIndex:0]];
            [_listTableView beginUpdates];
            [_listArr removeObjectAtIndex:beforeRow];
            [_listArr insertObject:feed atIndex:0];
            [_listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:beforeRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            [_listTableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            [_listTableView endUpdates];
        }
    }
    else
    {
        [[ChatDataHelper sharedService] insertConversation:feed];
        
        [_listTableView beginUpdates];
        [_listArr insertObject:feed atIndex:0];
        [_listTableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        [_listTableView endUpdates];
    }
}

#pragma mark - 创建讨论组成功
- (void)createTmpGroupSuccess:(NSNotification *)notification
{
    //查询出原来的对话
    NSDictionary *dic = [notification userInfo];
    ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    feed.relativeId =[[dic objectForKey:@"groupid"] integerValue];
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    //这里还要查一下数据库  获取联系人的名字
    feed.relativeName = [dic objectForKey:@"groupname"];
    feed.fromUserName = [dic objectForKey:@"groupname"];
    feed.last_message = @"";
    feed.unread_count = 0;
    feed.isGroup = 1;
    feed.fromUserId = feed.relativeId;
    [self dealToTableWithBeforeDic:nil withNowFeed:feed];
}

#pragma mark - 获取群组详细内容后
- (void)receiveGroupDetailInfo:(NSNotification *)notification
{
    NSLog(@"%@",notification.userInfo);
    NSDictionary *infoDic = notification.userInfo;
    
//    if ([[infoDic objectForKey:@"result"] integerValue] == 1)
//    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.relativeId == %d",[[infoDic objectForKey:@"id"] integerValue]];
        NSArray *filterArr = [_listArr filteredArrayUsingPredicate:predicate];
        
        if ([filterArr count]) {
            NSInteger beforeRow = [_listArr indexOfObject:[filterArr objectAtIndex:0]];
            ChatConversationListFeed *feed  = [_listArr objectAtIndex:beforeRow];
            feed.relativeName = [infoDic objectForKey:@"name"];
            [[ChatDataHelper sharedService] updateGroupName:feed.relativeId withGroupName:feed.relativeName];
            [_listTableView beginUpdates];
            [_listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:beforeRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            [_listTableView endUpdates];
        }
//    }
}

#pragma mark - 获取群组详细内容后
- (void)receiveRenameNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self.view];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        [[GroupDataHelper sharedService] renameGroupNameWithName:[infoDic objectForKey:@"newname"] andGroupId:[infoDic objectForKey:@"groupid"]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.relativeId == %d",[[infoDic objectForKey:@"groupid"] integerValue]];
        NSArray *filterArr = [_listArr filteredArrayUsingPredicate:predicate];
        
        if ([filterArr count]) {
            NSInteger beforeRow = [_listArr indexOfObject:[filterArr objectAtIndex:0]];
            ChatConversationListFeed *feed  = [_listArr objectAtIndex:beforeRow];
            feed.relativeName = [infoDic objectForKey:@"newname"];
            
            [_listTableView beginUpdates];
            [_listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:beforeRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            [_listTableView endUpdates];
        }

    }
}

#pragma mark - changeCon

- (void)changeConversationList:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    //查询出原来的对话
    NSInteger relativeId = [[infoDic objectForKey:@"relativeId"] integerValue];
    NSDictionary *beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:relativeId];
    
    ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    feed.relativeId = relativeId;
    feed.last_message = [infoDic objectForKey:@"msg"];
    feed.msgDate = [infoDic objectForKey:@"time"];
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    feed.unread_count = 0;
    if (feed.relativeId == [AppDelegate shareDelegate].nowChatUserId) {
        feed.unread_count = 0;
    }

    feed.isGroup = [[infoDic objectForKey:@"isGroup"] integerValue];
    if (!feed.isGroup)
    {
        //这里还要查一下数据库  联系人的名字
        feed.relativeName = [[ChatDataHelper sharedService] getUserName:feed.relativeId];
    }
    else
    {
        feed.relativeName = [[GroupDataHelper sharedService] getGroupNameByid:[NSString stringWithFormat:@"%ld",(long)feed.relativeId]];
    }
    feed.fromUserId = feed.relativeId;
    feed.fromUserName = @"我";
    
    //如果原来有就删除在添加 没有的话就直接添加
    [self dealToTableWithBeforeDic:beforeMsgDic withNowFeed:feed];
}

- (void)updateConversationList:(NSNotification *)notification
{
    NSDictionary *infoDic =  [notification userInfo];
    ChatMessagesFeed *msgFeed = [infoDic objectForKey:@"feed"];
    NSInteger relativeId = msgFeed.relativeId;
    
    NSDictionary *beforeMsgDic  = [[ChatDataHelper sharedService] queryRowWith:relativeId];
    ChatConversationListFeed *feed = [[[ChatConversationListFeed alloc] init] autorelease];
    feed.relativeId = relativeId;
    feed.last_message = msgFeed.message;
    feed.msgDate = msgFeed.sendDate;
    feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    feed.unread_count = 0;
    if (feed.relativeId == [AppDelegate shareDelegate].nowChatUserId) {
        feed.unread_count = 0;
    }
    feed.isGroup = msgFeed.type;
    if (!feed.isGroup)
    {
        //这里还要查一下数据库  联系人的名字
        feed.relativeName = [[ChatDataHelper sharedService] getUserName:feed.relativeId];
    }
    else
    {
        feed.relativeName = [[GroupDataHelper sharedService] getGroupNameByid:[NSString stringWithFormat:@"%ld",(long)feed.relativeId]];
    }
    feed.fromUserId = feed.relativeId;
    feed.fromUserName =msgFeed.fromUserName;
    feed.last_message = [self transferMeaningFromMessage:feed.last_message];
    if (beforeMsgDic)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.relativeId == %ld",(long)feed.relativeId];
        NSArray *filterArr = [_listArr filteredArrayUsingPredicate:predicate];
        if ([filterArr count])
        {
            NSInteger beforeRow = [_listArr indexOfObject:[filterArr objectAtIndex:0]];
            [_listTableView beginUpdates];
            [_listArr replaceObjectAtIndex:beforeRow withObject:feed];
            [_listTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:beforeRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            [_listTableView endUpdates];
        }
    }
}

- (void)deleteAConversationByRelativeId:(NSNotification *)notification
{
    NSInteger relativeId = [[[notification userInfo] objectForKey:@"groupid"] integerValue];
    // 先找到第几行 再去删除
    [[ChatDataHelper sharedService] deleteConversation:relativeId];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.relativeId == %d",relativeId];
    NSArray *filterArr = [_listArr filteredArrayUsingPredicate:predicate];
    
    if ([filterArr count]) {
        NSInteger beforeRow = [_listArr indexOfObject:[filterArr objectAtIndex:0]];
        [_listTableView beginUpdates];
        [_listArr removeObjectAtIndex:beforeRow];
        [_listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:beforeRow inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        [_listTableView endUpdates];
    }
}
#pragma mark - tap

- (void)deleteConversation:(NSInteger)row
{
    ChatConversationListFeed *feed = [_listArr objectAtIndex:row];
    BOOL resutl = [[ChatDataHelper sharedService] deleteConversation:feed.relativeId];
    if (resutl)
    {
        [_listTableView beginUpdates];
        [_listArr removeObjectAtIndex:row];
        [_listTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        [_listTableView endUpdates];
    }
    else
    {
//        [ShowAlertView showAlertViewStr:@"删除失败"];
    }
}

//删除所有会话
- (void)deleteAllConversationsOperate
{
    [self.listArr removeAllObjects];
    [self.listTableView reloadData];
}

#pragma mark -
#pragma mark TableView DataSource and Delegate
- (NSString *)transferMeaningFromMessage:(NSString *)message
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionPlist" ofType:@"plist"];
    NSDictionary *imageNameDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    NSString *facePath = [[NSBundle mainBundle] pathForResource:@"faceList" ofType:@"plist"];
    NSDictionary *faceDic = [NSMutableDictionary dictionaryWithContentsOfFile:facePath];
    if (!message) {
        return @"";
    }
    NSMutableString *str = [[[NSMutableString alloc] initWithString:message] autorelease];
    NSArray *keyArr = [imageNameDic allKeys];
    for(NSString *key in keyArr)
    {
        NSString *value = [imageNameDic objectForKey:key];
        BOOL isExist = YES;
        while(isExist)
        {
            NSRange range =  [str rangeOfString:value];
            if (range.length) {
                NSString *nameStr = [faceDic objectForKey:key];
                [str replaceCharactersInRange:range withString:nameStr];
            }
            else
            {
                isExist = NO;
            }
        }
    }
    return str;
}

#pragma mark -
#pragma mark TableView DataSource and Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kChatConCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置正常群组Cell
    static NSString * const ChatConCellIdentifier = @"ChatConCellIdentifier";
    ChatConversationCell *cell = (ChatConversationCell *)[tableView dequeueReusableCellWithIdentifier:ChatConCellIdentifier];
    if (!cell)
    {
        cell = [[[ChatConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChatConCellIdentifier] autorelease];
    }
    ChatConversationListFeed *feed = [_listArr objectAtIndex:indexPath.row];
    [cell setDatas:feed];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
    detail.conFeed = [_listArr objectAtIndex:indexPath.row];
    [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
    [detail release];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deleteConversation:indexPath.row];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark -
#pragma mark Refresh and load more methods

- (void)refreshTable
{
    //刷新代码
    NSLog(@"刷新");
    [self getOffLineMessage];
    self.listTableView.pullLastRefreshDate = [NSDate date];
}

- (void)loadMoreDataToTable
{
    //加载代码
    NSLog(@"加载");
    [self readMoreLastChatPersonsWithNewStart:NO];
    self.listTableView.pullLastRefreshDate = [NSDate date];
    self.listTableView.pullTableIsLoadingMore = NO;
}

#pragma mark -
#pragma mark PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

- (void)createCustomNavBar
{
    [super createCustomNavBar];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                linkMakeGroupView.sendType = MultiChat_type;
                [[AppDelegate shareDelegate].rootNavigation pushViewController:linkMakeGroupView animated:YES];
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

@end
