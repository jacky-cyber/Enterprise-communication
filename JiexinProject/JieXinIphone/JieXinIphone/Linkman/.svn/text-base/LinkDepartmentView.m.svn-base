//
//  LinkDepartmentView.m
//  JieXinIphone
//
//  Created by tony on 14-2-19.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkDepartmentView.h"
#import "LinkDateCenter.h"
#import "SynUserIcon.h"
#import "IPhone_CustomListCell.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
#import "NGLABAL_DEFINE.h"
#import "HttpReachabilityHelper.h"
#define kDepartmentLongGR 1321313
#define kUserLongGR 1321421
#define kCommonHeight 45.0f

@implementation LinkDepartmentView
{
    CGFloat _memorySeat;
    NSInteger _index;//当前点击的row
    NSIndexPath *_memoryIndex;
    NSInteger _totalCount;
    NSInteger _previousTotalCount;
    NSMutableArray *_currentAddArray;
    
    UIImageView *_iconImageView;
    UIImageView *_searchImageView;
    
    BOOL _isSearchTextShow;
    BOOL _isFirstGetAllStatusFinish;
    UILabel *_countLabel;//最上面的总在线数目
    
     NSTimer *_timer;
    
    NSArray *_rootDeparmentArray;
    BOOL _isHaveOneRoot;//是否只有一个根
    
    UIImageView *_enlargView;
}

@synthesize headerButton = _headerButton;
@synthesize linkSearchResultView = _linkSearchResultView;
@synthesize searchTextField = _searchTextField;
@synthesize tableListView = _tableListView;
@synthesize datasArray = _datasArray;
@synthesize delegate = _delegate;
@synthesize choosedDepartments = _choosedDepartments;
@synthesize choosedUsers = _choosedUsers;
@synthesize linkViewStyle = _linkViewStyle;
@synthesize currentAdroidArray = _currentAdroidArray;
@synthesize currentBusyArray = _currentBusyArray;
@synthesize currentWebArray = _currentWebArray;
@synthesize currentOnlineArray = _currentOnlineArray;
@synthesize currentIPhoneArray = _currentIPhoneArray;
@synthesize currentLeaveArray = _currentLeaveArray;
@synthesize webStr = _webStr,adriodStr = _adriodStr,leaveStr = _leaveStr,iphoneStr = _iphoneStr,onlineStr = _onlineStr,busyStr = _busyStr;
@synthesize rootDepartment = _rootDepartment;
@synthesize currentAddArray = _currentAddArray;
@synthesize _customAllertView;
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGetAllUserStatus object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccess object:nil];
     [_enlargView release];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [_rootDepartment release];
    [_countLabel release];
    [_searchTextField release];
    [_linkSearchResultView release];
//    [_rootDeparmentArray release];

    if(self._customAllertView)
    {
        self._customAllertView = nil;
    }
    [_searchImageView release];
    if(_choosedDepartments)
        [_choosedDepartments release];
    if(_choosedUsers)
        [_choosedUsers release];
    [_expandDepartArray release];
    [_currentAddArray release];
    
    [_currentWebArray release];
    [_currentBusyArray release];
    [_currentAdroidArray release];
    [_currentLeaveArray release];
    [_currentIPhoneArray release];
    [_currentOnlineArray release];
    
    [_adriodStr release];
    [_iphoneStr release];
    [_busyStr release];
    [_webStr release];
    [_onlineStr release];
    [_leaveStr release];
    
    [_tableListView release];
    [self.datasArray release];
    self.sendOtherMessage = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withLinkViewStyle:(LinkDepartmentViewStyle)linkStyle
{
    self.linkViewStyle = linkStyle;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
       
        [self initData];//初始化所有的数据
        //注册通知
        [self registerNotification];
        [self initTable];//初始化表格
        [self getDefualtData];//获取初始化数据
        if(self.linkViewStyle == LinkDepartmentView_search)
            [self initSearchView];//加载搜索框
        [self getAllUserStatus];//获取用户状态
        
        
        _enlargView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _enlargView.backgroundColor = [UIColor blackColor];
        _enlargView.contentMode = UIViewContentModeCenter;
        
        UIButton *enlargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        enlargeBtn.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
        [enlargeBtn setTitle:@"" forState:UIControlStateNormal];
        [enlargeBtn addTarget:self action:@selector(removeEnlargeView:) forControlEvents:UIControlEventTouchUpInside];
        
        _enlargView.userInteractionEnabled = YES;
        [_enlargView addSubview:enlargeBtn];
        
        //取消定时器
        //[self startListenTimer];
        // Initialization code
    }
    return self;
}

-(void)initData
{
    _index = 0;//当前点击的row
    if(_memoryIndex)
    {
        _memoryIndex = nil;
    }
    _memoryIndex = [[NSIndexPath alloc] init];
    _totalCount = 0;
    _previousTotalCount = 0;
    
    _memorySeat = 0.0f;
    if(self.choosedUsers)
    {
        self.choosedUsers = nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.choosedUsers = tempArray;
    [tempArray release];
    if(_choosedDepartments)
    {
        [_choosedDepartments release];
    }
    _choosedDepartments = [[NSMutableArray alloc] init];
    
    if(_expandDepartArray)
    {
        [_expandDepartArray release];
    }
    _expandDepartArray = [[NSMutableArray alloc] init];
    
    if(_rootDeparmentArray)
    {
        [_rootDeparmentArray release];
    }
    _rootDeparmentArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempAddArray = [[NSMutableArray alloc] init];
    self.currentAddArray = tempAddArray;
    [tempAddArray release];
    
    NSMutableArray *tempDatasArray = [[NSMutableArray alloc] init];
    self.datasArray = tempDatasArray;
    [tempDatasArray release];
    
    NSMutableArray *tempLeaveArray = [[NSMutableArray alloc] init];
    self.currentLeaveArray = tempLeaveArray;
    [tempLeaveArray release];
    
    NSMutableArray *tempIPhoneArray = [[NSMutableArray alloc] init];
    self.currentIPhoneArray = tempIPhoneArray;
    [tempIPhoneArray release];
    
    NSMutableArray *tempAdriodArray = [[NSMutableArray alloc] init];
    self.currentAdroidArray = tempAdriodArray;
    [tempAdriodArray release];
    
    NSMutableArray *tempBusyArray = [[NSMutableArray alloc] init];
    self.currentBusyArray = tempBusyArray;
    [tempBusyArray release];
    
    NSMutableArray *tempOnlineArray = [[NSMutableArray alloc] init];
    self.currentOnlineArray = tempOnlineArray;
    [tempOnlineArray release];
    
    NSMutableArray *tempWebArray = [[NSMutableArray alloc] init];
    self.currentWebArray = tempWebArray;
    [tempWebArray release];
    
    NSMutableString *tempIphoneStr = [[NSMutableString alloc] init];
    self.iphoneStr = tempIphoneStr;
    [tempIphoneStr release];
    
    NSMutableString *tempAdriodStr = [[NSMutableString alloc] init];
    self.adriodStr = tempAdriodStr;
    [tempAdriodStr release];
    
    NSMutableString *tempLeaveStr = [[NSMutableString alloc] init];
    self.leaveStr = tempLeaveStr;
    [tempLeaveStr release];
    
    NSMutableString *tempOnlineStr = [[NSMutableString alloc] init];
    self.onlineStr = tempLeaveStr;
    [tempOnlineStr release];
    
    NSMutableString *tempWebStr = [[NSMutableString alloc] init];
    self.webStr = tempWebStr;
    [tempWebStr release];
    
    NSMutableString *tempBusyStr = [[NSMutableString alloc] init];
    self.busyStr = tempBusyStr;
    [tempBusyStr release];
    
    Department *tempDepartment = [[Department alloc] init];
    self.rootDepartment = tempDepartment;
    [tempDepartment release];
    
    NSMutableArray *tempCurrentAddArray  = [[NSMutableArray alloc] init];
    self.currentAddArray = tempCurrentAddArray;
    [tempCurrentAddArray release];
}

-(void)loginSuccessfully
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:kMain_DomainChanged])
    {
        [self initData];//初始化所有的数据
        if(self.tableListView)
        {
            [self.tableListView removeFromSuperview];
            self.tableListView = nil;
        }
        [self initTable];//初始化表格
        [self getDefualtData];//初始化数据
        [self.tableListView reloadData];
        //至空
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kMain_DomainChanged];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self performSelector:@selector(getAllUserStatus) withObject:nil afterDelay:0.2];
    //[self getAllUserStatus];//获取所有用户状态
}

