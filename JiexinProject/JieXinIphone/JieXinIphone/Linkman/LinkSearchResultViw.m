//
//  LinkSearchResultViw.m
//  JieXinIphone
//
//  Created by tony on 14-2-25.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "LinkSearchResultViw.h"
#import "LinkDateCenter.h"
#import "IPhone_CustomListCell.h"
#import "ChatDetailViewController.h"
#import "ChatConversationListFeed.h"
#import "SynUserIcon.h"
#import "HttpReachabilityHelper.h"
#define kDepartmentLongGR 1321313
#define kUserLongGR 1321421

@implementation LinkSearchResultViw
{
    CGFloat _memorySeat;
    NSInteger _index;//当前点击的row
    NSIndexPath *_memoryIndex;
    NSInteger _totalCount;
    NSInteger _previousTotalCount;
    NSMutableArray *_currentAddArray;
    
    UIImageView *_iconImageView;
    
    UITextField *_searchTextField;
    UIButton *_headerButton;
    UIImageView *_enlargView;
}

@synthesize tableListView = _tableListView;
@synthesize datasArray = _datasArray;
@synthesize delegate = _delegate;
@synthesize _customAllertView;

-(void)dealloc
{
    [_enlargView release];
    [_tableListView release];
    [self.datasArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMAIN_BACKGROUND_COLOR;
        self.datasArray = [NSMutableArray array];
        _currentAddArray = [[NSMutableArray alloc] init];
        [self initView];
        // Initialization code
    }
    return self;
}

-(void)initView
{
    UITableView *atable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kCommonCellHeight)];
    self.tableListView = atable;
    //self.tableListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableListView.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:246/255.0f green:239.0/255.0f blue:194/255.0f alpha:1.0];;
    self.tableListView.dataSource = self;
    self.tableListView.delegate = self;
    [atable release];
    
    _enlargView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _enlargView.backgroundColor = [UIColor blackColor];
    _enlargView.contentMode = UIViewContentModeCenter;
    
    UIButton *enlargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enlargeBtn.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    [enlargeBtn setTitle:@"" forState:UIControlStateNormal];
    [enlargeBtn addTarget:self action:@selector(removeEnlargeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _enlargView.userInteractionEnabled = YES;
    [_enlargView addSubview:enlargeBtn];
    
    //cell的下划线
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.tableListView.separatorInset = UIEdgeInsetsMake(kCommonCellHeight - 1, 0, 0, 0);
    }
    [self addSubview:self.tableListView];
    
    [self.tableListView reloadData];
    
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

#pragma mark - 初始化数据

#pragma mark - TableViewDelegate
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
    //cell.textLabel.text = [[datasArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    //    for (UIView *av in cell.contentView.subviews)
    //    {
    //        [av removeFromSuperview];
    //    }
    cell.iconDelegate = self;
    CellIConStyle cellIConStyle = 1;
    if([cell.contentView viewWithTag:121312])
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [[cell.contentView viewWithTag:121312] removeFromSuperview];
    }
    CGFloat seat = 0.0f;
    NSString *id = @"";
    if([[self.datasArray objectAtIndex:indexPath.row] isKindOfClass:[Department class]])
    {//部门
       
    }
    else
    {//用户
        //增加手势
        UILongPressGestureRecognizer *longPressGR = [[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longUserPressed:)] autorelease];
        longPressGR.minimumPressDuration = 0.5;
        [cell addGestureRecognizer:longPressGR];
        longPressGR.view.tag = kUserLongGR + indexPath.row;
        
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
    
   [cell updateFrameWith:seat withButton:NO withIcon:cellIConStyle withUserId:id];
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
            NSLog(@"点击的是user");
            User *user = (User *)[self.datasArray objectAtIndex:_index];
            _memorySeat = user.seat;
            ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
            ChatConversationListFeed  *feed = [[[ChatConversationListFeed alloc] init] autorelease];
            feed.isGroup = 0;
            feed.relativeId = [user.userid intValue];
            feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
            detail.conFeed = feed;
            [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
            [detail release];
        }
            break;
        case Sender_NoLeaf://表示点击的是department
        {
           
        }
            break;
        default:
            break;
    }
}


- (void)longUserPressed:(UILongPressGestureRecognizer *)sender
{
    if(_customAllertView.tag != kAlertShowTag){
        _customAllertView = [[CustomAlertView alloc] initWithAlertStyle:User_Style withObject:[self.datasArray objectAtIndex:sender.view.tag - kUserLongGR]];
        [self addSubview:_customAllertView];
        _customAllertView.tag = kAlertShowTag;
        _customAllertView.delegate = self;
        [_customAllertView release];
    }
}

-(void)contactAlertViewWith:(id)object withStyel:(ContactBtnStyle)style;
{
    if([self.delegate respondsToSelector:@selector(contactSearchResultAlertViewWith:withStyel:)])
        [self.delegate contactSearchResultAlertViewWith:object withStyel:style];
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

-(void)reloadResultView
{
    //更新状态
    [self updateUserStatusMethodWith:self.datasArray];
    [self.tableListView reloadData];
}

#pragma mark - 用户状态的一些操作
#pragma mark - 该方法是打那个tableView展开的时候，刷新用户状态
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
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
