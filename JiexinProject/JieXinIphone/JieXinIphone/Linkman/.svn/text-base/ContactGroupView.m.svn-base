
//
//  ContactGroupView.m
//  JieXinIphone
//
//  Created by 高大鹏 on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "ContactGroupView.h"
#import "SVProgressHUD.h"
#import "CommonCell.h"
#import "LinkDateCenter.h"
#import "GroupDataHelper.h"
#import "ChatConversationListFeed.h"
#import "ChatDetailViewController.h"
#define kLongGR 13213232

@implementation ContactGroupView
{
    BOOL _isRequested;
    CustomAlertView *_customAllertView;
}
@synthesize listView;
@synthesize sourceData;
@synthesize isCanSelect;
@synthesize groupChoose;
@synthesize flagArr;

#pragma mark -
#pragma mark Initialization Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initializeArguments];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupListDataNotification:)
                                                     name:kGroupListData
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupDelMasterNotification:)
                                                     name:kGroupDeleteBatchMaster
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupDelMassNotification:)
                                                     name:kGroupDeleteBatchMass
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveGroupMemberDataNotification:)
                                                     name:kGroupMemberData
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDataNotification:)
                                                     name:@"CreateTmpGroupRet"
                                                   object:nil];
        //修改群组名称
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveRenameNotification:)
                                                     name:kRenameGroupName object:nil];
//        [self requestGroupList];
     }
    return self;
}

- (void)initializeArguments
{
    isCanSelect = NO;
    _isRequested = NO;
    self.isCanLongPress = YES;
    //    sourceData = [[GroupDataHelper sharedService] getAllGroupInfoWithType:1];
    sourceData = [[NSMutableArray alloc] init];
    groupChoose = [[NSMutableArray alloc] init];
    
    flagArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [sourceData count]; ++i)
    {
        [flagArr addObject:[NSNumber numberWithBool:NO]];
    }
}

- (void)loadSubviews
{
    listView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, self.bounds.size.height) style:UITableViewStylePlain];
    listView.dataSource =self;
    listView.delegate = self;
    listView.pullDelegate = self;
    [listView configRefreshType:OnlyHeaderRefresh];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:listView];
}

#pragma mark -
#pragma mark TableView DataSource and Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [sourceData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kGroupCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellIdentifier = @"Cell";
    CommonCell *cell = (CommonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setStyle:GroupStyle];
        //设置cell背景边框
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_bg2.png"]];
        cell.backgroundView = bgImageView;
        [bgImageView release];
        cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_select.png"]] autorelease];
    }
    
    if(isCanSelect)
    {
        cell.delegate = self;
        cell.selectBtn.hidden = NO;
        cell.selectBtn.selected = [[flagArr objectAtIndex:indexPath.row] boolValue];
        tableView.allowsSelection = NO;
        tableView.bounces = NO;
    }
    else
    {
        cell.selectBtn.hidden = YES;
        cell.selectBtn.selected = NO;
        tableView.allowsSelection = YES;
        tableView.bounces = YES;
    }
    
    //增加手势
    if (_isCanLongPress) {
        UILongPressGestureRecognizer *longPressGR = [[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressed:)] autorelease];
        longPressGR.minimumPressDuration = 0.5;
        [cell addGestureRecognizer:longPressGR];
        longPressGR.view.tag = kLongGR + indexPath.row;
    }
    
    NSString *creatorName = [[[LinkDateCenter sharedCenter] getUserNameByUserID:[[sourceData objectAtIndex:indexPath.row] objectForKey:@"creatorID"]] objectForKey:@"nickname"];
    cell.logo.image = [UIImage imageNamed:@"photo_demo.png"];//设置群头像👦
    
    cell.title.text = [NSString stringWithFormat:@"%@ (%@人)",[[sourceData objectAtIndex:indexPath.row] objectForKey:@"name"],[[sourceData objectAtIndex:indexPath.row] objectForKey:@"num"]];
    cell.title.textColor = kDarkerGray;
    cell.subTitle.text = [NSString stringWithFormat:@"群主:%@",creatorName];
    cell.subTitle.textColor = klighterGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[sourceData objectAtIndex:indexPath.row]];
    
    if (self.pushDelegate && [self.pushDelegate respondsToSelector:@selector(pushToGroupChatView:)])
    {
        [self.pushDelegate pushToGroupChatView:dic];
    }
}