-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessfully)
                                                 name:kLoginSuccess
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveAllUserStatus:)
                                                 name:kGetAllUserStatus object:nil];
     
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ON_NOTIFICATION:) name:PARAMTER_KEY_NOTIFY_RELOAD_DATA object:nil];

}

-(void)initTable
{
    PullTableView *atable = [[PullTableView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.tableListView = atable;
    self.tableListView.pullDelegate = self;
    [self.tableListView configRefreshType:OnlyHeaderRefresh];
    //self.tableListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableListView.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:246/255.0f green:239.0/255.0f blue:194/255.0f alpha:1.0];;
    self.tableListView.dataSource = self;
    self.tableListView.delegate = self;
    [atable release];
    
    //cell的下划线
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.tableListView.separatorInset = UIEdgeInsetsMake(kCommonCellHeight - 1, 0, 0, 0);
    }
    [self addSubview:self.tableListView];
}

-(void)initSearchView
{
    if(_isHaveOneRoot)//是否只有一个根
        [_headerButton setFrame:CGRectMake(0, 0, kScreen_Width, kCommonCellHeight-1.0)];
    
    _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-kCommonHeight, kScreen_Width, kCommonHeight)];
    _searchImageView.hidden = YES;
    _searchImageView.userInteractionEnabled = YES;
    _searchImageView.backgroundColor = [UIColor clearColor];
    _searchImageView.image = [UIImage imageNamed:@"searchLink_bg.png"];
    [self addSubview:_searchImageView];
    [_searchImageView release];
    
    //搜索框
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(25, (kCommonCellHeight-25)/2.0+2, 250, 25)];
    [_searchImageView addSubview:_searchTextField];
    _searchTextField.delegate = self;
    _searchTextField.placeholder = kSearchInfo;
    [_searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // textField的文本发生变化时相应事件
    //_searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.returnKeyType = UIReturnKeyDone;
    _searchTextField.backgroundColor = [UIColor clearColor];
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(kScreen_Width - 25 - 25 ,(kCommonCellHeight-25)/2.0+2, 25, 25)];
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.alpha = 0.8;
    [searchBtn setImage:[UIImage imageNamed:@"searchBt.png"] forState:UIControlStateNormal];
    [_searchImageView addSubview:searchBtn];
}

-(void)showOrHideSearchViewWith:(BOOL)flag
{
    _isSearchTextShow = flag;
    if(flag){
        if(_isHaveOneRoot)
            [_headerButton setFrame:CGRectMake(0, kCommonHeight, kScreen_Width, kCommonCellHeight-1.0)];
        _searchImageView.hidden = NO;
        [_searchImageView setFrame:CGRectMake(0, 0, kScreen_Width, kCommonHeight)];
        [self.tableListView setFrame:CGRectMake(0, kCommonHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) -kCommonHeight)];
    }else
    {
        if(_isHaveOneRoot)
            [_headerButton setFrame:CGRectMake(0, 0, kScreen_Width, kCommonCellHeight-1.0)];
        _searchImageView.hidden = YES;
        [self.tableListView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    }
}

#pragma mark - 初始化数据
-(void)getDefualtData
{
    if (_rootDeparmentArray) {
        [_rootDeparmentArray release];
    }
     _rootDeparmentArray = [[[LinkDateCenter sharedCenter] getRootDepartment] retain];
    if([_rootDeparmentArray count] == 1)
    {
        self.rootDepartment = [_rootDeparmentArray lastObject];
        _isHaveOneRoot = YES;
        CGSize titleSize = [_rootDepartment.departmentname sizeWithFont:[UIFont systemFontOfSize:kCommonFont]];
        
        self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerButton setFrame:CGRectMake(0, 0, kScreen_Width, kCommonCellHeight-1.0)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleSize.width, kCommonCellHeight-1.0)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:kCommonFont];
        label.textColor = [UIColor colorWithRed:35 / 255.0 green:24 / 255.0 blue:22 / 255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = _rootDepartment.departmentname;
        [_headerButton addSubview:label];
        [label release];
        
        //_headerButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_headerButton.titleLabel.bounds.size.width+60, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        _headerButton.backgroundColor = kMAIN_BACKGROUND_COLOR;
        [_headerButton addTarget:self action:@selector(showTableView:) forControlEvents:UIControlEventTouchUpInside];
        _headerButton.selected = YES;
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+8,0, 100, kCommonCellHeight-1)];
        _countLabel.text = [NSString stringWithFormat:@"[%ld/%ld]",(long)_rootDepartment.onLineCount,(long)_rootDepartment.allSubUserCount];
        _countLabel.textColor = [UIColor colorWithRed:157 / 255.0 green:157 / 255.0 blue:157 / 255.0 alpha:1.0];
        _countLabel.backgroundColor = [UIColor clearColor];
        [_headerButton addSubview:_countLabel];
        
        //下划线
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_headerButton.frame)+kCommonCellHeight - 1, kScreen_Width, 1.0)];
        [lineImageView setImage:[UIImage imageNamed:@"common_ horizon_line.png"]];
        [_headerButton addSubview:lineImageView];
        [lineImageView release];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width- 7 - 20, (kCommonCellHeight -12)/2.0, 14, 12)];
        _iconImageView.image = [UIImage imageNamed:@"common_down.png"];
        [_headerButton addSubview:_iconImageView];
        [_iconImageView release];
    }
    else
    {
        _isHaveOneRoot = NO;
    }
    
    //将该部门的人加到datasArray中
