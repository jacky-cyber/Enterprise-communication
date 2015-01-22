//
//  SendOtherViewController.m
//  JieXinIphone
//
//  Created by liqiang on 14-5-13.
//  Copyright (c) 2014年 sunboxsoft. All rights reserved.
//

#import "SendOtherViewController.h"
#import "SendOtherTableViewCell.h"
#import "ChatDataHelper.h"
#import "ChatDetailViewController.h"
#import "SelectSendOtherViewController.h"

//最近联系人 每页12个
#define OnePageCount 12
@interface SendOtherViewController ()

@property (nonatomic, retain) UIView *mainBgView;
@property (nonatomic, retain) PullTableView *listTableView;
@property (nonatomic, retain) NSMutableArray *listArr;
//最近联系人要分页处理
@property (nonatomic, assign) NSInteger nowPage;


@end

@implementation SendOtherViewController

- (void)dealloc
{
    self.listTableView = nil;
    self.mainBgView = nil;
    self.listArr = nil;
    self.sendOtherMessage = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDefaultDatas];

        // Custom initialization
    }
    return self;
}

- (void) initDefaultDatas
{
    self.listArr = [NSMutableArray array];
    self.nowPage = 0;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomNavBarWithoutLogo];
    [self initSubViews];
    
    [self readMoreLastChatPersons];
    // Do any additional setup after loading the view.
}

- (void)initSubViews
{
    //返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.iosChangeFloat, 100, kNavHeight);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(13, 9, 13, 80)];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
    [btn addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.iosChangeFloat, 100, kNavHeight)];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:73.0/255.0 blue:72.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"转发";
    [self.view addSubview:titleLabel];
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.iosChangeFloat +44, kScreen_Width, kScreen_Height  -20-kNavHeight)];
    self.mainBgView = aView;
    [self.view addSubview:_mainBgView];
    [aView release];

    PullTableView *aTableView = [[PullTableView alloc] initWithFrame:_mainBgView.bounds style:UITableViewStylePlain];
    [aTableView configRefreshType:OnlyFooterRefresh];
//    aTableView.pullTableIsLoadingMore = NO;
    aTableView.dataSource =self;
    aTableView.delegate = self;
    aTableView.pullDelegate= self;
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView = aTableView;
    [aTableView release];
    [_mainBgView addSubview:_listTableView];
}

- (void)readMoreLastChatPersons
{
    NSInteger fromIndex = self.nowPage*OnePageCount;
    NSMutableArray *arr = [[ChatDataHelper sharedService] readConversationsListWithFromIndex:fromIndex withPageSize:OnePageCount];
    for(ChatConversationListFeed *feed in arr)
    {
        [_listArr addObject:feed];
    }
    if ([arr count]) {
        [_listTableView reloadData];
        self.nowPage += 1;
    }
    else
    {
        [_listTableView configRefreshType:NoRefresh];
    }
}

- (void)turnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark TableView DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return [_listArr count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSendOtherCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CreatChatCellIdentify=@"cellIdentifySubject";          //创建对话的cell
    static NSString * const SendOtherCellIdentifier = @"SendOtherCellIdentifier";//最近联系人
    //第一行是创建聊天
    if (indexPath.section == 0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CreatChatCellIdentify];
        if (cell==nil) {
            cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CreatChatCellIdentify] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        for(UIView *aView in cell.contentView.subviews)
        {
            [aView removeFromSuperview];
        }
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreen_Width-20, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        titleLabel.center = CGPointMake(kScreen_Width/2, kSendOtherCellHeight/2);
        titleLabel.text = @"创建新的聊天";
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
        return cell;

    }
    else
    {
        SendOtherTableViewCell *cell = (SendOtherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SendOtherCellIdentifier];
        if (!cell)
        {
            cell = [[[SendOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SendOtherCellIdentifier] autorelease];
        }
        ChatConversationListFeed *feed = [_listArr objectAtIndex:indexPath.row];
        [cell setDatas:feed];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        SelectSendOtherViewController *selectSend = [[SelectSendOtherViewController alloc] initWithNibName:nil bundle:nil];
        selectSend.sendOtherMessage = _sendOtherMessage;
        [self.navigationController pushViewController:selectSend animated:YES];
        [selectSend release];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        ChatDetailViewController *detail = [[ChatDetailViewController alloc] initWithNibName:nil bundle:nil];
        ChatConversationListFeed  *feed = [_listArr objectAtIndex:indexPath.row];
        feed.loginId = [[NSUserDefaults standardUserDefaults] objectForKey:kSessionId];
        if (_sendOtherMessage) {
            detail.sendOtherMessage = _sendOtherMessage;
        }
        detail.conFeed = feed;
        [[AppDelegate shareDelegate].rootNavigation pushViewController:detail animated:YES];
        [detail release];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)] autorelease];
        view.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:243/255.0f alpha:1.0f];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, kScreen_Width-20, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"最近联系人";
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        [label release];
        return view;
    }
    return nil;
}



#pragma mark -
#pragma mark Refresh and load more methods

- (void)refreshTable
{
    //刷新代码
    NSLog(@"刷新");
    self.listTableView.pullLastRefreshDate = [NSDate date];
    self.listTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    //加载代码
    NSLog(@"加载");
    [self readMoreLastChatPersons];
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