#pragma mark -
#pragma mark CommonCell Delegate Methods

-(void)selectCellWith:(CommonCell *)cell withSelected:(BOOL)flag
{
    NSIndexPath *indexPath = [self.listView indexPathForCell:cell];
    [self chooseGroupsWith:indexPath.row withSelected:flag];
    if (flag) {
        [flagArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    }
    else
    {
        [flagArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    }
}

-(void)chooseGroupsWith:(int)count withSelected:(BOOL)flag
{
    if(flag)
    {
        [groupChoose addObject:[sourceData objectAtIndex:count]];
    }
    else
    {
        if ([groupChoose containsObject:[sourceData objectAtIndex:count]])
        {
            [groupChoose removeObject:[sourceData objectAtIndex:count]];
        }
    }
    /*
     if(flag)
     {
     NSString *groupid= [[sourceData objectAtIndex:count] objectForKey:@"id"];
     [groupChoose addObject:groupid];
     }
     else
     {
     NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:groupChoose];
     for (NSString *str in tmpArr)
     {
     if ([[[sourceData objectAtIndex:count] objectForKey:@"id"] isEqualToString:str])
     {
     [groupChoose removeObject:str];
     }
     }
     }
     */
}

#pragma mark -
#pragma mark Refresh and load more Methods

- (void)refreshTable
{
    //刷新代码
    [self requestGroupList];
    
    NSLog(@"刷新");
    self.listView.pullLastRefreshDate = [NSDate date];
    self.listView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    //加载代码
    NSLog(@"加载");
    self.listView.pullTableIsLoadingMore = NO;
}

#pragma mark -
#pragma mark PullTableViewDelegate Methods

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

#pragma mark -
#pragma mark HttpRequest Methods

- (void)requestGroupList
{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *offLineArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"group"},@{@"grouptype":@"1"}];
    
    [[STHUDManager sharedManager] showHUDInView:self];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

#pragma mark -
#pragma mark NotificationReturnDatas

- (void)receiveGroupListDataNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self];
    
    [sourceData removeAllObjects];
    [flagArr removeAllObjects];
    
    if ([[[infoDic objectForKey:@"list"] objectForKey:@"group"] isKindOfClass:[NSDictionary class]])//返回唯一数据
    {
        NSDictionary *groupDic = [[infoDic objectForKey:@"list"] objectForKey:@"group"];
        [sourceData addObject:groupDic];
        
        //查询当前数据库是否存在，不存在插入
        NSMutableArray *groupDBInfo = nil;
        groupDBInfo = [[GroupDataHelper sharedService] getAllGroupid];
        if (![groupDBInfo containsObject:[groupDic objectForKey:@"id"]])
        {
            [self insertGroupToDB:groupDic];
        }
        else
        {
            [self sendRenameGroupNostification:groupDic];

        }
    }
    else   //返回不唯一数据
    {
        NSMutableArray *sourceArr = [[infoDic objectForKey:@"list"] objectForKey:@"group"];
        for (NSMutableDictionary *dic in sourceArr)
        {
            [sourceData addObject:dic];
            
            //查询当前数据库是否存在，不存在插入
            NSMutableArray *groupDBInfo = nil;
            groupDBInfo = [[GroupDataHelper sharedService] getAllGroupid];
            if (![groupDBInfo containsObject:[dic objectForKey:@"id"]])
            {
                [self insertGroupToDB:dic];
            }
            else
            {
                [self sendRenameGroupNostification:dic];
            }
        }
    }
    
    //初始化状态数组❓❓
    for (int i = 0; i < [sourceData count]; ++i)
    {
        [flagArr addObject:[NSNumber numberWithBool:NO]];
    }
    
    if (!self.listView) {
        [self loadSubviews];
    }
    else
    {
        [self.listView reloadData];
    }
    
    _isRequested = NO;
}