//    if([[LinkDateCenter sharedCenter] getSubUsersWithDepartmentId:department.departmentid])
//        [self.datasArray addObject:[[LinkDateCenter sharedCenter] getSubUsersWithDepartmentId:department.departmentid]];
    NSArray *departmentArray = nil;
    //只有一个根部门
    if(_isHaveOneRoot)
        departmentArray = [[LinkDateCenter sharedCenter]
                                getSubDepartmentsWithDepartmentId:_rootDepartment.departmentid];
    else
        departmentArray = _rootDeparmentArray;//多个根部门
    
    for (Department *department in departmentArray)
    {
        department.seat = _memorySeat + kLeftMargin;
    }
    if(departmentArray)
        self.datasArray = [NSMutableArray arrayWithArray:departmentArray];
     [self.tableListView reloadData];
}

-(void)showTableView:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(sender.isSelected)
    {
        _iconImageView.image = [UIImage imageNamed:@"common_down.png"];
        [_iconImageView setFrame:CGRectMake(kScreen_Width- 7 - 20, (kCommonCellHeight -12)/2.0, 14, 12)];
        [UIView animateWithDuration:0.3 animations:^{
            if(self.linkViewStyle == LinkDepartmentView_search)
            {   if(_isSearchTextShow)
                    [self.tableListView setFrame:CGRectMake(_tableListView.frame.origin.x, _tableListView.frame.origin.y, CGRectGetWidth(_tableListView.frame), CGRectGetHeight(self.frame) -kCommonHeight)];
                else
                    [self.tableListView setFrame:CGRectMake(_tableListView.frame.origin.x, _tableListView.frame.origin.y, CGRectGetWidth(_tableListView.frame), CGRectGetHeight(self.frame))];
            }
            else
                [self.tableListView setFrame:CGRectMake(_tableListView.frame.origin.x, _tableListView.frame.origin.y, CGRectGetWidth(_tableListView.frame), CGRectGetHeight(self.frame))];
        }];
    }else
    {
        _iconImageView.image = [UIImage imageNamed:@"common_right.png"];
        [_iconImageView setFrame:CGRectMake(kScreen_Width- 2 - 20, (kCommonCellHeight -12)/2.0, 8, 12)];
        [UIView animateWithDuration:0.3 animations:^{
            [_tableListView setFrame:CGRectMake(_tableListView.frame.origin.x, _tableListView.frame.origin.y, CGRectGetWidth(_tableListView.frame), kCommonCellHeight)];
        }];
    }
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.tableViewData objectForKey:@"GroupData"] count];
    return 1;
    //return [[self.tableViewData objectForKey:@"GroupData"] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(_isHaveOneRoot)
        return  _headerButton;
    else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(_isHaveOneRoot)
    return kCommonCellHeight;
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCommonCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    IPhone_CustomListCell *cell = (IPhone_CustomListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    //NSDictionary *cellDic = [NSDictionary dictionary];
    if (cell == nil)
    {
        cell = [[[IPhone_CustomListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
     cell.iconDelegate = self;
    //cell.textLabel.text = [[datasArray objectAtIndex:indexPath.row] objectForKey:@"name"];
//    for (UIView *av in cell.contentView.subviews)
//    {
//        [av removeFromSuperview];
//    }
    CellIConStyle cellIConStyle = 1;
    if(self.linkViewStyle == LinkDepartmentView_select)
        cell.delegate = self;
    if([cell.contentView viewWithTag:121312])
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [[cell.contentView viewWithTag:121312] removeFromSuperview];
    }
    CGFloat seat = 0.0f;
    //移走手势
    for(UIGestureRecognizer *gest in cell.gestureRecognizers)
    {
        if((gest.view.tag == kDepartmentLongGR + indexPath.row)||gest.view.tag == kUserLongGR + indexPath.row)
            [cell removeGestureRecognizer:gest];
    }
    
    NSString *id = @"";
    if([[self.datasArray objectAtIndex:indexPath.row] isKindOfClass:[Department class]])
    {//部门
        if(!(self.linkViewStyle == LinkDepartmentView_select))
        {
            //增加手势
            UILongPressGestureRecognizer *longPressGR = [[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longDepartMentPressed:)] autorelease];
            longPressGR.minimumPressDuration = 0.5;
            [cell addGestureRecognizer:longPressGR];
            longPressGR.view.tag = kDepartmentLongGR + indexPath.row;
        }
        cell.cellSenderStyle = Sender_NoLeaf;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        Department *department = (Department *)[self.datasArray objectAtIndex:indexPath.row];
        cell.selectBtn.selected = department.isSelect;
        
        //更新部门在线和总数
        //[self changeDepartmentOnLineNum:department withCell:cell];
        [cell setNumStr:[NSString stringWithFormat:@" [%ld/%ld]",(long)department.onLineCount,(long)department.allSubUserCount]];
        [cell setTitleStr:department.departmentname];
        seat = department.seat;
        cellIConStyle = Department_icon;
        [cell setHeartStr:@""];
        if(department.isExpand == YES && cell.cellSenderStyle == Sender_NoLeaf )
        {//展开的
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width - 7 - 20, (cell.frame.size.height -12)/2.0, 14, 12)];
            iconImageView.tag = 121312;
            iconImageView.image = [UIImage imageNamed:@"common_down.png"];
            [cell.contentView addSubview:iconImageView];
            [iconImageView release];
        }
    }
    else
    {//用户
        if(!(self.linkViewStyle == LinkDepartmentView_select))
        {
            //增加手势
            UILongPressGestureRecognizer *longPressGR = [[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longUserPressed:)] autorelease];
            longPressGR.minimumPressDuration = 0.5;
            [cell addGestureRecognizer:longPressGR];
            longPressGR.view.tag = kUserLongGR + indexPath.row;
        }
        
        cell.cellSenderStyle = Sender_DetailMess;
        cell.accessoryType = UITableViewCellAccessoryNone;
        User *user = (User *)[self.datasArray objectAtIndex:indexPath.row];
        cell.selectBtn.selected = user.isSelect;
        
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        //[cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        
         cellIConStyle = [self getUserIconSytle:user withCell:cell];
        
        [cell setTitleStr:user.nickname];
        if(!user.field_char1 || [user.field_char1 isEqualToString:@""])
            [cell setHeartStr:@" [这家伙很懒，暂时没有发表心情]"];
        else
            [cell setHeartStr:[NSString stringWithFormat:@"[%@]",user.field_char1]];
        id = [NSString stringWithString:user.userid];
        seat = user.seat;
    }
    
    [cell updateFrameWith:seat withButton:(self.linkViewStyle == LinkDepartmentView_select) withIcon:cellIConStyle withUserId:id];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _memoryIndex = indexPath;
    _index = indexPath.row;
    
   IPhone_CustomListCell *currentCell = (IPhone_CustomListCell *)[self.tableListView cellForRowAtIndexPath:indexPath];
    switch (currentCell.cellSenderStyle) {
        case Sender_DetailMess:
        {
            [self endEditing:YES];
            NSLog(@"点击的是user");
            if(_index > [self.datasArray count])
                return;
            User *user = (User *)[self.datasArray objectAtIndex:_index];
            _memorySeat = user.seat;
            
            if(self.linkViewStyle != LinkDepartmentView_select){
                ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
                ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
                if (_sendOtherMessage) {
                    detail.sendOtherMessage = _sendOtherMessage;
                }
                feed.isGroup = 0;
                feed.relativeId = [user.userid intValue];
                feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
                detail.conFeed = feed;
                [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
                [detail release];
            }

        }
        break;
        case Sender_NoLeaf://表示点击的是department
        {
            NSLog(@"点击的是department");
            if(_index > [self.datasArray count])
                return;
            Department *department = (Department *)[self.datasArray objectAtIndex:_index];
            //部门展开与否
            department.isExpand = !department.isExpand;
            _memorySeat = department.seat;
            if(department.isExpand)
            {
                //展开下级
                [self getSubOfDepartment:department];
                //该部门是展开的
                [_expandDepartArray addObject:department];
                
                currentCell.accessoryType = UITableViewCellAccessoryNone;
                UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(currentCell.frame.size.width - 7 - 20, (currentCell.frame.size.height -12)/2.0, 14, 12)];
                iconImageView.tag = 121312;
                iconImageView.image = [UIImage imageNamed:@"common_down.png"];
                [currentCell.contentView addSubview:iconImageView];
                [iconImageView release];
                
            }else
            {
                NSLog(@"收缩");
                [self closePrevios:department];
                if([currentCell.contentView viewWithTag:121312])
                {
                    currentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [[currentCell.contentView viewWithTag:121312] removeFromSuperview];
                }
                //该部门此时是关闭的
                [self unExpand:department];//移走
            }
        }
            break;
        default:
            break;
    }
}

-(void)getSubOfDepartment:(Department *)department
{
    //获取本级的人员
    NSArray *userArray = [[LinkDateCenter sharedCenter] getSubUsersWithDepartmentId:department.departmentid];
    for(User *user in userArray)
    {
        user.seat = _memorySeat + kLeftMargin;//该级成员显示位置
    }
    //获取该部门下的子部门（一级子部门）
    NSArray *departmentArray = [[LinkDateCenter sharedCenter] getSubDepartmentsWithDepartmentId:department.departmentid];
    
    for(Department *depart in departmentArray)
    {
        depart.seat = _memorySeat + kLeftMargin;//部门的位置
    }
    
    //更新userArray的状态
    [self updateUserStatusMethodWith:userArray];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:userArray];
    
    //更新部门在线人数
    [self updateDepartmentStatusWithArray:departmentArray];
    //按在线状态排序
    //如果是领导组，则不排序(此时改为都不排序)
    //if([department.departmentname rangeOfString:@"领导"].location == NSNotFound)
        //[tempArray sortUsingSelector:@selector(compareUserStatus:)];
    
    if([userArray count] > 0){//用户
        department.usersArray = [NSArray arrayWithArray:tempArray];
        //[self.datasArray insertObjects:userArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_index+1, [userArray count])]];
        
    }
    
    if([departmentArray count] > 0){//部门
        department.departmentsArray = departmentArray;
        //[self.datasArray insertObjects:departmentArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_index+1+[userArray count], [departmentArray count])]];
    }
    
//    if(_currentAddArray)
//    {
//        [_currentAddArray release];
//        _currentAddArray = nil;
//    }
    
    //获取该部门下需要展示的人和部门集合（有些部门可能已经展开了）
    self.currentAddArray = [NSMutableArray array];
    [self updateCurrentAddArray:department];
    //self.currentAddArray = [NSMutableArray arrayWithArray:[self getSubShowOfDepart:department]];
    
    [self.datasArray insertObjects:_currentAddArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_index+1, [_currentAddArray count])]];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for(int i = 0;i < [_currentAddArray count];i++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i+1+_index inSection:0]];
    }
    [self.tableListView beginUpdates];
    [self.tableListView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableListView endUpdates];
    [self.tableListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self reloadChooseIcon];
}

-(void)updateCurrentAddArray:(Department *)department
{
    // NSMutableArray *tempArray = [NSMutableArray array];
    if ([department.usersArray count] > 0||[department.departmentsArray count]){
        //将同一级别的用户先插入
        //[tempArray insertObjects:department.usersArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([tempArray count], [department.usersArray count])]];
        [_currentAddArray insertObjects:department.usersArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_currentAddArray count], [department.usersArray count])]];
        if([department.departmentsArray count] > 0){
            for(Department *depart1 in department.departmentsArray)
            {
                [_currentAddArray addObject:depart1];
                //_expandDepartArray
                for(Department *depart2 in _expandDepartArray)
                {
                    if([depart1.departmentid isEqualToString:depart2.departmentid])
                    {
                        //如果depart在_expandDepartArray有记录，说明它是展开的
                        depart1.seat = depart2.seat;
                        depart1.isExpand = YES;//展开
                        depart1.usersArray = depart2.usersArray;
                        depart1.departmentsArray = depart2.departmentsArray;
                        break;
                    }
                }
                
                if(depart1.isExpand)
                {
                    //如果记录在是展开的
                    //_currentAddArray表示当前插入的数组
                    //self.currentAddArray = [NSMutableArray arrayWithArray:tempArray];
                    //NSMutableArray *currentTempArray = [NSMutableArray arrayWithArray:];
                    [self updateCurrentAddArray:depart1];
                    //[_currentAddArray insertObjects:currentTempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_currentAddArray count], [currentTempArray count])]];
                    //tempArray = [NSMutableArray arrayWithArray:_currentAddArray];
                }
//                else
//                {
//                    _currentAddArray = [NSMutableArray arrayWithArray:tempArray];
//                }
            }
        }
//        else
//        {
//            return tempArray;
//        }
        
    }
    //return tempArray;
}

-(void)unExpand:(Department *)department
{
    for(Department *depart in _expandDepartArray)
    {
        if([depart.departmentid isEqualToString:department.departmentid])
        {
            [_expandDepartArray removeObject:depart];
            break;
        }
    }
}

//关闭子级
-(void)closePrevios:(Department *)department
{
    _totalCount = 0;
    _totalCount = [self getAllTotal:department];
    
    NSRange curretnRange = NSMakeRange(_index+1, _totalCount);
    [self.datasArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:curretnRange]];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for(int i = 0;i < _totalCount;i++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i+1+_index inSection:0]];
    }
    [self.tableListView beginUpdates];
    [self.tableListView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableListView endUpdates];
    
//    //算出展开的行数：展开的用户，子部门
//    for(User *user in department.usersArray)
//    {
//        
//    }
//    
//    for(Department *depart in department.departmentsArray)
//    {
//        
//    }
}

-(NSInteger)getAllTotal:(Department *)department
{
    NSInteger count = 0;
    if ([department.usersArray count] > 0||[department.departmentsArray count] > 0) {
        count = [department.usersArray count];//当前级下的人数
        if([department.departmentsArray count]>0)
        {
            for(Department *depart in department.departmentsArray)
            {
                count = count + 1;//加当前的部门
                if(depart.isExpand)//展开的
                {
                    _totalCount = count + [self getAllTotal:depart];
                    count = _totalCount;
                }
//                else
//                {
//                    _totalCount = count;
//                }
            }
        }
        else
        {
            return count;
        }
    }
    return count;
}