- (void)sendRenameGroupNostification:(NSDictionary *)infoDic
{
    BOOL isNameChanged = [[GroupDataHelper sharedService] isNameChanged:infoDic];
    if (isNameChanged) {
        [self updateDB:infoDic];
        [[ChatDataHelper sharedService] updateGroupName:[[infoDic objectForKey:@"id"] integerValue] withGroupName:[infoDic objectForKey:@"name"]];

        NSDictionary *dic = @{@"groupid": [infoDic objectForKey:@"id"],@"newname":[infoDic objectForKey:@"name"],@"result":@"0"};
        [[NSNotificationCenter defaultCenter] postNotificationName:kRenameGroupName object:nil userInfo:dic];
    }
}


- (void)receiveRenameNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",[infoDic objectForKey:@"groupid"]];
        NSArray *filterArr = [sourceData filteredArrayUsingPredicate:predicate];

        if ([filterArr count]) {
            NSInteger beforeRow = [sourceData indexOfObject:[filterArr objectAtIndex:0]];
            
            CommonCell  *cell = (CommonCell *)[self.listView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:beforeRow inSection:0]];
            cell.title.text = [infoDic objectForKey:@"newname"];

        }
        
    }
}

//群主删除-->通知群成员
- (void)receiveGroupDelMasterNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self];
    
    [groupChoose removeAllObjects];
    
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
//        NSMutableArray *tmp = [NSMutableArray arrayWithArray:sourceData];
//        for (NSDictionary *dic in tmp)
//        {
//            if ([[dic objectForKey:@"id"] isEqualToString:[infoDic objectForKey:@"GroupId"]])
//            {
//                [sourceData removeObject:dic];
//                break;
//            }
//        }
//        [self.listView reloadData];
        [self requestGroupList];
        //修改数据库
        NSString *gid = [infoDic objectForKey:@"GroupId"];
        NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM groupInfoTable WHERE groupId = '%@'",gid];
        [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"操作失败"];
    }
}

//成员删除-->通知群成员
- (void)receiveGroupDelMassNotification:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self];
    
    [groupChoose removeAllObjects];
    
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
//        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
//        if ([sessionId isEqualToString:[infoDic objectForKey:@"MemberId"]])
//        {
//            NSMutableArray *tmp = [NSMutableArray arrayWithArray:sourceData];
//            for (NSDictionary *dic in tmp)
//            {
//                if ([[dic objectForKey:@"id"] isEqualToString:[infoDic objectForKey:@"GroupId"]])
//                {
//                    [sourceData removeObject:dic];
//                    break;
//                }
//            }
//            [self.listView reloadData];
//        }
        [self requestGroupList];
        //修改数据库
        NSString *gid = [infoDic objectForKey:@"GroupId"];
        NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM groupInfoTable WHERE groupId = '%@'",gid];
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
    [[STHUDManager sharedManager] hideHUDInView:self];
    [ShowAlertView showAlertViewStr:@"连接错误"];
}

#pragma mark -
#pragma mark operateDB Methods

- (void)insertGroupToDB:(NSDictionary *)dic
{
    NSInteger grouptype = 1;
    if ([[dic objectForKey:@"type"] integerValue]==1)
    {
        grouptype = 2;
    }
    
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (grouptype,groupId,groupName,creatorID,time,num) VALUES (%d,'%@','%@','%@','%@',%d)",grouptype,[dic objectForKey:@"id"],[dic objectForKey:@"name"],[dic objectForKey:@"creatorID"],[dic objectForKey:@"time"],[[dic objectForKey:@"num"] integerValue]];
    [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
}

- (void)updateDB:(NSDictionary *)dic
{
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE groupInfoTable SET groupName='%@',time ='%@',num=%d WHERE  groupId='%@'",[dic objectForKey:@"name"],[dic objectForKey:@"time"],[[dic objectForKey:@"num"] integerValue],[dic objectForKey:@"id"]];
    [[GroupDataHelper sharedService] operateGroupDB:sqlStr];
}

#pragma mark - 长按手势
- (void)longPressed:(UILongPressGestureRecognizer *)sender
{
    if(_customAllertView.tag != kAlertShowTag){
        _customAllertView = [[CustomAlertView alloc] initWithAlertStyle:Group_Style withObject:[self.sourceData objectAtIndex:sender.view.tag - kLongGR]];
        [self addSubview:_customAllertView];
        _customAllertView.tag = kAlertShowTag;
        _customAllertView.delegate = self;
        [_customAllertView release];
    }
}

#pragma mark - CustomAlertView

- (void)groupMember:(NSMutableDictionary *)info andType:(WhatTodo)operateType
{
    operate = operateType;
    [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"name"] forKey:@"groupName"];
    [self getGroupMembers:[info objectForKey:@"id"]];
}