-(NSInteger)getTotal:(Department *)department
{
    NSInteger count = 0;
    if ([department.usersArray count] > 0||[department.departmentsArray count] > 0) {
        count = count + [department.usersArray count];
        if([department.departmentsArray count]>0)
        {
            for(Department *depart in department.departmentsArray)
            {
                count = count + 1;//加当前的部门
                if(depart.isExpand)//展开的
                    count = count + [self getTotal:depart];
            }
        }
        else
        {
            return count;
        }
    }
    return count;
}

- (void)longDepartMentPressed:(UILongPressGestureRecognizer *)sender
{
    if(_customAllertView.tag != kAlertShowTag){
        if(sender.view.tag - kDepartmentLongGR > [self.datasArray count])
            return;
       self._customAllertView = [[[CustomAlertView alloc] initWithAlertStyle:Department_Style withObject:[self.datasArray objectAtIndex:sender.view.tag - kDepartmentLongGR]] autorelease];
        [self addSubview:_customAllertView];
        _customAllertView.tag = 110;
        _customAllertView.delegate = self;
    }
}

- (void)longUserPressed:(UILongPressGestureRecognizer *)sender
{
    if(_customAllertView.tag != kAlertShowTag){
        if(sender.view.tag - kUserLongGR > [self.datasArray count])
            return;
        self._customAllertView = [[[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:[self.datasArray objectAtIndex:sender.view.tag - kUserLongGR]] autorelease];
        [self addSubview:_customAllertView];
        _customAllertView.tag = kAlertShowTag;
        _customAllertView.delegate = self;
    }
}

#pragma mark - LinkSearchResult Delegate
-(void)contactSearchResultAlertViewWith:(id)object withStyel:(ContactBtnStyle)style
{
    if([self.delegate respondsToSelector:@selector(contactAlertViewWith:withStyel:)])
        [self.delegate contactAlertViewWith:object withStyel:style];
}

#pragma mark - CutomAlertView delegate
-(void)contactAlertViewWith:(id)object withStyel:(ContactBtnStyle)style;
{
    if([self.delegate respondsToSelector:@selector(contactAlertViewWith:withStyel:)])
    [self.delegate contactAlertViewWith:object withStyel:style];
}

-(void)CustomeAlertViewDismiss:(CustomAlertView *)alertView
{
    
}

-(void)groupChat:(Department *)deparment
{
    [self.delegate groupChat:deparment];
}


-(void)sendGroupMess:(Department *)department
{
    [self.delegate sendGroupMess:department];
}

-(void)selectCellWith:(IPhone_CustomListCell *)cell withSelected:(BOOL)flag
{
    NSIndexPath *indexPath = [self.tableListView indexPathForCell:cell];
    switch (cell.cellSenderStyle) {
        case Sender_DetailMess:{
            [self chooseUserWith:[(User *)[self.datasArray objectAtIndex:indexPath.row] retain]withSelected:flag];
            NSLog(@"选的是人");
        }
            break;
        case Sender_NoLeaf:{
            [self chooseDepartmentsWith:(Department *)[self.datasArray objectAtIndex:indexPath.row] withSelected:flag];
            NSLog(@"选的是部门");
        }
            break;
        default:
            break;
    }
}

-(void)chooseDepartmentsWith:(Department *)department withSelected:(BOOL)flag
{
    //先添加或删除部门
    if(flag)
    {
        [_choosedDepartments addObject:department];
    }
    else
    {
        NSArray *tempChooseDepartments = [NSArray arrayWithArray:_choosedDepartments];
        for(Department *department1 in tempChooseDepartments)
        {
            if([department.departmentid isEqualToString:department1.departmentid])
                [_choosedDepartments removeObject:department];
        }
    }
    
    //如果一个部门选中了，则将其下的所有的部门和人都选中
    if(flag)
    {
        //选中，则增加到数组中去
        NSArray *usersResult = [[LinkDateCenter sharedCenter] getAllSubUsersArrayWithDepartmentId:department.departmentid];
        NSArray *tempArray = [NSArray arrayWithArray:_choosedUsers];
        if([tempArray count] == 0)
        {
             [_choosedUsers insertObjects:usersResult atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_choosedUsers count], [usersResult count])]];
        }
        else
        {//看用户是否已经存在，不存在，则加入
            for(User *user in usersResult)
            {
                BOOL isHave = NO;
                for(User *user1 in tempArray)
                {
                    if([user.userid isEqualToString:user1.userid]){
                        isHave = YES;
                        break;
                    }
                }
                if(!isHave)
                    [_choosedUsers addObject:user];
            }
        }
        
        //将部门插入
        NSArray *departmentResult = [[LinkDateCenter sharedCenter] getAllSubDepartmentsArrayWithDepartmentId:department.departmentid];
        [_choosedDepartments insertObjects:departmentResult atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([_choosedDepartments count], [departmentResult count])]];
    }else
    {
        NSArray *result = [[LinkDateCenter sharedCenter] getAllSubUsersArrayWithDepartmentId:department.departmentid];
        NSArray *tempArray = [NSArray arrayWithArray:_choosedUsers];
        for(User *user1 in result)
        {
            for(User *user2 in tempArray)
            {
                if([user1.userid isEqualToString:user2.userid])
                {
                    [_choosedUsers removeObject:user2];
                }
            }
        }
        
        NSArray *departmentResult = [[LinkDateCenter sharedCenter] getAllSubDepartmentsArrayWithDepartmentId:department.departmentid];
        NSArray *tempDepartmemtArray = [NSArray arrayWithArray:_choosedDepartments];
        for(Department *department1 in departmentResult)
        {
            for(Department *department2 in tempDepartmemtArray)
            {
                if([department1.departmentid isEqualToString:department2.departmentid])
                {
                    [_choosedDepartments removeObject:department2];
                }
            }
        }
    }
    [self reloadChooseIcon];
}

-(void)chooseUserWith:(User *)user withSelected:(BOOL)flag
{
    if(flag)
    {
        //增加某人
        [self.choosedUsers addObject:user];
    }
    else
    {
        //移走某人
        NSArray *tempChooseUsers = [NSArray arrayWithArray:_choosedUsers];
        for(User *user1 in tempChooseUsers)
        {
            if([user.userid isEqualToString:user1.userid])
                [_choosedUsers removeObject:user1];
        }
    }
    NSLog(@"_choosedUsers-->%lu",(unsigned long)[_choosedUsers count]);
    [self reloadChooseIcon];
}

#pragma mark - 刷新选中的按钮
-(void)reloadChooseIcon
{
    for(id object in self.datasArray)
    {
        NSInteger index = [self.datasArray indexOfObject:object];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        IPhone_CustomListCell *cell = (IPhone_CustomListCell *)[self.tableListView cellForRowAtIndexPath:indexPath];
        
        if([object isKindOfClass:[Department class]])
        {
            Department *department = (Department *)object;
            //是部门
            BOOL isSelect = NO;
            for(Department *department1 in _choosedDepartments)
            {
                if([department.departmentid isEqualToString:department1.departmentid])
                {
                    //说明选中了
                    isSelect = YES;
                    break;
                }
            }
            department.isSelect = isSelect;//是否选中
            if(isSelect)
                cell.selectBtn.selected = YES;
            else
                cell.selectBtn.selected = NO;
        }else if([object isKindOfClass:[User class]])
        {
            User *user = (User *)object;
            BOOL isSelect = NO;
            for(User *user1 in _choosedUsers)
            {
                if([user.userid isEqualToString:user1.userid])
                {
                    //说明选中了
                    isSelect = YES;
                    break;
                }
            }
            user.isSelect = isSelect;//是否选中
            if(isSelect)
                cell.selectBtn.selected = YES;
            else
                cell.selectBtn.selected = NO;
        }
    }
}

-(void)search:(UIButton *)sender
{
    if([_searchTextField.text isEqualToString:@""] || !_searchTextField.text)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入搜索关键字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        return;
    }
    [self addSearchResultView];
}

-(void)addSearchResultView
{
    if(!_linkSearchResultView)
    {
        _linkSearchResultView = [[LinkSearchResultViw alloc] initWithFrame:CGRectMake(0, kCommonHeight, kScreen_Width, CGRectGetHeight(self.frame) - 2)];
        _linkSearchResultView.datasArray = [NSMutableArray arrayWithArray:[[LinkDateCenter sharedCenter] getUsersWithFuzzyUserName:_searchTextField.text]];
        _linkSearchResultView.tag = 113122;
        _linkSearchResultView.delegate = self;
        [self addSubview:_linkSearchResultView];
    }
    else
    {
        _linkSearchResultView.datasArray = [NSMutableArray arrayWithArray:[[LinkDateCenter sharedCenter] getUsersWithFuzzyUserName:_searchTextField.text]];
    }
    
    _linkSearchResultView.adriodStr = _adriodStr;
    _linkSearchResultView.iphoneStr = _iphoneStr;
    _linkSearchResultView.onlineStr = _onlineStr;
    _linkSearchResultView.busyStr = _busyStr;
    _linkSearchResultView.webStr = _webStr;
    _linkSearchResultView.leaveStr = _leaveStr;
    
    if(![self viewWithTag:113122])
    {
        [self addSubview:_linkSearchResultView];
    }
    [_searchTextField resignFirstResponder];
    [_linkSearchResultView reloadResultView];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeySearch;
}


-(void) textFieldDidChange:(UITextField*) textField{
    if([textField.text isEqualToString:@""]||!textField.text)
    {
        if([self viewWithTag:113122]&&_linkSearchResultView)
        {
            [_linkSearchResultView removeFromSuperview];
            [_searchTextField resignFirstResponder];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self search:nil];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    [UIView commitAnimations];
    return YES;
}

#pragma mark - 用户状态的一些操作
-(void)updateUserStatusWith:(User *)user withCell:(IPhone_CustomListCell *)cell
{
    //暂时演示用的 以后一定要和服务器连调正确
    if([user.userid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionId]])
    {
        NSString *sStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kUserRunStatus];
        if (sStatus == nil) {
            sStatus = kUserRunStatusOnline;
        }
        
        if ([sStatus isEqualToString:kUserRunStatusOnline])
        {
            user.userStatus = User_iphoneOnLine;
        }
        else if([sStatus isEqualToString:kUserRunStatusObusyline])
        {
            user.userStatus = User_busy;
            
        }
        else if([sStatus isEqualToString:kUserRunStatusLeave])
        {
            user.userStatus = User_leave;
            
        }
        else if([sStatus isEqualToString:kUserRunStatusHidden])
        {
            user.userStatus = User_hidden;
            
        }
    }

    switch (user.userStatus) {
        case User_offline:
        {
            [cell setPcIconWithImageName:@""];
            [cell setNumStr:@""];
        }
            break;
        case User_online:
        {
            [cell setPcIconWithImageName:@"in-PC1.png"];
            [cell setNumStr:@""];
        }
            break;
        case User_hidden:
        {
            [cell setPcIconWithImageName:@""];
            [cell setNumStr:@"[隐身]"];
        }
            break;
        case User_busy:
        {
            [cell setPcIconWithImageName:@""];
            [cell setNumStr:@"[忙碌]"];
        }
            break;
        case User_andriodOnLine:
        {
            [cell setNumStr:@""];
            [cell setPcIconWithImageName:@"in-Android1.png"];
        }
            break;
        case User_iphoneOnLine:
        {
            [cell setNumStr:@""];
            [cell setPcIconWithImageName:@"in-iPhone1.png"];
        }
            break;
        case User_leave:
        {
            [cell setNumStr:@"[离开]"];
            [cell setPcIconWithImageName:@""];
        }
            break;
        case User_webOnLine:
        {
            [cell setPcIconWithImageName:@"in-PC1.png"];
            [cell setNumStr:@""];
        }
            break;
        default:
        {
            [cell setPcIconWithImageName:@""];
            [cell setNumStr:@""];
        }
            break;
    }
}

-(CellIConStyle)getUserIconSytle:(User *)user withCell:(IPhone_CustomListCell *)cell
{
    CellIConStyle cellIConStyle = 1;
    if([user.sex isEqualToString:@"0"])
    {
        switch (user.userStatus) {
            case User_offline:
                cellIConStyle =  Girl_OffLine;
                break;
            case User_online:
                cellIConStyle = Girl_OnLine;
                break;
            case User_busy:
                cellIConStyle = Girl_BusyLine;
                break;
            case User_webOnLine:
                cellIConStyle = Girl_OnLine;
                break;
            case User_andriodOnLine:
                cellIConStyle = Girl_OnLine;
                break;
            case User_iphoneOnLine:
                cellIConStyle = Girl_OnLine;
                break;
            case User_leave://离开
                cellIConStyle = Girl_Invisible;
                break;
            default:
                cellIConStyle = Girl_OffLine;
                break;
        }
    }
    else
    {
        switch (user.userStatus) {
            case User_offline:
                cellIConStyle =  Boy_OffLine;
                break;
            case User_online:
                cellIConStyle = Boy_OnLine;
                break;
            case User_busy:
                cellIConStyle = Boy_BusyLine;
                break;
            case User_iphoneOnLine:
                cellIConStyle = Boy_OnLine;
                break;
            case User_leave://离开
                cellIConStyle = Boy_Invisible;
                break;
            case User_webOnLine:
                cellIConStyle = Boy_OnLine;
                break;
            case User_andriodOnLine:
                cellIConStyle = Boy_OnLine;
                break;
            default:
                cellIConStyle = Boy_OffLine;
                break;
        }
    }
    return cellIConStyle;
}

#pragma mark - 通过网络请求获取所有用户的在线状态
-(void)getAllUserStatus
{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
    NSArray *msgArr = @[@{@"type": @"req"},@{@"sessionID": sessionId},@{@"cmd":@"pullUserStatusList"}];
    NSString *xmlStr = [UploadXmlMaker getXmlStrFromArr:[NSMutableArray arrayWithArray:msgArr]];
    
    [[YiXinScoketHelper sharedService] sendDataToServer:xmlStr];
}