#pragma mark -
#pragma mark socketConnection Methods

- (void)getGroupMembers:(NSString *)str
{
    _isRequested = YES;
    [[STHUDManager sharedManager] showHUDInView:self];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"groupMember"},@{@"groupID": str}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

#pragma mark -
#pragma mark NotificationReturnDatas

- (void)receiveGroupMemberDataNotification:(NSNotification *)notification
{
    if (!_isRequested) {
        return;
    }
    _isRequested = NO;
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self];
    NSMutableArray *membersArr = [[NSMutableArray alloc] init];
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

        switch (operate) {
            case GroupChat:
            {
                NSString *groupName = [[NSUserDefaults standardUserDefaults] objectForKey:@"groupName"];
                
                NSString *memberID = @"";
                for (int i = 0;i < [membersArr count]-1;++i)
                {
                    memberID = [[memberID stringByAppendingString:[membersArr objectAtIndex:i]] stringByAppendingString:@","];
                }
                memberID = [memberID stringByAppendingString:[membersArr lastObject]];
                
                NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
                NSArray *offLineArr = @[@{@"type": @"rsp"},@{@"sessionID": sessionId},@{@"cmd":@"CreateGroup"},@{@"GroupName":groupName},@{@"GroupType":@"2"},@{@"createId":sessionId},@{@"MemberId":memberID}];
                
                NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:offLineArr]];
                _isRequested = YES;
                [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
                [[STHUDManager sharedManager] showHUDInView:self];

            }break;
            case SendMess:
            {
//                NSMutableArray *phonenumbers = [[NSMutableArray alloc] init];
//                for (NSString *userid in membersArr)
//                {
//                   User *user = [[LinkDateCenter sharedCenter] getUserWithUserId:userid];
//                    [phonenumbers addObject:user.mobile];
//                }
                NSMutableArray *userArr = [NSMutableArray array];
                for (NSString *userid in membersArr)
                {
                    User *user = nil;
                    user = [[LinkDateCenter sharedCenter] getUserWithUserId:userid];
                    [userArr addObject:user];
                }
                [self.pushDelegate pushToSendMess:userArr withGroupId:[infoDic objectForKey:@"groupID"]];
                
            }break;
                
            default:
                break;
        }

    }
    else
    {
        [ShowAlertView showAlertViewStr:@"获取群成员失败"];
    }
}



- (void)receiveDataNotification:(NSNotification *)notification
{
    if (!_isRequested)
    {
        return;
    }
    
    NSDictionary *infoDic = [notification userInfo];
    [[STHUDManager sharedManager] hideHUDInView:self];
    _isRequested = NO;
    
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"0"] )
    {
        NSString *groupid = [infoDic objectForKey:@"GroupId"];
        NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        NSInteger gtype = 2;
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"groupName"];
        
        NSString *queryStr = [NSString stringWithFormat:@"INSERT INTO groupInfoTable (groupType,groupId,groupName,creatorID) VALUES (%d,'%@','%@','%@')",(int)gtype,groupid,name,sessionId];
        [[GroupDataHelper sharedService] operateGroupDB:queryStr];
        

        NSDictionary *groupInfo = @{@"groupid":groupid,@"groupname":name};
        [[NSNotificationCenter defaultCenter] postNotificationName:kForumCreateSucceed
                                                                object:nil
                                                              userInfo:groupInfo];
        
        NSDictionary *dic = @{@"id":groupid};
        [self.pushDelegate pushToGroupChatView:dic];
        
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"创建群组失败"];
    }
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupListData object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupDeleteBatchMaster object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGroupDeleteBatchMass object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreateTmpGroupRet" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [listView release];
    [sourceData release];
    [flagArr release];
    [super dealloc];
}


@end