- (void)receiveAllUserStatus:(NSNotification *)notification
{
    NSDictionary *infoDic = [notification userInfo];
    if (infoDic && [[infoDic objectForKey:@"result"] isEqualToString:@"1"] )
    {
        //分别获取
        self.adriodStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id_list_android"]];
        self.iphoneStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id_list_iphone"]];
        self.busyStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id_list_busy"]];
        self.leaveStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id_list_leave"]];
        self.onlineStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id_list_online"]];
        self.webStr = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id_list_web"]];

        
        if([infoDic objectForKey:@"id_list_android"])
            self.currentAdroidArray = [NSMutableArray arrayWithArray:[_adriodStr componentsSeparatedByString:@","]];
        if([infoDic objectForKey:@"id_list_iphone"])
        self.currentIPhoneArray = [NSMutableArray arrayWithArray:[_iphoneStr componentsSeparatedByString:@","]];
        if([infoDic objectForKey:@"id_list_busy"])
        self.currentBusyArray = [NSMutableArray arrayWithArray:[_busyStr componentsSeparatedByString:@","]];
        if([infoDic objectForKey:@"id_list_leave"])
        self.currentLeaveArray = [NSMutableArray arrayWithArray:[_leaveStr componentsSeparatedByString:@","]];
        if([infoDic objectForKey:@"id_list_online"])
        self.currentOnlineArray = [NSMutableArray arrayWithArray:[_onlineStr componentsSeparatedByString:@","]];
        if([infoDic objectForKey:@"id_list_web"])
        self.currentWebArray = [NSMutableArray arrayWithArray:[_webStr componentsSeparatedByString:@","]];
       
    }
    else
    {
        [ShowAlertView showAlertViewStr:@"获取用户状态失败！"];
    }
    
    NSLog(@"当前andriod在线的人数-->%ld",(unsigned long)[_currentAdroidArray count]);
    NSLog(@"当前iphone在线的人数-->%ld",(unsigned long)[_currentIPhoneArray count]);
    NSLog(@"当前web在线的人数-->%ld",(unsigned long)[_currentWebArray count]);
    NSLog(@"当前online在线的人数-->%ld",(unsigned long)[_currentOnlineArray count]);
    NSLog(@"当前busy在线的人数-->%ld",(unsigned long)[_currentBusyArray count]);
    NSLog(@"当前leave在线的人数-->%ld",(unsigned long)[_currentLeaveArray count]);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        [self updateUserStatusMethod];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if(_isHaveOneRoot)
                [self updateWholeTotalNum];
        });
        
    });
    
    [self updateDepartmentStatus];
    
    if(!_isFirstGetAllStatusFinish)
    {
        _isFirstGetAllStatusFinish = YES;
    }
}
     
 - (void) ON_NOTIFICATION:(NSNotification *) wParam
{
    if ([[wParam name] compare:PARAMTER_KEY_NOTIFY_RELOAD_DATA] == NSOrderedSame){

        NSString *sStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kUserRunStatus];
        if (sStatus == nil) {
            sStatus = kUserRunStatusOnline;
        }
        
        NSString *loginID = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        for(id item in self.datasArray)
        {
            
            if([item isKindOfClass:[User class]])
            {
                User *user = (User *)item;

                if ([user.userid isEqualToString:loginID]) {
                    NSIndexPath *index = [NSIndexPath indexPathForItem:[self.datasArray indexOfObject:item] inSection:0];
                    IPhone_CustomListCell *cell = (IPhone_CustomListCell *)[self.tableListView cellForRowAtIndexPath:index];
                    if ([sStatus isEqualToString:kUserRunStatusOnline])
                    {
                        user.userStatus = User_iphoneOnLine;
                    }
                    else if([sStatus isEqualToString:kUserRunStatusObusyline])
                    {
                        user.userStatus = User_busy;
                        
                    }
                    else if([sStatus isEqualToString:kUserRunStatusLeave])
                    {
                        user.userStatus = User_leave;
                        
                    }
                    else if([sStatus isEqualToString:kUserRunStatusHidden])
                    {
                        user.userStatus = User_hidden;
                        
                    }
                    if (wParam) {
                        [self updateUserStatusAndIconWithUser:user withCell:cell];
                    }
                }
                
            }
        }

    }
}

#pragma mark ========以下是更新部门在线人数============
#pragma mark - 刷新当先已经显示在表格中的部门在线人数（下拉刷新或第一请求用户状态的时候会调用该方法）（通过字符串匹配来实现的！）
-(void)updateDepartmentStatus
{
    for(id item in self.datasArray)
    {
        NSIndexPath *index = [NSIndexPath indexPathForItem:[self.datasArray indexOfObject:item] inSection:0];
        IPhone_CustomListCell *cell = (IPhone_CustomListCell *)[self.tableListView cellForRowAtIndexPath:index];
        if([item isKindOfClass:[Department class]])
        {
            Department *department = (Department *)item;
            department.onLineCount = [self getDepartmentOnlinNumWith:department];
            [cell setNumStr:[NSString stringWithFormat:@" [%ld/%ld]",(long)department.onLineCount,(long)department.allSubUserCount]];
        }
    }
}

#pragma mark - 刷新部门在线人数（每次点击部门展开下级的时候调用该方法）
-(void)updateDepartmentStatusWithArray:(NSArray *)departmentArray
{
    for(id item in departmentArray)
    {
        if([item isKindOfClass:[Department class]])
        {
            Department *department = (Department *)item;
            department.onLineCount = [self getDepartmentOnlinNumWith:department];
        }
    }
}

#pragma mark - 更新总人数（当只有一个根公司的时候会使用该方法）
-(void)updateWholeTotalNum
{
    _rootDepartment.onLineCount = [_currentWebArray count] + [_currentBusyArray count]+ [_currentIPhoneArray count] + [_currentLeaveArray count]+[_currentOnlineArray count]+[_currentAdroidArray count];
    //[self getDepartmentOnlinNumWith:_rootDepartment];
    _countLabel.text = [NSString stringWithFormat:@"[%ld/%ld]",(long)_rootDepartment.onLineCount,(long)_rootDepartment.allSubUserCount];
}

-(NSInteger)getDepartmentOnlinNumWith:(Department *)department
{
    NSString *result = [[LinkDateCenter sharedCenter] getAllSubUsersStrWithDepartmentId:department.departmentid];
    NSInteger count = 0;
    
    for(NSString *userId in _currentAdroidArray)
    {
        if([result rangeOfString:userId].location != NSNotFound )
        {
            count++;
        }
    }
    
    for(NSString *userId in _currentIPhoneArray)
    {
        if([result rangeOfString:userId].location != NSNotFound)
        {
            count++;
        }
    }
    
    for(NSString *userId in _currentWebArray)
    {
        if([result rangeOfString:userId].location != NSNotFound)
        {
            count++;
        }
    }
    
    for(NSString *userId in _currentOnlineArray)
    {
        if([result rangeOfString:userId].location != NSNotFound)
        {
            count++;
        }
    }
    
    for(NSString *userId in _currentLeaveArray)
    {
        if([result rangeOfString:userId].location != NSNotFound)
        {
            count++;
        }
    }
    
    for(NSString *userId in _currentBusyArray)
    {
        if([result rangeOfString:userId].location != NSNotFound)
        {
            count++;
        }
    }
    return count;
}
#pragma mark ========以下是更新用户状态的操作方法============
#pragma mark - 通过字符串匹配来判断某个用户的状态！（速度快，当前采用这种方式）
#pragma mark - updateUserStatusMethod该方法是更新现已经展开所有用户的状态（下拉刷新或第一请求用户状态的时候会调用该方法）
-(void)updateUserStatusMethod
{
    //更新用户图标和状态
    for(id item in self.datasArray)
    {
        NSIndexPath *index = [NSIndexPath indexPathForItem:[self.datasArray indexOfObject:item] inSection:0];
        IPhone_CustomListCell *cell = (IPhone_CustomListCell *)[self.tableListView cellForRowAtIndexPath:index];
        
        if([item isKindOfClass:[User class]])
        {
            User *user = (User *)item;
            [self updateUserStatusAndIconWithUser:user withCell:cell];
            
        }
    }
}

#pragma mark - updateUserStatusMethodWith是更新User对象的在线状态值，然后用用户数组去刷新表格（每次点击部门展开下级的时候调用该方法）
-(void)updateUserStatusMethodWith:(NSArray *)array
{
    //更新用户图标和状态
    for(User *user in array)
    {
            BOOL isHaveStatus = NO;//是否拥有了状态
            if([_adriodStr rangeOfString:user.userid].location !=NSNotFound)
            {
                user.userStatus = User_andriodOnLine;
                /*
                 //更新状态文字
                 [self updateUserStatusWith:user withCell:cell];
                 //更新状态图片
                 [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell]];
                 */
                isHaveStatus = YES;
            }
            
            if(isHaveStatus)
                continue;
            
            if([_iphoneStr rangeOfString:user.userid].location !=NSNotFound)
            {
                user.userStatus = User_iphoneOnLine;
                isHaveStatus = YES;
            }
            
            if(isHaveStatus)
                continue;
            
            if([_webStr rangeOfString:user.userid].location !=NSNotFound)
            {
                user.userStatus = User_webOnLine;
                isHaveStatus = YES;
            }
            
            if(isHaveStatus)
                continue;
            
            
            if([_onlineStr rangeOfString:user.userid].location !=NSNotFound)
            {
                user.userStatus = User_online;
                isHaveStatus = YES;
            }
            
            if(isHaveStatus)
                continue;
            
            
            if([_leaveStr rangeOfString:user.userid].location !=NSNotFound)
            {
                user.userStatus = User_leave;
                isHaveStatus = YES;
            }
            
            if(isHaveStatus)
                continue;
            
            
            if([_busyStr rangeOfString:user.userid].location !=NSNotFound)
            {
                user.userStatus = User_busy;
                isHaveStatus = YES;
            }
    }
}

#pragma mark - 刷新某个用户的状态文字和状态图标
-(void)updateUserStatusAndIconWithUser:(User *)user withCell:(IPhone_CustomListCell *)cell
{
    BOOL isHaveStatus = NO;//是否拥有了状态
    //默认状态为离线
    user.userStatus = User_offline;
    [self updateUserStatusWith:user withCell:cell];
    if([_adriodStr rangeOfString:[NSString stringWithFormat:@"%@,",user.userid]].location !=NSNotFound)
    {
        user.userStatus = User_andriodOnLine;
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        isHaveStatus = YES;
    }
    
    if(isHaveStatus)
        return;
    
    if([_iphoneStr rangeOfString:[NSString stringWithFormat:@"%@,",user.userid]].location !=NSNotFound)
    {
        user.userStatus = User_iphoneOnLine;
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        isHaveStatus = YES;
    }
    
    if(isHaveStatus)
        return;
    
    if([_webStr rangeOfString:[NSString stringWithFormat:@"%@,",user.userid]].location !=NSNotFound)
    {
        user.userStatus = User_webOnLine;
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        isHaveStatus = YES;
    }
    
    if(isHaveStatus)
        return;
    
    if([_onlineStr rangeOfString:[NSString stringWithFormat:@"%@,",user.userid]].location !=NSNotFound)
    {
        user.userStatus = User_online;
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        isHaveStatus = YES;
    }
    
    
    if(isHaveStatus)
        return;
    
    if([_leaveStr rangeOfString:[NSString stringWithFormat:@"%@,",user.userid]].location !=NSNotFound)
    {
        user.userStatus = User_leave;
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        isHaveStatus = YES;
    }
    
    if(isHaveStatus)
        return;
    
    if([_busyStr rangeOfString:[NSString stringWithFormat:@"%@,",user.userid]].location !=NSNotFound)
    {
        user.userStatus = User_busy;
        //更新状态文字
        [self updateUserStatusWith:user withCell:cell];
        //更新状态图片
        [cell changeIconImageViewWith:[self getUserIconSytle:user withCell:cell] withUserid:user.userid];
        isHaveStatus = YES;
    }
}

- (void) refreshTable
{
    [self getAllUserStatus];
    //[self startListenTimer];
    //添加刷新代码
    self.tableListView.pullLastRefreshDate = [NSDate date];
    self.tableListView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    //添加加载代码
    self.tableListView.pullTableIsLoadingMore = NO;
}

#pragma mark - Cell Delegate
-(void)clickIconImageWithUserId:(NSString *)id
{    
    if(![id isEqualToString:@""]){
        NSString *mainURL = [[NSUserDefaults standardUserDefaults] objectForKey:Main_Domain];
        NSString *domainid = [GetContantValue getDomaiId];
        NSString *urlStr = [NSString stringWithFormat:@"http://%@/webimadmin/uploads/avatarSuper/domain_%@/%@.jpg",mainURL,domainid,id];
        if([[HttpReachabilityHelper sharedService] checkNetwork:@""]){
            //有网则下载（先删除本地的），没网则优先读取本地的（没有则下载）
            [[SDImageCache sharedImageCache] removeImageForKey:urlStr];
        }
        NSString *filePath = [NSString stringWithString:[NSString stringWithFormat:@"%@/%@.jpg",[[SynUserIcon sharedManager] getCurrentUserBigIconPath],id]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //看某文件是否存在
        if ([fileManager fileExistsAtPath:filePath] != NO) {//存在则说明有大图
            
            [_enlargView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageWithContentsOfFile:filePath]];
            
            NSArray* windows = [UIApplication sharedApplication].windows;
            UIWindow *currentWindow = [windows objectAtIndex:0];
            
             [currentWindow addSubview:_enlargView];
        }
    }
}

-(void)removeEnlargeView:(UIButton *)sender
{
    [_enlargView removeFromSuperview];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

//启用定时器
- (void)startListenTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    //5分钟
    _timer = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(getAllUserStatus) userInfo:nil repeats:YES];
    [_timer retain];
    [_timer fire];
}
@end
